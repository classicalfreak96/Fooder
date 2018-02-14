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
    var restaurants:[Restaurant] = []
    let restaurantInfo = dataParse()
    var savedRestaurants:[Restaurant] = []
    var restaurantArrayCounter:Int = 0
    
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
                    var i:Int = 0
                    while (i < json["businesses"].count) {
                        let tempRestaurant = Restaurant()
                        tempRestaurant.name = String(describing: json["businesses"][i]["name"])
                        print("tempRestaurant: " + (tempRestaurant.name))
                        tempRestaurant.address = String(describing: json["businesses"][i]["display_address"])
                        tempRestaurant.imageURL = String(describing: json["businesses"][i]["image_url"])
                        tempRestaurant.distance = String(describing: json["businesses"][i]["distance"])
                        tempRestaurant.rating = String(describing: json["businesses"][i]["rating"])
                        tempRestaurant.reviewCount = String(describing: json["businesses"][i]["review_count"])
                        tempRestaurant.price = String(describing: json["businesses"][i]["price"])
                        self.restaurants.append(tempRestaurant)
                        i += 1
                    }
                    self.restaurantNameLabel.text = self.restaurants[self.restaurantArrayCounter].name
                    let urlString = self.restaurants[self.restaurantArrayCounter].imageURL
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
        restaurants[restaurantArrayCounter].passedPicture = restaurantImage.image!
        savedRestaurants.append(restaurants[restaurantArrayCounter])
        
        if (savedRestaurants.count == 4) {
            let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "ChooseViewController") as? ChooseViewController
            nextVC?.savedRestaurants = savedRestaurants
            self.navigationController?.pushViewController(nextVC!, animated: true)
            print("pushed")
        }
        else {
            restaurantArrayCounter += 1
            restaurantNameLabel.text = restaurants[restaurantArrayCounter].name
            let urlString = restaurants[restaurantArrayCounter].imageURL
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
            print("yes button was pressed")
        }
    }
    
    @IBAction func noButtonPress(_ sender: Any) {
        restaurantArrayCounter += 1
        restaurantNameLabel.text = restaurants[restaurantArrayCounter].name
        let urlString = restaurants[restaurantArrayCounter].imageURL
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
        print("no button was pressed")
    }
    
}

