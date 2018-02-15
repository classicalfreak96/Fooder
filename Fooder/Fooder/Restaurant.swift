//
//  Restaurant.swift
//  Fooder
//
//  Created by Kelley Zhao on 2/7/18.
//  Copyright © 2018 Kelley Zhao. All rights reserved.
//

import Foundation
import CoreLocation
import UIKit
//import GoogleMaps

class Restaurant {
    var name: String = ""
    var address: String = ""
    var imageURL: String = ""
    var distance: String = ""
    var coordinates: (Double, Double) = (0,0)
    var rating: String = ""
    var price: String = ""
    var reviewCount: String = ""
    var passedPicture: UIImage = UIImage()
}

