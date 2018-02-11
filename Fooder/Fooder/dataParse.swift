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
    
    let headers = [
    "authorization": "Bearer qs3S320dpLk9oWmJgMkfEcCYF5hyimh5mYQwfwmz2MyNkURMMB00g8QBnQ5M6vCZKhlxNACh_8yl6PdOV157JoHxLMr5KVE7XKvaCebSFMihMsCLebE_RMNjbZSAWnYx",
    "cache-control": "no-cache"
    ]
    
    
    func getResult() {
        let request = NSMutableURLRequest(url: NSURL(string: "https://api.yelp.com/v3/transactions/delivery/search?latitude=37.786882&longitude=-122.399972")! as URL, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 10.0)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers
        
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
            if (error != nil) {
                print("error: " + String(describing: error!))
            }
            else {
                let httpResponse = response as? HTTPURLResponse
                print("httpResonse: " + String(describing: httpResponse!))
                let strResponse = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
                print("Response String :\(String(describing: strResponse))")
            }
            })
        dataTask.resume()
    }

    

    
}
