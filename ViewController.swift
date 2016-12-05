//
//  ViewController.swift
//  map
//
//  Created by Abdulhakim Ajetunmobi on 01/12/2016.
//  Copyright © 2016 abdulajet. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {
    @IBOutlet var map: MKMapView!
    
    var locationManager = CLLocationManager()
   

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        /*
        //annotations
        let annotation = MKPointAnnotation()
        annotation.title = "Uni"
        annotation.subtitle = "City Uni"
        annotation.coordinate = location
        map.addAnnotation(annotation)
        */
        
        let lp = UILongPressGestureRecognizer(target: self, action: #selector(ViewController.longPress(gestureRecognizer:)))
        lp.minimumPressDuration = 2
        map.addGestureRecognizer(lp)
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
        
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let userLocation: CLLocation = locations[0]
        
        let lat = userLocation.coordinate.latitude
        let long = userLocation.coordinate.longitude
        
        let latDelta: CLLocationDegrees = 0.05
        let longDelta: CLLocationDegrees = 0.05
        
        let span = MKCoordinateSpan(latitudeDelta: latDelta, longitudeDelta: longDelta)
        
        let location: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: lat, longitude: long)
        
        let region: MKCoordinateRegion = MKCoordinateRegion(center: location, span: span)
        
        map.setRegion(region, animated: true)
        
        map.showsUserLocation = true
        
        CLGeocoder().reverseGeocodeLocation(userLocation) { (placemarks, error) in
            
            if (error != nil) {
                print("HELP!!!")
            }
            
            if let placemark = placemarks?[0]{
                
                var subTf = ""          //sub throughfare
                var tf = ""             //throughfare
                var subL = ""           //sub locality
                var subA = ""           //sub administration
                var postCode = ""       //post code
                var country = ""        //country
                
                if placemark.subThoroughfare != nil {
                    subTf = placemark.subThoroughfare!
                    print(subTf)
                }
                
                if placemark.thoroughfare != nil {
                    tf = placemark.thoroughfare!
                    print(tf)
                }
                
                if placemark.subLocality != nil {
                    subL = placemark.subLocality!
                    print(subL)
                }
                
                if placemark.subAdministrativeArea != nil {
                    subA = placemark.subAdministrativeArea!
                    print(subA)
                }
                
                if placemark.postalCode != nil {
                    postCode = placemark.postalCode!
                    print(postCode)
                }
                
                if placemark.country != nil {
                    country = placemark.country!
                    print(country)
                }
                
                
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func longPress(gestureRecognizer: UIGestureRecognizer){
        let touchPoint = gestureRecognizer.location(in: self.map)
        let coordinate = map.convert(touchPoint, toCoordinateFrom: self.map)
        
        //annotations
        let annotation = MKPointAnnotation()
        annotation.title = "New place"
        annotation.subtitle = "lets grab a coffee"
        annotation.coordinate = coordinate
        map.addAnnotation(annotation)
        
    }


}

