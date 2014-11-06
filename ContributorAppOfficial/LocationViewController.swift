//
//  ViewController.swift
//  ContributorAppOfficial
//
//  Created by florian chazal on 9/24/14.
//  Copyright (c) 2014 florian chazal. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class LocationViewController: UIViewController, MKMapViewDelegate, UISearchBarDelegate, CLLocationManagerDelegate {
    
    var itemIdentifier:String!
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var searchBar: UISearchBar!
    var manager: OneShotLocationManager?
    var itemLocation:CLLocationCoordinate2D!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.mapView.delegate = self
        self.searchBar.delegate = self
        

        let longPress = UILongPressGestureRecognizer(target: self, action: "action:")
        longPress.minimumPressDuration = 1.0
        mapView.addGestureRecognizer(longPress)
    }
    

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        manager = OneShotLocationManager()
        manager!.fetchWithCompletion {location, error in
            
            // fetch location or an error
            if let loc:CLLocation = location {
                println("LOCATION from GPS")
                var latitude:CLLocationDegrees = loc.coordinate.latitude
                var longitude:CLLocationDegrees = loc.coordinate.longitude
                var latitudeDelta:CLLocationDegrees = 0.01
                var longitudeDelta:CLLocationDegrees = 0.01
                var span:MKCoordinateSpan = MKCoordinateSpanMake(latitudeDelta, longitudeDelta)
                println("LOCATION INITIATE \(latitude) , \(longitude)")
                var initialLocation:CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude, longitude)
                var initialRegion:MKCoordinateRegion = MKCoordinateRegionMake(initialLocation, span)
                self.mapView.setRegion(initialRegion, animated: true)
            } else if let err = error {
                println("LOCATION ERROR   \(err.localizedDescription)")
            }
            self.manager = nil
        }

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func action(gestureRecognizer:UIGestureRecognizer) {
        var touchPoint = gestureRecognizer.locationInView(self.mapView)
        var newCoord:CLLocationCoordinate2D = mapView.convertPoint(touchPoint, toCoordinateFromView: self.mapView)
        mapView.removeAnnotations(mapView.annotations)
        var newAnotation = MKPointAnnotation()
        newAnotation.coordinate = newCoord
        newAnotation.title = "Your long press pin"
        newAnotation.subtitle = "New Subtitle"
        mapView.addAnnotation(newAnotation)
        itemLocation = newCoord
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
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        if let iloc = itemLocation{
            SwiftCoreDataHelper.addLocationToItem(SwiftCoreDataHelper.getItemFromIdentifier(itemIdentifier)!, latitude:itemLocation.latitude, longitude:itemLocation.longitude)
        }
        if segue.destinationViewController is AddInfoViewController{
            var svc = segue.destinationViewController as AddInfoViewController;
            
            svc.itemIdentifier = itemIdentifier
        }
    }

}

