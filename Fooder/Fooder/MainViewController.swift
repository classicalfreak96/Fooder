//
//  MainViewController.swift
//  Fooder
//
//  Created by Kelley Zhao on 2/7/18.
//  Copyright © 2018 Kelley Zhao. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    //globvarvariables
//    var jsonObject:JSON = []
    var restaurants:[Restaurant] = []
//    var tempRestaurant:Restaurant? = nil
    let restaurantInfo = dataParse()
    
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
        restaurantInfo.getResult{ (json) -> Void in
            if let json = json{
                DispatchQueue.main.async {
                    let tempRestaurant = Restaurant()
                    tempRestaurant.name = "HELLO"
                    print(tempRestaurant.name)
                    var i:Int = 0
                    while (i < json["businesses"].count) {
                        tempRestaurant.name = String(describing: json["businesses"][i]["name"])
                        print("tempRestaurant: " + (tempRestaurant.name))
                        tempRestaurant.address = String(describing: json["businesses"][i]["display_address"])
                        tempRestaurant.imageURL = String(describing: json["businesses"][i]["image_url"])
                        tempRestaurant.distance = String(describing: json["businesses"][i]["distance"])
                        tempRestaurant.rating = String(describing: json["businesses"][i]["rating"])
                        tempRestaurant.reviewCount = String(describing: json["businesses"][i]["review_count"])
                        tempRestaurant.price = String(describing: json["businesses"][i]["price"])
                        if tempRestaurant != nil {
                            self.restaurants.append(tempRestaurant)
                        }
                        i += 1
                    }
                    self.restaurantNameLabel.text = self.restaurants[0].name
                    let urlString = self.restaurants[0].imageURL
                    guard let url = URL(string: urlString) else { return }
                    URLSession.shared.dataTask(with: url) { (data, response, error) in
                        if error != nil {
                            print("Failed fetching image:", error!)
                            return
                        }
                        
                        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                            print("Not a proper HTTPURLResponse or statusCode")
                            return
                        }
                        
                        DispatchQueue.main.async {
                            self.restaurantImage.image = UIImage(data: data!)
                        }
                        }.resume()
                }
            }
            
        }
    }
    
    @IBAction func yesButtonPress(_ sender: Any) {
        print("yes button was pressed")
    }
    
    @IBAction func noButtonPress(_ sender: Any) {
        print("no button was pressed")
    }
    
    
    
    
}

