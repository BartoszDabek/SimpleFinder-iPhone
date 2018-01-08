//
//  Location.swift
//  SimpleFinder
//
//  Created by Aramka on 08/01/2018.
//  Copyright © 2018 Aramka. All rights reserved.
//

import Foundation

struct Location {
    let latitude: Double
    let longitude: Double
}

extension Location {
    init(location: [String:Double]) {
        latitude = location["lat"]!
        longitude = location["lng"]!
    }
}
