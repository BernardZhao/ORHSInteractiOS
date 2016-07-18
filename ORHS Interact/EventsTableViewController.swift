//
//  EventsTableViewController.swift
//  ORHS Interact
//
//  Created by Bernard Zhao on 7/16/16.
//  Copyright © 2016 Web and App Development. All rights reserved.
//

import Foundation
import SafariServices
import MapKit
import UIKit

class EventsTableViewController: UITableViewController
{
    var events = [Event]()
    let eventsURL: NSURL = NSURL(string: "https://spreadsheets.google.com/feeds/list/1uTxOe8usrx7o460tH3BAL5iPZRVmEyulkIoyGHa_FsQ/od6/public/values?alt=json")!
    var tapGestureRecognizer: UITapGestureRecognizer? = nil
    var mapItem: MKMapItem?
    let geoCoder = CLGeocoder()
    let tapRec = UITapGestureRecognizer()
    var coords: CLLocationCoordinate2D? = nil
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        self.generateEvents(eventsURL)
        self.tableView.reloadData()

        tableView.rowHeight = 123
        tableView.estimatedRowHeight = tableView.rowHeight
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.separatorStyle = .SingleLine
        
        
        
        
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .LightContent
    }
    
    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int
    {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {

        return events.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCellWithIdentifier("CellIdentifier", forIndexPath: indexPath) as! EventListCell
        cell.locationImage?.userInteractionEnabled = true
        cell.locationImage?.tag = indexPath.row
        let tapped: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(EventsTableViewController.imageTapped))
        tapped.numberOfTapsRequired = 1
        cell.locationImage?.addGestureRecognizer(tapped)
        
        
        
        let event = self.events[indexPath.row]
        
        cell.event = event

        return cell
    }
    
    // MARK: - UITableViewDelegate
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath:
        NSIndexPath)
    {
        let selectedEvent = self.events[indexPath.row]
        
        // import SafariServices
        let safariVC = SFSafariViewController(URL: selectedEvent.link!)
        safariVC.view.tintColor = UIColor(red:1.00, green:1.00, blue:0.60, alpha:1.0)
        safariVC.delegate = self
        self.presentViewController(safariVC, animated: true, completion: nil)
    }
    
    // MARK: - Target / Action
    func imageTapped(sender: UITapGestureRecognizer){
        print("Image has been tapped")
    
        let tapLocation = sender.locationInView(self.tableView)
        let indexPath = self.tableView.indexPathForRowAtPoint(tapLocation)
        let address = self.events[indexPath!.row].location
        
        geoCoder.geocodeAddressString(address!, completionHandler: {(placemarks, error) -> Void in
            if((error) != nil){
                print("Error", error)
            }
            if let placemark = placemarks?.first {
                let coordinates:CLLocationCoordinate2D = placemark.location!.coordinate
                
                print(coordinates)
                let regionDistance:CLLocationDistance = 10000
                let regionSpan = MKCoordinateRegionMakeWithDistance(coordinates, regionDistance, regionDistance)
                let options = [
                    MKLaunchOptionsMapCenterKey: NSValue(MKCoordinate: regionSpan.center),
                    MKLaunchOptionsMapSpanKey: NSValue(MKCoordinateSpan: regionSpan.span)
                ]
                let placemark = MKPlacemark(coordinate: coordinates, addressDictionary: nil)
                let mapItem = MKMapItem(placemark: placemark)
                if let mapName = self.events[indexPath!.row].name {
                mapItem.name = "\(mapName)"
                }
                mapItem.openInMapsWithLaunchOptions(options)
            }
        })
        
    }
    
    func generateEvents(url: NSURL)
    {
        let sheets = SpreadsheetIntegration()
        
        sheets.downloadJSON(url) {
            (data: NSData) in
            
            if let jsonDictionary = SpreadsheetIntegration.parseJSONFromData(data){
                
                let eventDictionaries = jsonDictionary["feed"]!["entry"] as! [[String: AnyObject]]
                for x in 0...eventDictionaries.count + 1 {
                    var newEvent = [String]()
                    for y in 0...4{
                        let test: String = eventDictionaries[y]["content"]!["$t"] as! String
                        let myStringArray = test.componentsSeparatedByString(", _")
                        if (x == 0){
                        newEvent.append(myStringArray[x].substringFromIndex(myStringArray[x].startIndex.advancedBy(8)))                        }
                        else {
                        newEvent.append(myStringArray[x].substringFromIndex(myStringArray[x].startIndex.advancedBy(7)))
                        }
                    }
                    
                    self.events.append(Event(myEvents: newEvent))
                    print (self.events[x].name)
                }


            }
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                self.tableView.reloadData()
            })

        }

        
    }
    
}

extension EventsTableViewController : SFSafariViewControllerDelegate
{
    func safariViewControllerDidFinish(controller: SFSafariViewController) {
        controller.dismissViewControllerAnimated(true, completion: nil)
    }
}
