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
    let preferences = UserDefaults.standard
    let dark = UIColor.darkGray
    let light = UIColor.white
    let key = "bg-theme"
    let darkString = "Dark"
    let lightString = "Light"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if preferences.object(forKey: key) != nil {
            let currentTheme = preferences.object(forKey: key) as! String
            if(currentTheme == darkString) {
                self.view.backgroundColor = dark
            } else {
                self.view.backgroundColor = light
            }
        }
        
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
    
    override func motionEnded(_ motion: UIEventSubtype, with event: UIEvent?) {
        if event?.subtype == UIEventSubtype.motionShake {
            if preferences.object(forKey: key) == nil {
                self.view.backgroundColor = dark
                preferences.set(darkString, forKey: key)
                preferences.synchronize()
            } else {
                let currentTheme = preferences.object(forKey: key) as! String
                if(currentTheme == darkString) {
                    self.view.backgroundColor = light
                    preferences.set(lightString, forKey: key)
                    preferences.synchronize()
                } else {
                    self.view.backgroundColor = dark
                    preferences.set(darkString, forKey: key)
                    preferences.synchronize()
                }
            }
        }
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
        if(location != nil) {
            let distanceInMeters = Int(distance * 1000)
            let coordinatesAsString = "\(location.coordinate.latitude),\(location.coordinate.longitude)"
            
            GasStationApi.getStations(coordinates: coordinatesAsString, radius: distanceInMeters) { (results:[GasStation]) in
                DispatchQueue.main.async {
                    let gasStationController = self.storyboard?.instantiateViewController(withIdentifier: "GasStationViewController") as! GasStationViewController
                    
                    gasStationController.gasStations = results
                    self.navigationController?.pushViewController(gasStationController, animated: true)
                }
            }
        } else {
            showLocationDisabledPopUp()
        }
    }
    

}
