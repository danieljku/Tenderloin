//
//  ViewController.swift
//  Tenderloin
//
//  Created by Daniel Ku on 7/5/16.
//  Copyright © 2016 djku. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {
    @IBOutlet weak var mapView: MKMapView!
    let locationManager = CLLocationManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.showsUserLocation = true

        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            self.locationManager.requestWhenInUseAuthorization()
            locationManager.startUpdatingLocation()
        }
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let locValue = locations.last! as CLLocation
        
        let span:MKCoordinateSpan = MKCoordinateSpanMake(0.05, 0.05)
        let location:CLLocationCoordinate2D = CLLocationCoordinate2DMake(mapView.userLocation.coordinate.latitude, mapView.userLocation.coordinate.longitude)
        let region:MKCoordinateRegion = MKCoordinateRegionMake(location, span)
        
        mapView.setRegion(region, animated: true)
        
        let userLocation:CLLocation = CLLocation(latitude: locValue.coordinate.latitude, longitude: locValue.coordinate.longitude)

        let tLocation:CLLocation = CLLocation(latitude: 37.784353, longitude: -122.413439)
        let meters:CLLocationDistance = userLocation.distanceFromLocation(tLocation)

        if (meters >= 500){
            mapView.selectAnnotation(mapView.userLocation, animated: true)
            mapView.tintColor = UIColor.greenColor()
            mapView.userLocation.title = "IM SAFE!"
        }else if(meters < 500 && meters > 250){
            mapView.selectAnnotation(mapView.userLocation, animated: true)
            mapView.tintColor = UIColor.yellowColor()
            mapView.userLocation.title = "YOU ARE IN TENDERLOIN!!"
        }else if(meters <= 250){
            mapView.selectAnnotation(mapView.userLocation, animated: true)
            mapView.tintColor = UIColor.redColor()
            mapView.userLocation.title = "RUNNNNNN!!"
            let alertController = UIAlertController(title: "GTFO YOU'RE IN THE HEART OF TENDERLOIN", message: "", preferredStyle: .Alert)
            let cancelAction = UIAlertAction(title: "AHHHH RUNNN!!!", style: .Cancel){(action) in
            }
            alertController.addAction(cancelAction)
            self.presentViewController(alertController, animated: true){
            }
        }
        
        

    }


}

