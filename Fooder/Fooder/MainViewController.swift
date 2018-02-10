//
//  MainViewController.swift
//  Fooder
//
//  Created by Kelley Zhao on 2/7/18.
//  Copyright © 2018 Kelley Zhao. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    //labels
    @IBOutlet weak var restaurantNameLabel: UILabel!
    
    //image
    @IBOutlet weak var restaurantImage: UIImageView!
    
    //buttons
    @IBOutlet weak var accountButton: UIButton!
    @IBOutlet weak var yesButton: UIButton!
    @IBOutlet weak var noButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    @IBAction func yesButtonPress(_ sender: Any) {
        print("yes button was pressed")
    }
    
    @IBAction func noButtonPress(_ sender: Any) {
        print("no button was pressed")
    }
    
    
    
    
}

