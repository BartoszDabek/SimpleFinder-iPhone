//
//  GasStationViewController.swift
//  SimpleFinder
//
//  Created by Aramka on 09/01/2018.
//  Copyright © 2018 Aramka. All rights reserved.
//

import UIKit
import MapKit

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
        
        cell.stationImage.image = UIImage(named: "gas_station")
        cell.stationName.text = gasStations[indexPath.item].name
        cell.stationVicinity.text = gasStations[indexPath.item].vicinity
        cell.stationDistance.text = gasStations[indexPath.item].distance
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let regionDistance:CLLocationDistance = 1000
        let coordinates = CLLocationCoordinate2D(latitude: gasStations[indexPath.item].location.latitude,
                                                 longitude: gasStations[indexPath.item].location.longitude)
        let regionSpan = MKCoordinateRegionMakeWithDistance(coordinates, regionDistance, regionDistance)
        
        let options = [MKLaunchOptionsMapCenterKey: NSValue(mkCoordinate: regionSpan.center), MKLaunchOptionsMapSpanKey: NSValue(mkCoordinateSpan: regionSpan.span)]
        
        let placemark = MKPlacemark(coordinate: coordinates)
        let mapItem = MKMapItem(placemark: placemark)
        mapItem.name = gasStations[indexPath.item].name
        mapItem.openInMaps(launchOptions: options)
    }
}

