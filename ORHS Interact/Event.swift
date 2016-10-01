//
//  Event.swift
//  ORHS Interact
//
//  Created by Bernard Zhao on 7/12/16.
//  Copyright © 2016 Web and App Development. All rights reserved.
//

class Event{
    
    static let eventsURL: URL = URL(string: "https://spreadsheets.google.com/feeds/list/1uTxOe8usrx7o460tH3BAL5iPZRVmEyulkIoyGHa_FsQ/od6/public/values?alt=json")!
    static let hoursURL: URL = URL(string: "https://spreadsheets.google.com/feeds/list/13CkOpYGJA3V6fOwlli6XAu133F7TptnIW-eZjFhDZjc/od6/public/values?alt=json")!
    
    var name: String?
    var date: String?
    var link: URL?
    var info: String?
    var location: String?
    
    init(name: String, date: String, link: URL, info: String, location: String){
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
        self.link = URL(string: myEvents[2])
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
    
        

}
