//
//  ChooseViewController.swift
//  Fooder
//
//  Created by Kelley Zhao on 2/7/18.
//  Copyright © 2018 Kelley Zhao. All rights reserved.
//

import UIKit

class ChooseViewController: UIViewController {
    
    var savedRestaurants:[Restaurant] = []
    var restaurantArrayCounter:Int = 0
    
    //label
    @IBOutlet weak var chooseLabel: UILabel!
    
    //images
    @IBOutlet weak var restaurantOneImage: UIImageView!
    @IBOutlet weak var restaurantTwoImage: UIImageView!
    @IBOutlet weak var restaurantThreeImage: UIImageView!
    @IBOutlet weak var restaurantFourImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        restaurantOneImage.image = savedRestaurants[0].passedPicture
        restaurantTwoImage.image = savedRestaurants[1].passedPicture
        restaurantThreeImage.image = savedRestaurants[2].passedPicture
        restaurantFourImage.image = savedRestaurants[3].passedPicture
    }
    
    
}

