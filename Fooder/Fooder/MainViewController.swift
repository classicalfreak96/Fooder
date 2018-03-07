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
    var pictureCounter: Int = 0
    var offsetCounter: Int = 0
    
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
        DispatchQueue.main.async{
            self.loadRestaurantArray(offset: 0, lat: 37.786882, long: -122.399972)
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
            nextRestaurant()
            print("yes button was pressed")
        }
    }
    
    @IBAction func noButtonPress(_ sender: Any) {
        nextRestaurant()
        print("no button was pressed")
    }
    
    @IBAction func accountButtonPress(_ sender: Any) {
        let nextView = self.storyboard?.instantiateViewController(withIdentifier: "AccountViewController") as? AccountViewController
        self.navigationController?.pushViewController(nextView!, animated: true)
        print("pushing to account")
    }
    
    func loadRestaurantArray(offset: Int, lat: Double, long: Double) {
        restaurantInfo.getResult(offset: offset, lat: lat, long: long){ (json) -> Void in
            if let json = json{
                DispatchQueue.main.async {
                    var i:Int = 0
                    self.restaurants.removeAll()
                    while (i < json["businesses"].count) {
                        let tempRestaurant = Restaurant()
                        tempRestaurant.name = String(describing: json["businesses"][i]["name"])
                        tempRestaurant.address = String(describing: json["businesses"][i]["display_address"])
                        tempRestaurant.imageURL.append(String(describing: json["businesses"][i]["image_url"]))
                        tempRestaurant.distance = String(describing: json["businesses"][i]["distance"])
                        tempRestaurant.rating = String(describing: json["businesses"][i]["rating"])
                        tempRestaurant.reviewCount = String(describing: json["businesses"][i]["review_count"])
                        tempRestaurant.price = String(describing: json["businesses"][i]["price"])
                        tempRestaurant.coordinates = (Double (String(describing: json["businesses"][i]["coordinates"]["longitude"]))!, Double (String( describing: json["businesses"][i]["coordinates"]["latitude"]))!)
                        tempRestaurant.id = String(describing: json["businesses"][i]["id"])
                        self.restaurants.append(tempRestaurant)
                        i += 1
                    }
                    self.restaurants[self.restaurantArrayCounter].imageURL += self.loadRestaurantPictures(restaurantID: self.restaurants[self.restaurantArrayCounter].id)
                    self.restaurantNameLabel.text = self.restaurants[self.restaurantArrayCounter].name
                    let urlString = self.restaurants[self.restaurantArrayCounter].imageURL[0]
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
    
    func loadRestaurantPictures(restaurantID: String) -> [String] {
        var tempURLArray = [String]()
        restaurantInfo.getRestaurantData(restaurantID: restaurantID) { (json) -> Void in
            if let json = json{
                DispatchQueue.main.async {
                    print(json)
                    var i:Int = 0
                    while (i < json["photos"].count) {
                        tempURLArray.append(json["photos"][i].string!)
                        i += 1
                    }
                    print(tempURLArray)
                }
            }
            
        }
        return tempURLArray
    }
    
    func nextRestaurant() {
        restaurantArrayCounter += 1
        if (restaurantArrayCounter == 20) {
            DispatchQueue.main.async{
                self.offsetCounter += 20
                self.loadRestaurantArray(offset: self.offsetCounter, lat: 37.786882, long: -122.399972)
            }
            restaurantArrayCounter = 0;
        }
        restaurants[restaurantArrayCounter].imageURL += loadRestaurantPictures(restaurantID: restaurants[restaurantArrayCounter].id)
        let urlString = restaurants[restaurantArrayCounter].imageURL[0]
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
                self.restaurantNameLabel.text = self.restaurants[self.restaurantArrayCounter].name
                self.restaurantImage.image = UIImage(data: data!)
            }
            }.resume()
    }
    
//    func nextImage() {
//        if
//        pictureCounter += 1
//        let urlString = restaurants[restaurantArrayCounter].imageURL[pictureCounter]
//    }
}

