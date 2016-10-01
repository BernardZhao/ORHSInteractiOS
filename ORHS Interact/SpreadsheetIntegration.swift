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
    lazy var configuration: URLSessionConfiguration = URLSessionConfiguration.default
    lazy var session: URLSession = URLSession(configuration: self.configuration)
    

    
    init() {

    }
    
    
    
    typealias DataHandler = ((Data) -> Void)
    
    func downloadJSON(_ input: URL, completion: @escaping DataHandler)
    {
        let request = URLRequest(url: input)
        let dataTask = session.dataTask(with: request, completionHandler: { (data, response, error) in
            
            if error == nil {
                if let httpResponse = response as? HTTPURLResponse {
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
        }) 
        
        dataTask.resume()
    }
    
    

}

extension SpreadsheetIntegration
{
    static func parseJSONFromData(_ jsonData: Data?) -> [String : AnyObject]?
    {
        if let data = jsonData {
            do {
                let jsonDictionary = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers) as? [String : AnyObject]
                return jsonDictionary
                
            } catch let error as NSError {
                print("error processing json data: \(error.localizedDescription)")
            }
        }
        
        return nil
    }
}



