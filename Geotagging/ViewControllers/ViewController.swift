//
//  ViewController.swift
//  Geotagging
//
//  Created by Huyanh Hoang on 2016. 4. 23..
//  Copyright © 2016년 baemax. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class ViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate

{
    private var center: CLLocationCoordinate2D?
    
    @IBOutlet weak var Map: MKMapView!
    
    @IBOutlet weak var Address: UILabel!
    
    @IBAction func dropPin(sender: UIButton) {
        
        // Drop Pin after clicking "I have learned something!"

        let annotation = MKPointAnnotation()
        annotation.coordinate = center!
        
        annotation.title = "Pinned"
        
        Map.addAnnotation(annotation)
    }
    
    let locationManager = CLLocationManager()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager.requestAlwaysAuthorization()
        self.locationManager.startUpdatingLocation()

    }
    
    func regionWithGeotification() -> CLCircularRegion {
        let region = CLCircularRegion(center: center!, radius: 1000*1000, identifier: "myRadius")

        return region
    }
    
    // MARK:- CLLocationManagerDelegate
    
    func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        Map.showsUserLocation = (status == .AuthorizedAlways)
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        print(locations)
        
        let myCurrentLoc = locations[locations.count - 1]
        
        // Address.text = "\(myCurrentLoc.description)"
        
        CLGeocoder().reverseGeocodeLocation(myCurrentLoc) { (myPlacements, myError) in
            
            if myError != nil
            {
                // handle error
            }
            
            if let myPlacement = myPlacements?.first
            {
                let Address = "\(myPlacement.locality!) \(myPlacement.country!) \(myPlacement.postalCode!)"
                
                self.Address.text = Address
            }
        }
        
        
        let location = locations.last
        center = CLLocationCoordinate2D(latitude: location!.coordinate.latitude, longitude: location!
            .coordinate.longitude)
        
        let region = MKCoordinateRegion(center: center!, span: MKCoordinateSpan(latitudeDelta: 1,
            longitudeDelta: 1))
        
        self.Map.setRegion(region, animated: true)
        
        self.locationManager.stopUpdatingLocation()
        
        //regionWithGeotification()
    }
    
    func locationManager(manager: CLLocationManager, didFailWithError error: NSError)
    {
        print("Errors: " + error.localizedDescription)
    }
    
}

