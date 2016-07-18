//
//  EventListCell.swift
//  ORHS Interact
//
//  Created by Bernard Zhao on 7/12/16.
//  Copyright © 2016 Web and App Development. All rights reserved.
//

import Foundation
class EventListCell: UITableViewCell
{
    
    var event: Event! {
        didSet {
            self.updateUI()
        }
    }
    
    func updateUI()
    {
        print("UI is getting updated")
        UIView.transitionWithView(self.eventName, duration: 0.5, options: [.TransitionCrossDissolve], animations: {self.eventName.text = self.event.name}, completion: nil)
        UIView.transitionWithView(self.eventDescription, duration: 0.5, options: [.TransitionCrossDissolve], animations: {self.eventDescription.text = self.event.info}, completion: nil)
        UIView.transitionWithView(self.eventLocation, duration: 0.5, options: [.TransitionCrossDissolve], animations: {self.eventLocation.text = self.event.location}, completion: nil)
        UIView.transitionWithView(self.eventDate, duration: 0.5, options: [.TransitionCrossDissolve], animations: {self.eventDate.text = self.event.date}, completion: nil)
        //eventName.text = event.name
        //eventDescription.text = event.info
        //eventLocation.text = event.location
        //eventDate.text = event.date
        //createdAtLabel.text = "Duc Tran | \(episode.createdAt!)"
        
        //let thumbnailURL = episode.thumbnailURL
        /*
        let networkService = NetworkService(url: thumbnailURL!)
        networkService.downloadImage { (imageData) in
            let image = UIImage(data: imageData)
            dispatch_async(dispatch_get_main_queue(), {
                self.thumbnailImageView.image = image
            })
        }
 
        
        authorImageView.layer.cornerRadius = authorImageView.bounds.width / 2.0
        authorImageView.layer.masksToBounds = true
        authorImageView.layer.borderColor = UIColor.whiteColor().CGColor
        authorImageView.layer.borderWidth = 1.0
         */
    }
    
    @IBOutlet weak var eventName: UILabel!
    @IBOutlet weak var eventDate: UILabel!
    @IBOutlet weak var eventDescription: UILabel!
    @IBOutlet weak var eventLocation: UILabel!
    @IBOutlet weak var locationImage: UIImageView!
}
