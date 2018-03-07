//
//  dataParse.swift
//  Fooder
//
//  Created by labuser on 2/11/18.
//  Copyright © 2018 Kelley Zhao. All rights reserved.
//

import Foundation
import UIKit

class dataParse{
    
    var restaurantList:[Restaurant] = []
    let headers = [
        "authorization": "Bearer qs3S320dpLk9oWmJgMkfEcCYF5hyimh5mYQwfwmz2MyNkURMMB00g8QBnQ5M6vCZKhlxNACh_8yl6PdOV157JoHxLMr5KVE7XKvaCebSFMihMsCLebE_RMNjbZSAWnYx",
        "cache-control": "no-cache"
    ]

    //latitude=37.786882&longitude=-122.399972
    
    func getResult(offset: Int, lat: Double, long: Double, handler:@escaping (_ json:JSON?) -> Void) {
        var json:JSON = JSON.null
        let request = NSMutableURLRequest(url: NSURL(string: "https://api.yelp.com/v3/businesses/search?term=restaurants&offset=" + String(offset) + "&latitude=" + String(lat) + "&longitude=" + String(long))! as URL, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 10.0)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers
        
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
            if (error != nil) {
                print("error:\(String(describing: error!))")
            }
            else {
                let strResponse = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
                if let dataFromString = strResponse?.data(using: String.Encoding.utf8.rawValue, allowLossyConversion: false) {
                    do {
                        json = try JSON(data: dataFromString)
                        handler(json)
                    }
                    catch {
                        print("no result")
                    }
                }
            }
//            print("Return Json1 : " + String(describing: json))
        })
        dataTask.resume()
    }
    
    func getRestaurantData(restaurantID: String, handler:@escaping (_ json:JSON?) -> Void) {
        var json:JSON = JSON.null
        print(restaurantID)
        let simpleRestaurantID = restaurantID.folding(options: .diacriticInsensitive, locale: .current)
        let request = NSMutableURLRequest(url: NSURL(string: "https://api.yelp.com/v3/businesses/" + simpleRestaurantID )! as URL, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 10.0)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers
        
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
            if (error != nil) {
                print("error:\(String(describing: error!))")
            }
            else {
                let strResponse = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
                if let dataFromString = strResponse?.data(using: String.Encoding.utf8.rawValue, allowLossyConversion: false) {
                    do {
                        json = try JSON(data: dataFromString)
                        handler(json)
                    }
                    catch {
                        print("no result")
                    }
                }
            }
            //            print("Return Json1 : " + String(describing: json))
        })
        dataTask.resume()
    }

}
