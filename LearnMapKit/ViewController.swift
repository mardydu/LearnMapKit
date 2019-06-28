//
//  ViewController.swift
//  LearnMapKit
//
//  Created by Marcel W on 27/06/19.
//  Copyright © 2019 Apple Developer Academy. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController, CLLocationManagerDelegate{

    @IBOutlet weak var mapView: MKMapView!
    let locationManager = CLLocationManager()
    let regionInMeters: Double = 10000
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        checkLocationServices()
    }

    func setupLocationManager(){
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
    }
    
    func checkLocationServices(){
        if CLLocationManager.locationServicesEnabled(){
            setupLocationManager()
            checkLocationAuthorization() 
        }else{
            //show alert ngasitau kalo dia ga ngaktifin location
        }
    }
    
    func centerViewOnUserLocation(){
        if let location = locationManager.location?.coordinate{
            let region = MKCoordinateRegion.init(center: location, latitudinalMeters: regionInMeters, longitudinalMeters: regionInMeters)
            mapView.setRegion(region, animated: true)
        }
        
    }
    
    func checkLocationAuthorization(){
        switch CLLocationManager.authorizationStatus(){
        case.authorizedWhenInUse:
            // do map stuff
            mapView.showsUserLocation = true
            centerViewOnUserLocation()
            locationManager.startUpdatingLocation()
            break
        case.denied:
            // show alert and suggest them to turn on location services
            break
        case.notDetermined:
            // ask for permission to use the location
            locationManager.requestWhenInUseAuthorization()
            break
        case.restricted:
            // tell them what's up, restricted ini kalo ditolak dari parental control untuk ganti status.
            break
        case.authorizedAlways:
            // sebaiknya ga trlalu digunakan karena sekarang user sangat menjaga privasinya.
            break
        }
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else{
            return
        }
        let center = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        let region = MKCoordinateRegion.init(center: center, latitudinalMeters: regionInMeters, longitudinalMeters: regionInMeters)
        mapView.setRegion(region, animated: true)
        
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        checkLocationAuthorization()
    }

}
//
//extension ViewController: CLLocationManagerDelegate{
// ini untuk nge extend dari class viewvontroller di atas
//func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//guard let location = locations.last else{
//    return
//}
//let center = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
//let region = MKCoordinateRegion.init(center: center, latitudinalMeters: regionInMeters, longitudinalMeters: regionInMeters)
//mapView.setRegion(region, animated: true)
//
//}
//
//func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
//    checkLocationAuthorization()
//}
//}
