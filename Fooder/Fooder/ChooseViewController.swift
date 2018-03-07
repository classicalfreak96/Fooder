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

        self.navigationController?.setNavigationBarHidden(true, animated: true)
        
        restaurantOneImage.image = savedRestaurants[0].passedPicture
        restaurantTwoImage.image = savedRestaurants[1].passedPicture
        restaurantThreeImage.image = savedRestaurants[2].passedPicture
        restaurantFourImage.image = savedRestaurants[3].passedPicture
        
        let tapRestaurantOne = UITapGestureRecognizer(target: self, action: #selector(imageOneTapped(tapGestureRecognizer:)))
        restaurantOneImage.isUserInteractionEnabled = true
        restaurantOneImage.addGestureRecognizer(tapRestaurantOne)
        
        let tapRestaurantTwo = UITapGestureRecognizer(target: self, action: #selector(imageTwoTapped(tapGestureRecognizer:)))
        restaurantTwoImage.isUserInteractionEnabled = true
        restaurantTwoImage.addGestureRecognizer(tapRestaurantTwo)
        
        let tapRestaurantThree = UITapGestureRecognizer(target: self, action: #selector(imageThreeTapped(tapGestureRecognizer:)))
        restaurantThreeImage.isUserInteractionEnabled = true
        restaurantThreeImage.addGestureRecognizer(tapRestaurantThree)
        
        let tapRestaurantFour = UITapGestureRecognizer(target: self, action: #selector(imageFourTapped(tapGestureRecognizer:)))
        restaurantFourImage.isUserInteractionEnabled = true
        restaurantFourImage.addGestureRecognizer(tapRestaurantFour)

    }
    
    func restaurantPressed(restaurant: Restaurant) {
        print(restaurant.name)
        
        let nextView = self.storyboard?.instantiateViewController(withIdentifier: "RestaurantViewController") as? RestaurantViewController
        nextView?.restaurant = restaurant
        self.navigationController?.pushViewController(nextView!, animated: true)
        print("pushing")
    }
    
    
    func imageOneTapped(tapGestureRecognizer: UITapGestureRecognizer)
    {
       restaurantPressed(restaurant: savedRestaurants[0])
    }
    
    func imageTwoTapped(tapGestureRecognizer: UITapGestureRecognizer)
    {
        restaurantPressed(restaurant: savedRestaurants[1])
    }
    
    func imageThreeTapped(tapGestureRecognizer: UITapGestureRecognizer)
    {
        restaurantPressed(restaurant: savedRestaurants[2])
    }
    
    func imageFourTapped(tapGestureRecognizer: UITapGestureRecognizer)
    {
        restaurantPressed(restaurant: savedRestaurants[3])
    }
}

