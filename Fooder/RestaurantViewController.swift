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
//
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        GMSServices.provideAPIKey("AIzaSyDQ9Fkj4PDBcxVm0S4IhRHJBoCTPcmyABo")
        
        
        let location = CLLocationCoordinate2D(latitude: (restaurant?.coordinates.1)!, longitude: (restaurant?.coordinates.0)!)
        print(location)

        let camera = GMSCameraPosition.camera(withLatitude: location.latitude, longitude: location.longitude, zoom: 15.0)
        
        map = GMSMapView.map(withFrame: (restaurantMapView?.frame)!, camera: camera)
        
        let currentMarker = GMSMarker(position: location)
        currentMarker.map = map!
        currentMarker.title = restaurant!.name

        restaurantMapView?.addSubview(map!)

        print(restaurant!.name)
        print(restaurant!.address)
        print(restaurant!.coordinates)
        restaurantNameLabel.text = restaurant!.name
    }
    
    @IBAction func againButtonPress(_ sender: Any) {
        let nextView = self.storyboard?.instantiateViewController(withIdentifier: "MainViewController") as? MainViewController
        self.navigationController?.pushViewController(nextView!, animated: true)
        print("pushing to main")
    }
    
}

