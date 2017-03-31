//
//  ViewController.swift
//  FindMe
//
//  Created by Jigar Parekh on 31/03/17.
//  Copyright © 2017 Next. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class ViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {

    @IBOutlet weak var latLabel: UILabel!
    
    @IBOutlet weak var lonLabel: UILabel!
    
    @IBOutlet weak var altLabel: UILabel!
    
    @IBOutlet weak var speedLabel: UILabel!
    
    @IBOutlet weak var courseLabel: UILabel!
    
    @IBOutlet weak var addressLabel: UILabel!
    
    @IBOutlet weak var map: MKMapView!
    
    var locationManager = CLLocationManager()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let userLocation = locations[0]
        let latitude = userLocation.coordinate.latitude
        let longitude = userLocation.coordinate.longitude
        let latdelta : CLLocationDegrees = 0.005
        let londelta : CLLocationDegrees = 0.005
        let span = MKCoordinateSpan(latitudeDelta: latdelta, longitudeDelta: londelta)
        let location = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        let region = MKCoordinateRegion(center: location, span: span)
        map.setRegion(region, animated: true)
        
        latLabel.text = String(userLocation.coordinate.latitude)
        lonLabel.text = String(userLocation.coordinate.longitude)
        altLabel.text = String(userLocation.altitude)
        speedLabel.text = String(userLocation.speed)
        courseLabel.text = String(userLocation.course)
        
        CLGeocoder().reverseGeocodeLocation(userLocation)
        {
           (placemarks, errors) in
            if errors != nil {
            print(errors)
            }
            else{
                if let placemark = placemarks?[0]
                {
                    var address = ""
                    if placemark.thoroughfare != nil {
                        address += placemark.thoroughfare! + ", "
                    }
                    if placemark.subThoroughfare != nil {
                        address += placemark.subThoroughfare! + ", "
                    }
                    if placemark.subLocality != nil {
                        address += placemark.subLocality! + ", "
                    }
                    if placemark.locality != nil {
                        address += placemark.locality! + ", "
                    }
                    if placemark.postalCode != nil {
                        address += placemark.postalCode! + ", "
                    }
                    if placemark.country != nil {
                        address += placemark.country! + " "
                    }
                    self.addressLabel.text = address
                }
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

