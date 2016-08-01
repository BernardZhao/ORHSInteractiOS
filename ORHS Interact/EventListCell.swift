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
    }
    
    @IBOutlet weak var eventName: UILabel!
    @IBOutlet weak var eventDate: UILabel!
    @IBOutlet weak var eventDescription: UILabel!
    @IBOutlet weak var eventLocation: UILabel!
    @IBOutlet weak var locationImage: UIImageView!
    @IBOutlet weak var locationBackground: UIImageView!
}
