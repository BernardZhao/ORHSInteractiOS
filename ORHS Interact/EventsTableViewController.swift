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
import EventKit

class EventsTableViewController: UITableViewController
{
    var events = [Event]()
    let eventsURL: URL = URL(string: "https://spreadsheets.google.com/feeds/list/1lCS6UsbWjTD0J-M7LACeKhd42BZFn8M4QNHnGRVl_cQ/od6/public/values?alt=json")!
    var tapGestureRecognizer: UITapGestureRecognizer? = nil
    var mapItem: MKMapItem?
    let geoCoder = CLGeocoder()
    let tapRec = UITapGestureRecognizer()
    var coords: CLLocationCoordinate2D? = nil
    var savedEventId : String = " "
    var dateFormat = "h:mma MMMM d, y"
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        self.generateEvents(eventsURL)
        self.tableView.reloadData()

        tableView.rowHeight = 150
        tableView.estimatedRowHeight = tableView.rowHeight
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.separatorStyle = .singleLine
        
    }
    
    override var preferredStatusBarStyle : UIStatusBarStyle {
        return .lightContent
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int
    {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {

        return events.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellIdentifier", for: indexPath) as! EventListCell
        cell.locationBackground?.isUserInteractionEnabled = true
        cell.locationBackground?.tag = (indexPath as NSIndexPath).row
        let tappedImage: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(EventsTableViewController.imageTapped))
        tappedImage.numberOfTapsRequired = 1
        cell.locationBackground?.addGestureRecognizer(tappedImage)
        cell.eventDate?.isUserInteractionEnabled = true
        cell.eventDate?.tag = (indexPath as NSIndexPath).row
        
        let tappedDate: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(EventsTableViewController.dateTapped))
        tappedDate.numberOfTapsRequired = 1
        cell.eventDate?.addGestureRecognizer(tappedDate)
        
        
        
        
        let event = self.events[(indexPath as NSIndexPath).row]
        
        cell.event = event

        return cell
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        print(self.events[indexPath.row].date)
        print("Event date \(getDateObject(date: self.events[indexPath.row].date!))")
        print("Current date \(NSDate())")
        
        if (getDateObject(date: self.events[indexPath.row].date!).compare(NSDate() as Date) == .orderedAscending){
            print("Event \(self.events[indexPath.row].name!) is over.")
            self.animate(cell, 0.2)
        }
        else{
        self.animate(cell, 1)
        }
    }
    
    // MARK: - UITableViewDelegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath:
        IndexPath)
    {
        let selectedEvent = self.events[(indexPath as NSIndexPath).row]
        UIApplication.shared.openURL(selectedEvent.link!
        )        // import SafariServices
        /*
        let safariVC = SFSafariViewController(url: selectedEvent.link! as URL)
        safariVC.view.tintColor = UIColor(red:1.00, green:1.00, blue:0.60, alpha:1.0)
        safariVC.delegate = self
        self.present(safariVC, animated: true, completion: nil)
        */
    }
    
    // MARK: - Target / Action
    func imageTapped(_ sender: UITapGestureRecognizer){
        print("Image has been tapped")
        
        
        let tapLocation = sender.location(in: self.tableView)
        let indexPath = self.tableView.indexPathForRow(at: tapLocation)
        let address = self.events[(indexPath! as NSIndexPath).row].location
        
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
                    MKLaunchOptionsMapCenterKey: NSValue(mkCoordinate: regionSpan.center),
                    MKLaunchOptionsMapSpanKey: NSValue(mkCoordinateSpan: regionSpan.span)
                ]
                let placemark = MKPlacemark(coordinate: coordinates, addressDictionary: nil)
                let mapItem = MKMapItem(placemark: placemark)
                if let mapName = self.events[(indexPath! as NSIndexPath).row].name {
                mapItem.name = "\(mapName)"
                }
                mapItem.openInMaps(launchOptions: options)
            }
        })
        
    }
    

    
    func createEvent(_ eventStore: EKEventStore, title: String, startDate: Date, endDate: Date) {
        let event = EKEvent(eventStore: eventStore)
        
        event.title = title
        event.startDate = startDate
        event.endDate = endDate
        event.calendar = eventStore.defaultCalendarForNewEvents
        
        
        let alertController = UIAlertController(title: title, message: "Do you want to add this event to your calendar?", preferredStyle: .alert)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (action) in
            // ...
        }
        alertController.addAction(cancelAction)
        
        let OKAction = UIAlertAction(title: "OK", style: .default) { (action) in
            print("eventAdded")
            do {
                try eventStore.save(event, span: .thisEvent)
                self.savedEventId = event.eventIdentifier
            } catch {
                print("Event failed to add")
            }
        }
        alertController.addAction(OKAction)
        
        self.present(alertController, animated: true) {
            // ...
        }
        

    }
    func dateTapped(_ sender: UITapGestureRecognizer){
        print("Date has been tapped")
        let eventStore = EKEventStore()
        let tapLocation = sender.location(in: self.tableView)
        let indexPath = self.tableView.indexPathForRow(at: tapLocation)
        let date = self.events[(indexPath! as NSIndexPath).row].date
        print (date)
        let startDate = getDateObject(date: date!)
        /*
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "h:mma MMMM d, y"
        
        
        let startDate = dateFormatter.date(from: date!)
        print("this the startDate")
        print(startDate)
        */
        
        let endDate = startDate.addingTimeInterval(60 * 60) // One hour
        
        if (EKEventStore.authorizationStatus(for: .event) != EKAuthorizationStatus.authorized) {
            eventStore.requestAccess(to: .event, completion: {granted, error in
                self.createEvent(eventStore, title: self.events[(indexPath! as NSIndexPath).row].name!, startDate: startDate, endDate: endDate)
                
            })
        } else {
            self.createEvent(eventStore, title: self.events[(indexPath! as NSIndexPath).row].name!, startDate: startDate, endDate: endDate)
        }
        
        
    }

    func getDateObject(date: String) -> Date{
        print (date)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "h:mma MMMM d, y"
        let startDate = dateFormatter.date(from: date)
        print("this the startDate")
        print(startDate)
        
        return startDate!
    }
    
    func animate(_ cell:UITableViewCell, _ opacity:Float) {
        let view = cell.contentView
        view.layer.opacity = 0.1
        UIView.animate(withDuration: 1,delay:  0, options: .allowUserInteraction, animations: { () -> Void in
            view.layer.opacity = opacity
        }, completion:nil)
    }
    
    func generateEvents(_ url: URL)
    {
        let sheets = SpreadsheetIntegration()
        
        sheets.downloadJSON(url) {
            (data: Data) in
            
            if let jsonDictionary = SpreadsheetIntegration.parseJSONFromData(data){
                
                let eventDictionaries = jsonDictionary["feed"]!["entry"] as! [[String: AnyObject]]
                
                let pretest: String = eventDictionaries[0]["content"]!["$t"] as! String
                let preMyStringArray = pretest.components(separatedBy: ", _")
                
                print(preMyStringArray.count)
                
                for x in 0...preMyStringArray.count-1 {
                    var newEvent = [String]()
                    for y in 0...4{
                        let test: String = eventDictionaries[y]["content"]!["$t"] as! String
                        let myStringArray = test.components(separatedBy: ", _")
                        print (myStringArray.count)
                        // this if statement cuts off the extra space left in the first string that was separated.
                        if (x == 0){
                        newEvent.append(myStringArray[x].substring(from: myStringArray[x].characters.index(myStringArray[x].startIndex, offsetBy: 8)))
                        }
                        else {
                        newEvent.append(myStringArray[x].substring(from: myStringArray[x].characters.index(myStringArray[x].startIndex, offsetBy: 7)))
                        }
                    }
                    
                    self.events.append(Event(myEvents: newEvent))
                    print (self.events[x].name)
                }


            }
            DispatchQueue.main.async(execute: { () -> Void in
                self.tableView.reloadData()
            })

        }

        
    }
    
}

extension EventsTableViewController : SFSafariViewControllerDelegate
{
    func safariViewControllerDidFinish(_ controller: SFSafariViewController) {
        controller.dismiss(animated: true, completion: nil)
    }
}
