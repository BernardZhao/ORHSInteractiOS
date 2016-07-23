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
        eventName.text = event.name
        eventDescription.text = event.info
        eventLocation.text = event.location
        eventDate.text = event.date


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
    @IBOutlet weak var locationBackground: UIImageView!
}
