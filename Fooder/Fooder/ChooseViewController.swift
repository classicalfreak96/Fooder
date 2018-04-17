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
        UIApplication.shared.isIdleTimerDisabled = true
        super.viewDidLoad()

        self.navigationController?.setNavigationBarHidden(true, animated: true)
        
        restaurantOneImage.image = savedRestaurants[0].images[0]
        restaurantOneImage.animationImages = savedRestaurants[0].images
        restaurantOneImage.animationDuration = 5
        restaurantOneImage.animationRepeatCount = 0
        
        restaurantTwoImage.image = savedRestaurants[1].images[0]
        restaurantTwoImage.animationImages = savedRestaurants[1].images
        restaurantTwoImage.animationDuration = 5
        restaurantTwoImage.animationRepeatCount = 0
        
        restaurantThreeImage.image = savedRestaurants[2].images[0]
        restaurantThreeImage.animationImages = savedRestaurants[2].images
        restaurantThreeImage.animationDuration = 5
        restaurantThreeImage.animationRepeatCount = 0
        
        restaurantFourImage.image = savedRestaurants[3].images[0]
        restaurantFourImage.animationImages = savedRestaurants[3].images
        restaurantFourImage.animationDuration = 5
        restaurantFourImage.animationRepeatCount = 0
        
        
        let tapRestaurantOne = UITapGestureRecognizer(target: self, action: #selector(imageOneTapped(tapGestureRecognizer:)))
        let pressRestaurantOne = UILongPressGestureRecognizer(target: self, action: #selector(imageOnePressed(selector:)))
        restaurantOneImage.isUserInteractionEnabled = true
        restaurantOneImage.addGestureRecognizer(tapRestaurantOne)
        restaurantOneImage.addGestureRecognizer(pressRestaurantOne)
        
        let tapRestaurantTwo = UITapGestureRecognizer(target: self, action: #selector(imageTwoTapped(tapGestureRecognizer:)))
        let pressRestaurantTwo = UILongPressGestureRecognizer(target: self, action: #selector(imageTwoPressed(selector:)))
        restaurantTwoImage.isUserInteractionEnabled = true
        restaurantTwoImage.addGestureRecognizer(tapRestaurantTwo)
        restaurantTwoImage.addGestureRecognizer(pressRestaurantTwo)
        
        let tapRestaurantThree = UITapGestureRecognizer(target: self, action: #selector(imageThreeTapped(tapGestureRecognizer:)))
        let pressRestaurantThree = UILongPressGestureRecognizer(target: self, action: #selector(imageThreePressed(selector:)))
        restaurantThreeImage.isUserInteractionEnabled = true
        restaurantThreeImage.addGestureRecognizer(tapRestaurantThree)
        restaurantThreeImage.addGestureRecognizer(pressRestaurantThree)
        
        let tapRestaurantFour = UITapGestureRecognizer(target: self, action: #selector(imageFourTapped(tapGestureRecognizer:)))
        let pressRestaurantFour = UILongPressGestureRecognizer(target: self, action: #selector(imageFourPressed(selector:)))
        restaurantFourImage.isUserInteractionEnabled = true
        restaurantFourImage.addGestureRecognizer(tapRestaurantFour)
        restaurantFourImage.addGestureRecognizer(pressRestaurantFour)

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
        restaurantOneImage.startAnimating()
        restaurantTwoImage.stopAnimating()
        restaurantThreeImage.stopAnimating()
        restaurantFourImage.stopAnimating()
    }
    
    func imageTwoTapped(tapGestureRecognizer: UITapGestureRecognizer)
    {
        restaurantOneImage.stopAnimating()
        restaurantTwoImage.startAnimating()
        restaurantThreeImage.stopAnimating()
        restaurantFourImage.stopAnimating()
    }
    
    func imageThreeTapped(tapGestureRecognizer: UITapGestureRecognizer)
    {
        restaurantOneImage.stopAnimating()
        restaurantTwoImage.stopAnimating()
        restaurantThreeImage.startAnimating()
        restaurantFourImage.stopAnimating()
    }
    
    func imageFourTapped(tapGestureRecognizer: UITapGestureRecognizer)
    {
        restaurantOneImage.stopAnimating()
        restaurantTwoImage.stopAnimating()
        restaurantThreeImage.stopAnimating()
        restaurantFourImage.startAnimating()
    }
    
    func imageOnePressed(selector: UILongPressGestureRecognizer){
       restaurantPressed(restaurant: savedRestaurants[0])
    }
    
    func imageTwoPressed(selector: UILongPressGestureRecognizer){
        restaurantPressed(restaurant: savedRestaurants[1])
    }
    
    func imageThreePressed(selector: UILongPressGestureRecognizer){
        restaurantPressed(restaurant: savedRestaurants[2])
    }
    
    func imageFourPressed(selector: UILongPressGestureRecognizer){
        restaurantPressed(restaurant: savedRestaurants[3])
    }

    
}

