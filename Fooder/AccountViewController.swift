//
//  AccountViewController.swift
//  Fooder
//
//  Created by Kelley Zhao on 2/7/18.
//  Copyright © 2018 Kelley Zhao. All rights reserved.
//

import UIKit
import GoogleMaps
import UserNotifications
import CoreLocation

class AccountViewController: UIViewController, GMSMapViewDelegate, CLLocationManagerDelegate {
    
    //labels
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var priceRangeLabel: UILabel!
    @IBOutlet weak var radiusLabel: UILabel!
    @IBOutlet weak var searchLabel: UILabel!
    
    //map
    @IBOutlet weak var currentLocationMap: GMSMapView?
    var map: GMSMapView?
    var camera = GMSCameraPosition.camera(withLatitude: 37.621262, longitude: -122.378945, zoom: 15.0)
    var currentPosition: CLLocationCoordinate2D?
    var currentMarker: GMSMarker?
    var locationManager = CLLocationManager()

    
    //textfields
    @IBOutlet weak var priceRangeLow: UITextField!
    @IBOutlet weak var priceRangeHigh: UITextField!
    @IBOutlet weak var radiusInput: UITextField!
    @IBOutlet weak var searchInput: UITextField!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Hide the navigation bar on the this view controller
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Show the navigation bar on other view controllers
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    
    override func viewDidLoad() {
        searchLabel.isHidden = true
        searchInput.isHidden = true
        UIApplication.shared.isIdleTimerDisabled = true
        super.viewDidLoad()
        GMSServices.provideAPIKey("AIzaSyDQ9Fkj4PDBcxVm0S4IhRHJBoCTPcmyABo")
        locationManager.requestAlwaysAuthorization()
        
        map = GMSMapView.map(withFrame: (currentLocationMap?.frame)!, camera: camera)
        self.map?.isMyLocationEnabled = true
        
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.startUpdatingLocation()
        
        currentLocationMap?.addSubview(map!)
    }
    
    @IBAction func priceRangeLowChange(_ sender: Any) {
        print("changed price range low")
    }
    
    @IBAction func priceRangeHighChange(_ sender: Any) {
        print("changed price range high")
    }
    
    
    @IBAction func radiusChange(_ sender: Any) {
        print("changed radius")
    }
    
    @IBAction func searchChange(_ sender: Any) {
        print("changed search input")
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let userLocation = locations.last
        
        camera = GMSCameraPosition.camera(withLatitude: userLocation!.coordinate.latitude,
                                              longitude: userLocation!.coordinate.longitude, zoom: 13.0)

        currentPosition = CLLocationCoordinate2D(latitude: (userLocation!.coordinate.latitude), longitude: (userLocation!.coordinate.longitude))
        
        currentMarker = GMSMarker(position: currentPosition!)
        currentMarker?.map = map!
        currentMarker?.title = "Me!"
        
        map?.animate(to: camera)
        print("LOCATION")
        print(userLocation)
        
        locationManager.stopUpdatingLocation()
    }
    
//     Handle authorization for the location manager.
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .restricted:
            print("Location access was restricted.")
        case .denied:
            print("User denied access to location.")
            // Display the map using the default location.
            map?.isHidden = false
        case .notDetermined:
            print("Location status not determined.")
        case .authorizedAlways: fallthrough
        case .authorizedWhenInUse:
            print("Location status is OK.")
        }
    }
    
    // Handle location manager errors.
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        locationManager.stopUpdatingLocation()
        print("Error: \(error)")
    }
    
}

