//
//  SpreadsheetIntegration.swift
//  ORHS Interact
//
//  Created by Bernard Zhao on 7/11/16.
//  Copyright © 2016 Web and App Development. All rights reserved.
//

import Foundation
class SpreadsheetIntegration{
    /*
    let eventsURL: NSURL = NSURL(string: "https://spreadsheets.google.com/tq?key=1uTxOe8usrx7o460tH3BAL5iPZRVmEyulkIoyGHa_FsQ")!
    let hoursURL: NSURL = NSURL(string: "https://spreadsheets.google.com/tq?key=13CkOpYGJA3V6fOwlli6XAu133F7TptnIW-eZjFhDZjc")!
    
    var nameList = [String]()
    var dateList = [String]()
    var linkList = [String]()
    var locationList = [String]()
    var descriptionList = [String]()
    var hours = Int()
    */
    lazy var configuration: NSURLSessionConfiguration = NSURLSessionConfiguration.defaultSessionConfiguration()
    lazy var session: NSURLSession = NSURLSession(configuration: self.configuration)
    

    
    init() {

    }
    
    
    /*
    
    func downloadAndParseEvents()
    {
        
        let request = NSURLRequest(URL: self.eventsURL)
        let dataTask = session.dataTaskWithRequest(request) { (data, response, error) in
            
            if error == nil {
                if let httpResponse = response as? NSHTTPURLResponse {
                    switch (httpResponse.statusCode) {
                    case 200:
                        if let data = data {
                            do {
                                
                                if let jsonDictionary = try NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers) as? [String : AnyObject]
                                
                                {
                                    
                                    let eventDictionaries = jsonDictionary["feed"]!["entry"] as! [[String: AnyObject]]
                                    for x in 0...eventDictionaries.count + 1 {
                                        var newEvent = [String]()
                                        for y in 0...4{
                                            let test: String = eventDictionaries[y]["content"]!["$t"] as! String
                                            let myStringArray = test.componentsSeparatedByString(",")
                                            newEvent.append(myStringArray[x].substringFromIndex(myStringArray[x].startIndex.advancedBy(8)))
                                        }
                                        
                                        self.events.append(Event(myEvents: newEvent))
                                        print (self.events[x].description)
                                    }
                                    dispatch_async(dispatch_get_main_queue()) {
                                        //HomeViewController.reloadData()
                                    }
                                    
                                }
                                
                            } catch let error as NSError {
                                print("error processing json data: \(error.localizedDescription)")
                                
                            }
                        }
                    default:
                        print(httpResponse.statusCode)
                    }
                }
            } else {
                print("Error: \(error?.localizedDescription)")
            }
        }
        
        dataTask.resume()
    }
 
 */
    
    typealias DataHandler = (NSData -> Void)
    
    func downloadJSON(input: NSURL, completion: DataHandler)
    {
        let request = NSURLRequest(URL: input)
        let dataTask = session.dataTaskWithRequest(request) { (data, response, error) in
            
            if error == nil {
                if let httpResponse = response as? NSHTTPURLResponse {
                    switch (httpResponse.statusCode) {
                    case 200:
                        if let data = data {
                            completion(data)
                        }
                    default:
                        print(httpResponse.statusCode)
                    }
                }
            } else {
                print("Error: \(error?.localizedDescription)")
            }
        }
        
        dataTask.resume()
    }
    
    

}

extension SpreadsheetIntegration
{
    static func parseJSONFromData(jsonData: NSData?) -> [String : AnyObject]?
    {
        if let data = jsonData {
            do {
                let jsonDictionary = try NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers) as? [String : AnyObject]
                return jsonDictionary
                
            } catch let error as NSError {
                print("error processing json data: \(error.localizedDescription)")
            }
        }
        
        return nil
    }
}



