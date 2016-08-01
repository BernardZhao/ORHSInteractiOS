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



