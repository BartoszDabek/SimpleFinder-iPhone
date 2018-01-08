//
//  ViewController.swift
//  SimpleFinder
//
//  Created by Aramka on 05/01/2018.
//  Copyright © 2018 Aramka. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {

    let manager = CLLocationManager()
    var location: CLLocation!
    var distance: Float = 3

    override func viewDidLoad() {
        super.viewDidLoad()
        distanceLabel.text = String(distance) + " km"
        
        manager.requestWhenInUseAuthorization()

        if(CLLocationManager.locationServicesEnabled()) {
            manager.delegate = self
            manager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            manager.startUpdatingLocation()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        location = locations.first!
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if(status == CLAuthorizationStatus.denied) {
            showLocationDisabledPopUp()
        }
    }
    
    func showLocationDisabledPopUp() {
        let alertController = UIAlertController(title: "Location Access Disabled",
                                                message: "App will not work without this permission!",
                                                preferredStyle: .alert)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        
        let openAction = UIAlertAction(title: "Open Settings", style: .default) { (action) in
            if let url = URL(string: UIApplicationOpenSettingsURLString) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        }
        alertController.addAction(openAction)
        
        self.present(alertController, animated: true, completion: nil)
    }

    @IBOutlet weak var distanceLabel: UILabel!
    
    @IBAction func slider(_ sender: UISlider) {
        let distanceInt = Int(sender.value)
        distance = Float(distanceInt) / 2
        distanceLabel.text = "\(distance) km"
    }
    
    @IBAction func findBtn(_ sender: UIButton) {
        print(distance)
        if(location != nil) {
            let distanceInMeters = Int(distance * 1000)
            let coordinatesAsString = "\(location.coordinate.latitude),\(location.coordinate.longitude)"
            print(location.coordinate.latitude)
            print(location.coordinate.longitude)
            
            GasStationApi.getStations(coordinates: coordinatesAsString, radius: distanceInMeters) { (results:[GasStation]) in
                for result in results {
                    print("\(result) \n")
                }
            }
        } else {
            showLocationDisabledPopUp()
        }
    }
    

}

