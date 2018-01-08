//
//  GasStationApi.swift
//  SimpleFinder
//
//  Created by Aramka on 08/01/2018.
//  Copyright © 2018 Aramka. All rights reserved.
//

import Foundation

public struct GasStationApi {
    
    static let baseURL = "https://maps.googleapis.com/maps/api/place/nearbysearch/json?"
    static let API_KEY = "API_KEY"
    
    static func getStations(coordinates: String, radius: Int, completion: @escaping([GasStation]) -> ()) {
        let STATION_TYPE = "gas_station"
        let url = baseURL + "location=\(coordinates)&radius=\(radius)&type=\(STATION_TYPE)&key=\(API_KEY)"
        let request = URLRequest(url: URL(string: url)!)
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            var stationList: [GasStation] = []
            
            if let data = data {
                do {
                    if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String:Any] {
                        if let stations = json["results"] as? [[String:Any]] {
                            for station in stations {
                               // let stationObject = GasStation(json: station)
                                stationList.append(GasStation(json: station))
                            }
                        }
                    }
                } catch {
                    print(error.localizedDescription)
                }
                completion(stationList)
            }
        }
        
        task.resume()
        
    }
}
