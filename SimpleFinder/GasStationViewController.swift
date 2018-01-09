//
//  GasStationViewController.swift
//  SimpleFinder
//
//  Created by Aramka on 09/01/2018.
//  Copyright © 2018 Aramka. All rights reserved.
//

import UIKit

class GasStationViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    @IBOutlet weak var viewController: UICollectionView!

    var gasStations:[GasStation] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewController.dataSource = self
        viewController.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return gasStations.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "stationCell", for: indexPath) as! GasStationViewCell
        
        cell.stationName.text = gasStations[indexPath.item].name
        cell.stationVicinity.text = gasStations[indexPath.item].vicinity
        
        return cell
    }
    


}
