//
//  RestaurantViewController.swift
//  Fooder
//
//  Created by Kelley Zhao on 2/7/18.
//  Copyright © 2018 Kelley Zhao. All rights reserved.
//

import UIKit
import GoogleMaps
import UserNotifications

class RestaurantViewController: UIViewController, GMSMapViewDelegate, CLLocationManagerDelegate, UINavigationControllerDelegate {
    
    //restaurant
    var restaurant: Restaurant?
    
    //label
    @IBOutlet weak var restaurantNameLabel: UILabel!
    @IBOutlet weak var restaurantLocationLabel: UILabel!
    
    //button
    @IBOutlet weak var againButton: UIButton!
    
    //map
    @IBOutlet weak var restaurantMapView: GMSMapView?
    var map: GMSMapView?
//    var camera = GMSCameraPosition.camera(withLatitude: 37.621262, longitude: -122.378945, zoom: 15.0)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        GMSServices.provideAPIKey("AIzaSyDQ9Fkj4PDBcxVm0S4IhRHJBoCTPcmyABo")
        
        var location = CLLocationCoordinate2D(latitude: (restaurant?.coordinates.0)!, longitude: (restaurant?.coordinates.1)!)
        print(location)
        var camera = GMSCameraPosition.camera(withLatitude: location.latitude, longitude: location.longitude, zoom: 10.0)
        
        map = GMSMapView.map(withFrame: (restaurantMapView?.frame)!, camera: camera)

//        map?.animate(to: camera)
        restaurantMapView?.addSubview(map!)
//
        print(restaurant!.name)
        restaurantNameLabel.text = restaurant!.name
    }
    
    @IBAction func againButtonPress(_ sender: Any) {
        let nextView = self.storyboard?.instantiateViewController(withIdentifier: "MainViewController") as? MainViewController
        self.navigationController?.pushViewController(nextView!, animated: true)
        print("pushing to main")
    }
    
}

