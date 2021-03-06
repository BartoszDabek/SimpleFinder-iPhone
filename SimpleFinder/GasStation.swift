//
//  GasStation.swift
//  SimpleFinder
//
//  Created by Aramka on 06/01/2018.
//  Copyright © 2018 Aramka. All rights reserved.
//

import Foundation


public struct GasStation {
    let name: String
    let vicinity: String
    var distance: String?
    let location: Location
}

extension GasStation {
    init(json: [String: Any]) {
        name = json["name"] as! String
        vicinity = json["vicinity"] as! String
        
        let geometry = json["geometry"] as! [String:Any]
        let coordinates = geometry["location"] as! [String: Double]
        
        location = Location(location: coordinates)
    }
}


