//
//  EM_MapViewController.swift
//  AcuBuddy
//
//  Created by Eric Mead on 12/21/15.
//  Copyright © 2015 Eric Mead. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class EM_MapViewController: UIViewController, UITableViewDataSource, UITableViewDelegate,CLLocationManagerDelegate, MKMapViewDelegate, UITextFieldDelegate {
    
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var tableView: UITableView!
    
    var dismissButton = UIButton()
    
    private var locationManager = CLLocationManager()
    
    var currentLocation = CLLocation()
    let regionRadius: CLLocationDistance = 1000
    
    
    var ArrayOfLocalThings: [AnyObject] = []
    
    //list nearby restaurants
    
    
    @IBAction func getButtonTapped(sender: AnyObject) {
        
        let text = textField.text
        
        getLocalThings(text!)
        tableView.reloadData()
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
        
        self.setUpDismissButton(self.view)
        
        mapView.delegate = self
        
        self.getFixPressed(self)
        
        textField.text = "Acupuncturists"
        
        // set initial location in Honolulu
        let initialLocation = CLLocation(latitude: 21.282778, longitude: -157.829444)
        
        //initialLocation = CLLocation(latitude: 40.7608333, longitude: -111.8902778)
        
        centerMapOnLocation(initialLocation)
        
        getLocalThings(textField.text!)
        
    }
    
    
    
    
    func centerMapOnLocation(location: CLLocation) {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate,
            regionRadius * 2.0, regionRadius * 2.0)
        mapView.setRegion(coordinateRegion, animated: true)
    }
    
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath)
        
        let thisItem = ArrayOfLocalThings[indexPath.row]
        cell.textLabel?.text = thisItem[1] as? String
        let itemUrlAsString: String = String(thisItem[2])
        cell.detailTextLabel!.text = itemUrlAsString
        
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ArrayOfLocalThings.count
    }
    
    
    func getLocalThings(category: String) {
        
        ArrayOfLocalThings = []
        
        self.navigationController?.navigationItem.title = ""
        
        let request = MKLocalSearchRequest()
        request.naturalLanguageQuery = category
        request.region = mapView.region
        
        let search = MKLocalSearch(request: request)
        search.startWithCompletionHandler { (response, error) in
            guard let response = response else {
                print("Search error: \(error)")
                return
            }
            
            var name = " "
            var url = NSURL(string: " ")
            var phoneNumber = " "
            print(category)
            print("returned this many entries")
            print(response.mapItems.count)
            if response.mapItems.count > 2 {
                for item in response.mapItems {
                    
                    if let thisItemName = item.name{
                        name = thisItemName
                    }
                    
                    if let thisUrl = item.url {
                        url = thisUrl
                    }
                    
                    if let thisPhoneNum = item.phoneNumber{
                        
                        phoneNumber = thisPhoneNum
                    }
                    
                    let thisArray: [AnyObject] = [item.isCurrentLocation, name, url!, phoneNumber]
                    
                    self.ArrayOfLocalThings.append(thisArray)
                    
                }
            } else {
                self.ArrayOfLocalThings = []
                print("None Available")
            }
            
            print(self.ArrayOfLocalThings)
            
            self.tableView.reloadData()
        }
        
        
        
    }
    
    func getFixPressed(sender: AnyObject) {
        
        locationManager.requestLocation()
        
        
    }
    
    // MARK: CLLocationManagerDelegate
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        print(locations)
        
        self.currentLocation = locationManager.location!
        
        print("your current location is:")
        print("\(currentLocation.coordinate.longitude)")
        print("\(currentLocation.coordinate.latitude)")
        
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(currentLocation.coordinate,
            regionRadius * 2.0, regionRadius * 2.0)
        
        mapView.setRegion(coordinateRegion, animated: true)
        
        centerMapOnLocation(currentLocation)
        
        self.getLocalThings(textField.text!)
        
    }
    
    func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
        print(error)
    }
    
    func mapView(mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
        
        let currentLocation: CLLocation = self.currentLocation
        
        var mapRegion = MKCoordinateRegion()
        
        mapRegion.center.longitude = currentLocation.coordinate.longitude;
        mapRegion.center.latitude = currentLocation.coordinate.latitude;
        mapRegion.span.latitudeDelta = 0.03;
        mapRegion.span.longitudeDelta = 0.03;
        
        mapView.setRegion(mapRegion, animated: true)
        
        
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        
        return true
    }
    
    
    
    //MARK: Various UI Buttons
    func setUpDismissButton(view: UIView){
        
        dismissButton.frame = CGRect(x: 5, y: 5, width: 40, height: 40)
        dismissButton.setTitle("X", forState: .Normal)
        dismissButton.setTitleColor(UIColor.blackColor(), forState: .Normal)
        dismissButton.backgroundColor = UIColor.lightGrayColor()
        dismissButton.addTarget(self, action: "dismissButtonTapped:", forControlEvents: UIControlEvents.TouchUpInside)
        view.addSubview(dismissButton)
        
    }
    
    @IBAction func dismissButtonTapped(sender: AnyObject){
        let nc = NSNotificationCenter.defaultCenter()
        nc.postNotificationName(dismissNotification, object: self)
        UIView.animateWithDuration(0.3) { () -> Void in
            
           self.dismissViewControllerAnimated(true, completion: nil)
            
        }
        
    }
    
    
}


