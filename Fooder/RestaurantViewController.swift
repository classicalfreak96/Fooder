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
    
    //label
    @IBOutlet weak var restaurantNameLabel: UILabel!
    @IBOutlet weak var restaurantLocationLabel: UILabel!
    
    //button
    @IBOutlet weak var againButton: UIButton!
    
    //map
    @IBOutlet weak var restaurantMapView: GMSMapView?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    @IBAction func againButtonPress(_ sender: Any) {
        print("again button pressed")
    }
    
}

