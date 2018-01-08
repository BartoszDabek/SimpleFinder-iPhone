//
//  GasStation.swift
//  SimpleFinder
//
//  Created by Aramka on 06/01/2018.
//  Copyright © 2018 Aramka. All rights reserved.
//

import Foundation

struct Results {
    let results: [GasStation]
    
    init(json: [String: Any]) {
        results = json["results"] as! [GasStation]
    }
}

public struct GasStation {
    let icon: String
    let name: String
    let vicinity: String
    //  let location: (latitude: Double, longitude: Double)
    //  let geometry: Geometry
    
    init(json: [String: Any]) {
        icon = json["icon"] as! String
        name = json["name"] as! String
        vicinity = json["vicinity"] as! String
        //     let coordinateJSON = json["geometry"] as? String
        //   let geo = coordinateJSON["location"] as? [String: Double]
        // let latitude = geo["lat"] as Double
        //  let longitude = geo["lng"] as Double
        // location = (latitude, longitude)
    }
}

struct Geometry {
    let location: Location
}

struct Location {
    let lat: Float
    let lng: Float
}
