//
//  SpreadsheetIntegration.swift
//  ORHS Interact
//
//  Created by Bernard Zhao on 7/11/16.
//  Copyright © 2016 Web and App Development. All rights reserved.
//

import Foundation
class SpreadsheetIntegration{
    let url: NSURL = NSURL(string: "https://spreadsheets.google.com/tq?key=1OYHhpeWnWCF_35foMF-R8oPha012UGDSBo1Q1aVUVJM")!
    var nameList = [String]()
    var dateList = [String]()
    var linkList = [String]()
    var locationList = [String]()
    var descriptionList = [String]()
    var hours = Int()
    
    func downloadURL(url: NSURL){
        
        let urlRequest: NSMutableURLRequest = NSMutableURLRequest(URL: url)
        let session = NSURLSession.sharedSession()
        let task = session.dataTaskWithRequest(urlRequest) {
            (data, response, error) -> Void in
            
            let httpResponse = response as! NSHTTPURLResponse
            let statusCode = httpResponse.statusCode
            
            if (statusCode == 200)  {
                print("File downloaded successfully.")
                
                
                do{
                    
                    let json = try NSJSONSerialization.JSONObjectWithData(data!, options:.AllowFragments)
                    self.eventParse(json)
                    self.hourParse(json)
                    
                    
                }catch{
                    print("Error with Json: \(error)")
                }
                
            }
        
        }
        task.resume()
    }
    
    func eventParse(json: AnyObject){
        
    }
    
    func hourParse(json: AnyObject){
        
    }
    
}