//
//  Event.swift
//  ORHS Interact
//
//  Created by Bernard Zhao on 7/12/16.
//  Copyright © 2016 Web and App Development. All rights reserved.
//

class Event{
    
    static let eventsURL: NSURL = NSURL(string: "https://spreadsheets.google.com/feeds/list/1uTxOe8usrx7o460tH3BAL5iPZRVmEyulkIoyGHa_FsQ/od6/public/values?alt=json")!
    static let hoursURL: NSURL = NSURL(string: "https://spreadsheets.google.com/feeds/list/13CkOpYGJA3V6fOwlli6XAu133F7TptnIW-eZjFhDZjc/od6/public/values?alt=json")!
    
    var name: String?
    var date: String?
    var link: NSURL?
    var info: String?
    var location: String?
    
    init(name: String, date: String, link: NSURL, info: String, location: String){
        self.name = name
        self.date = date
        self.link = link
        self.info = info
        self.location = location
    }

    init(myEvents: [String]){
        if (myEvents.count == 5){
        self.name = myEvents[0]
        self.date = myEvents[1]
        self.link = NSURL(string: myEvents[2])
        self.info = myEvents[4]
        self.location = myEvents[3]
        }
        else {
        print("error creating Event - check initializing array")
        }
        
    }
    
    var description: String{
        return "Event contains 5 strings"
    }
    
    static func generateEvents(url: NSURL) -> [Event]
    {
        var events = [Event]()
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
                        newEvent.append(myStringArray[x].substringFromIndex(myStringArray[x].startIndex.advancedBy(7)))
                    }
                    
                    events.append(Event(myEvents: newEvent))
                    print (events[x].name)
                }
                
            }
            
        }
        debugPrint(events)
        return events
        
    }
    

}