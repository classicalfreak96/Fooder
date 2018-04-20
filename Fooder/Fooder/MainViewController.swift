//
//  MainViewController.swift
//  Fooder
//
//  Created by Kelley Zhao on 2/7/18.
//  Copyright © 2018 Kelley Zhao. All rights reserved.
//

import UIKit
import CoreLocation
import UserNotifications

//extension UIImage {
//    public class func gif(asset: String) -> UIImage? {
//        if let asset = NSDataAsset(name: asset) {
//            return UIImage.gif(data: asset.data)
//        }
//        return nil
//    }
//}

class MainViewController: UIViewController, CLLocationManagerDelegate {
    
    //globvarvariables
    var restaurants:[Restaurant] = []
    let restaurantInfo = dataParse()
    var savedRestaurants:[Restaurant] = []
    var restaurantArrayCounter:Int = 0
    var pictureCounter: Int = 0
    var offsetCounter: Int = 0
    var preferredCategories: [String:Int] = [:]
    var dislikedCategories: [String:Int] = [:]
    var currentPosition: CLLocationCoordinate2D?
    var locationManager = CLLocationManager()
    
    
    //labels
    @IBOutlet weak var restaurantNameLabel: UILabel!
    
    //image
    @IBOutlet weak var restaurantImage: UIImageView!
    
    //buttons
    @IBOutlet weak var accountButton: UIButton!
    @IBOutlet weak var yesButton: UIButton!
    @IBOutlet weak var noButton: UIButton!
    @IBOutlet weak var nextPic: UIButton!
    @IBOutlet weak var prevPic: UIButton!
    
    override func viewDidLoad() {
        UIApplication.shared.isIdleTimerDisabled = true
        //        //location manager calls
        //        locationManager.requestAlwaysAuthorization()
        //        locationManager.delegate = self
        //        locationManager.requestWhenInUseAuthorization()
        //        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        //        locationManager.startUpdatingLocation()
        
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        
        super.viewDidLoad()
        self.restaurantNameLabel.text = "Loading"
        self.restaurantImage.image = #imageLiteral(resourceName: "loading2")
        DispatchQueue.main.async{
            
            //            self.loadRestaurantArray(offset: 0, lat: 37.786882, long: -122.399972)
            //            print(self.currentPosition)
            //            self.loadRestaurantArray(offset: 0, lat: (self.currentPosition?.latitude)!, long: (self.currentPosition?.longitude)!)
            
            //location manager calls
            self.locationManager.requestAlwaysAuthorization()
            self.locationManager.delegate = self
            self.locationManager.requestWhenInUseAuthorization()
            self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
            self.locationManager.startUpdatingLocation()
            
        }
        
        yesButton.isHidden = true
        noButton.isHidden = true
        
        
    }
    
    
    //
    //    @IBAction func yesButtonPress(_ sender: Any) {
    //        savedRestaurants.append(restaurants[restaurantArrayCounter])
    //        for item in restaurants[restaurantArrayCounter].categories {
    //            if (preferredCategories[item] != nil) {
    //                preferredCategories[item] = preferredCategories[item]! + 1
    //            }
    //            else {
    //                preferredCategories[item] = 1
    //            }
    //        }
    //        if (savedRestaurants.count == 4) {
    //            let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "ChooseViewController") as? ChooseViewController
    //            nextVC?.savedRestaurants = savedRestaurants
    //            self.navigationController?.pushViewController(nextVC!, animated: true)
    //            print("pushed")
    //        }
    //        else {
    //            nextRestaurant()
    //        }
    //    }
    //
    //    @IBAction func noButtonPress(_ sender: Any) {
    //        for item in restaurants[restaurantArrayCounter].categories {
    //            if (dislikedCategories[item] != nil) {
    //                dislikedCategories[item] = dislikedCategories[item]! + 1
    //            }
    //            else {
    //                dislikedCategories[item] = 1
    //            }
    //        }
    //        print(dislikedCategories)
    //        nextRestaurant()
    //    }
    
    @IBAction func accountButtonPress(_ sender: Any) {
        let nextView = self.storyboard?.instantiateViewController(withIdentifier: "AccountViewController") as? AccountViewController
        self.navigationController?.pushViewController(nextView!, animated: true)
        print("pushing to account")
    }
    
    @IBAction func nextPicbutton(_ sender: Any) {
        nextImage()
    }
    
    @IBAction func prevPicButton(_ sender: Any) {
        prevImage()
    }
    
    @IBAction func restaurantSwipe(_ sender: UIPanGestureRecognizer) {
        let restaurantView = sender.view!
        let point = sender.translation(in: view)
        
        restaurantView.center = CGPoint(x: view.center.x + point.x, y: view.center.y + point.y)
        
        if sender.state == UIGestureRecognizerState.ended {
            
            if restaurantView.center.y < 75 {
                
                UIView.animate(withDuration: 0.3, animations: {
                    restaurantView.center = CGPoint(x: restaurantView.center.x, y: restaurantView.center.y - 200)
                })
                savedRestaurants.append(restaurants[restaurantArrayCounter])
                for item in restaurants[restaurantArrayCounter].categories {
                    if (preferredCategories[item] != nil) {
                        preferredCategories[item] = preferredCategories[item]! + 1
                    }
                    else {
                        preferredCategories[item] = 1
                    }
                }
                
                if (savedRestaurants.count == 4) {
                    let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "ChooseViewController") as? ChooseViewController
                    nextVC?.savedRestaurants = savedRestaurants
                    self.navigationController?.pushViewController(nextVC!, animated: true)
                    print("pushed")
                }
                else {
                    nextRestaurant()
                }
                
                return
            }
            else if restaurantView.center.y > (view.frame.height - 75) {
                
                UIView.animate(withDuration: 0.3, animations: {
                    restaurantView.center = CGPoint(x: restaurantView.center.x, y: restaurantView.center.y + 200)
                    
                })
                for item in restaurants[restaurantArrayCounter].categories {
                    if (dislikedCategories[item] != nil) {
                        dislikedCategories[item] = dislikedCategories[item]! + 1
                    }
                    else {
                        dislikedCategories[item] = 1
                    }
                }
                nextRestaurant()
                return
            }
            UIView.animate(withDuration: 0.5, animations: {
                restaurantView.center = self.view.center
            })
        }
        
        
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
                    self.loadRestaurantData(restaurantID: self.restaurants[self.restaurantArrayCounter].id)
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
    
    func loadRestaurantData(restaurantID: String){
        restaurantInfo.getRestaurantData(restaurantID: restaurantID) { (json) -> Void in
            if let json = json{
                var i:Int = 0
                while (i < json["photos"].count) {
                    self.restaurants[self.restaurantArrayCounter].imageURL.append(json["photos"][i].string!)
                    let urlString = json["photos"][i].string!
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
                            self.restaurants[self.restaurantArrayCounter].images.append(UIImage(data: data!)!)
                        }
                        }.resume()
                    i += 1
                }
                var j:Int = 0
                while (j < json["categories"].count) {
                    self.restaurants[self.restaurantArrayCounter].categories.insert(json["categories"][j]["alias"].string!)
                    j += 1
                }
            }
        }
    }
    
    func nextRestaurant() {
        pictureCounter = 0
        //
        //restaurantArrayCounter += 1

        var skipRestaurant: Bool = true
        while (skipRestaurant){
            print(String(describing: restaurantArrayCounter + 1) + ", " + String(describing: restaurants.count))
            if (restaurantArrayCounter + 1 >= restaurants.count)  {
                print("test success")
                skipRestaurant = false
                restaurantArrayCounter += 1
            }
            else {
//                print(dislikedCategories)
                print("skipping restaurant: " + restaurants[restaurantArrayCounter].name)
                skipRestaurant = false
                restaurantArrayCounter += 1
                for category in restaurants[restaurantArrayCounter].categories {
                    if dislikedCategories[category]! >= 3 {
                        skipRestaurant = true;
                    }
                }
            }
        }
        //
        if (restaurantArrayCounter >= restaurants.count) {
            print("loading new set")
            self.restaurantNameLabel.text = "Loading"
            self.restaurantImage.image = #imageLiteral(resourceName: "loading2")
            DispatchQueue.main.async{
                self.offsetCounter += 20
                //                self.loadRestaurantArray(offset: self.offsetCounter, lat: 37.786882, long: -122.399972)
                self.loadRestaurantArray(offset: self.offsetCounter, lat: (self.currentPosition?.latitude)!, long: (self.currentPosition?.longitude)!)
                self.loadRestaurantData(restaurantID: self.restaurants[self.restaurantArrayCounter].id)
            }
            restaurantArrayCounter = 0;
        }
        else {
            print("not new set");
            loadRestaurantData(restaurantID: restaurants[restaurantArrayCounter].id)
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
    }
    
    //    func removeDislikedCategories() {
    //        var iterator:int = 0
    //        while (iterator < restaurants.count) {
    //            for
    //        }
    //    }
    
    func nextImage() {
        if (pictureCounter < restaurants[restaurantArrayCounter].images.count - 1) {
            pictureCounter += 1
            self.restaurantImage.image = self.restaurants[self.restaurantArrayCounter].images[pictureCounter]
        }
    }
    
    func prevImage() {
        if (pictureCounter > 0) {
            pictureCounter -= 1
            self.restaurantImage.image = self.restaurants[self.restaurantArrayCounter].images[pictureCounter]
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let userLocation = locations.last
        
        //        camera = GMSCameraPosition.camera(withLatitude: userLocation!.coordinate.latitude,
        //                                          longitude: userLocation!.coordinate.longitude, zoom: 13.0)
        
        currentPosition = CLLocationCoordinate2D(latitude: (userLocation!.coordinate.latitude), longitude: (userLocation!.coordinate.longitude))
        
        //        currentMarker = GMSMarker(position: currentPosition!)
        //        currentMarker?.map = map!
        //        currentMarker?.title = "Me!"
        //
        //        map?.animate(to: camera)
        print("LOCATION")
        print(userLocation)
        
        self.loadRestaurantArray(offset: 0, lat: (self.currentPosition?.latitude)!, long: (self.currentPosition?.longitude)!)
        
        locationManager.stopUpdatingLocation()
    }
    
    
    
    //     Handle authorization for the location manager.
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .restricted:
            print("Location access was restricted.")
        case .denied:
            print("User denied access to location.")
        case .notDetermined:
            print("Location status not determined.")
        case .authorizedAlways: fallthrough
        case .authorizedWhenInUse:
            print("Location status is OK.")
        }
    }
    
    // Handle location manager errors.
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        locationManager.stopUpdatingLocation()
        print("Error: \(error)")
    }
    
    
}

