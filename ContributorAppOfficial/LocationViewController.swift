//
//  ViewController.swift
//  ContributorAppOfficial
//
//  Created by florian chazal on 9/24/14.
//  Copyright (c) 2014 florian chazal. All rights reserved.
//

import UIKit
import MapKit

class LocationViewController: UIViewController, MKMapViewDelegate {
    
    @IBOutlet weak var mapView: MKMapView!
    override func viewDidLoad() {
        super.viewDidLoad()
        var latitude:CLLocationDegrees = 48.399193
        var longitude:CLLocationDegrees = 9.993341
        var latitudeDelta:CLLocationDegrees = 0.01
        var longitudeDelta:CLLocationDegrees = 0.01
        
        var span:MKCoordinateSpan = MKCoordinateSpanMake(latitudeDelta, longitudeDelta)
        
        var initialLocation:CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude, longitude)
        var initialRegion:MKCoordinateRegion = MKCoordinateRegionMake(initialLocation, span)
        self.mapView.setRegion(initialRegion, animated: true)
        var itemAnnotation = MKPointAnnotation()
        itemAnnotation.setCoordinate(initialLocation)
        itemAnnotation.title = "Item Title"
        mapView.addAnnotation(itemAnnotation)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

