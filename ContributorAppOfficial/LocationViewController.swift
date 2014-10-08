//
//  ViewController.swift
//  ContributorAppOfficial
//
//  Created by florian chazal on 9/24/14.
//  Copyright (c) 2014 florian chazal. All rights reserved.
//

import UIKit
import MapKit
import CoreData

class LocationViewController: UIViewController, MKMapViewDelegate {
    
    @IBOutlet weak var mapView: MKMapView!
    override func viewDidLoad() {
        super.viewDidLoad()
        var latitude:CLLocationDegrees = 48.399193
        var longitude:CLLocationDegrees = 9.993341
        var latitudeDelta:CLLocationDegrees = 0.01
        var longitudeDelta:CLLocationDegrees = 0.01
        
        var appDelegate = (UIApplication.sharedApplication().delegate as AppDelegate)
        var context:NSManagedObjectContext = appDelegate.managedObjectContext!
        
        var request = NSFetchRequest(entityName: "Image")
        request.returnsObjectsAsFaults = false;
        
        var results: NSArray = context.executeFetchRequest(request,error: nil)!
        if (results.count > 0){
            for result in results{
                let singleImage:Image = result as Image
                println("getting back longitude and latitude")
                println(singleImage.latitude)
                println(singleImage.longitude)
                latitude = singleImage.latitude
                longitude = singleImage.longitude
            }
        }
        else{
            println("No image found in DB!")
        }
   
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

