//
//  ViewController.swift
//  SimpleFinder
//
//  Created by Aramka on 05/01/2018.
//  Copyright © 2018 Aramka. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var distance: Float = 3;
    

    override func viewDidLoad() {
        super.viewDidLoad()
        distanceLabel.text = String(distance) + " km"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBOutlet weak var distanceLabel: UILabel!
    @IBAction func slider(_ sender: UISlider) {
        let distanceInt = Int(sender.value)
        distance = Float(distanceInt) / 2
        distanceLabel.text = String(distance) + " km"
    }

}

