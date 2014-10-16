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

class LocationViewController: UIViewController, MKMapViewDelegate, UISearchBarDelegate {
    
    var itemIndetifier:String!
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var searchBar: UISearchBar!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.mapView.delegate = self
        self.searchBar.delegate = self
        
        var latitude:CLLocationDegrees = 48.399193
        var longitude:CLLocationDegrees = 9.993341
        var latitudeDelta:CLLocationDegrees = 0.01
        var longitudeDelta:CLLocationDegrees = 0.01
        
        if(!itemIndetifier.isEmpty){
        var item:Item = getItem(itemIndetifier)
            var image:Image = item.image.anyObject() as Image
            if(image.latitude != 0 && image.longitude != 0){
            latitude = image.latitude
            longitude = image.longitude
            }
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
    
    func getItem(itemId:String) -> Item {
        var item:Item!
        var appDelegate = (UIApplication.sharedApplication().delegate as AppDelegate)
        var context:NSManagedObjectContext = appDelegate.managedObjectContext!
        
        var request = NSFetchRequest(entityName: "Item")
        request.returnsObjectsAsFaults = false;
        println("search for item with identifier " + itemId)
        //request.predicate = NSPredicate(format: "identifier = %@",itemId)
        var results: NSArray = context.executeFetchRequest(request,error: nil)!
        if (results.count > 0){
            for result in results{
                item = result as Item
                println("FOUND THE ITEM")
            }
        }
        else{
            println("No item with id " + itemIndetifier + " found in DB!")
        }
        return item
    }
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        self.searchBar.resignFirstResponder()
        println("searchBarBUttonCLicked Called !")
        var geocoder = CLGeocoder()
        geocoder.geocodeAddressString(self.searchBar.text,  {(placemarks: [AnyObject]!, error: NSError!) -> Void in
            if let placemark = placemarks?[0] as? CLPlacemark {
                println("Place Mark Found")
                self.mapView.addAnnotation(MKPlacemark(placemark: placemark))
                
            }
        })
    }

}

