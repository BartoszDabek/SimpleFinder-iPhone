//
//  GasStationApi.swift
//  SimpleFinder
//
//  Created by Aramka on 08/01/2018.
//  Copyright © 2018 Aramka. All rights reserved.
//

import Foundation

public struct GasStationApi {
    
    static let baseURL = "https://maps.googleapis.com/maps/api/"
    static let API_KEY = "API_KEY"
    
    static func getStations(coordinates: String, radius: Int, completion: @escaping([GasStation]) -> ()) {
        let STATION_TYPE = "gas_station"
        let url = baseURL + "place/nearbysearch/json?location=\(coordinates)&radius=\(radius)&type=\(STATION_TYPE)&key=\(API_KEY)"
        let request = URLRequest(url: URL(string: url)!)
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            var stationList: [GasStation] = []
            
            if let data = data {
                do {
                    if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String:Any] {
                        if let stations = json["results"] as? [[String:Any]] {
                            for station in stations {
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
    
    static func getDistances(origins: String, desinations: String, completion: @escaping(String) -> ()) {
        let url = baseURL + "distancematrix/json?origins=\(origins)&destinations=\(desinations)&key=\(API_KEY)"
        let request = URLRequest(url: URL(string: url)!)
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            var distanceResponse: String
            
            if let data = data {
                do {
                    if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String:Any] {
                        if let rows = json["rows"] as? [[String:Any]] {
                            for row in rows {
                                if let elements = row["elements"] as? [[String:Any]] {
                                    for element in elements {
                                        if let distance = element["distance"] as? [String:Any] {
                                            distanceResponse = (distance["text"] as? String)!
                                            completion(distanceResponse)
                                        }
                                    }
                                }
                            }
                        }
                    }
                } catch {
                    print(error.localizedDescription)
                }
            }
        }
        task.resume()
    }
    
    
}
