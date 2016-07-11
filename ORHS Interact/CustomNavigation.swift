//
//  CustomNavigation.swift
//  ORHS Interact
//
//  Created by Bernard Zhao on 7/10/16.
//  Copyright © 2016 Web and App Development. All rights reserved.
//

import UIKit
class CustomNavigation: UINavigationController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //self.navigationItem.leftBarButtonItem
        let back:UIBarButtonItem = UIBarButtonItem(title: "Back", style: UIBarButtonItemStyle.Plain, target: self, action: #selector(leftButtonFunction))
        let navItem:UINavigationItem = UINavigationItem()
        navItem.leftBarButtonItem = back
        navigationBar.pushNavigationItem(navItem, animated: false)
        self.navigationBar.backIndicatorImage = UIImage(named: "backbutton")
        
        self.navigationBar.tintColor = UIColor(red:1.00, green:1.00, blue:0.60, alpha:1.0)
        //self.navigationController?.navigationBar.barTintColor = UIColor.darkGrayColor()
        self.navigationBar.topItem!.title = "Oak Ridge Interact"
    }
    

    
    func leftButtonFunction(){
        debugPrint("Gotta go back nigga")
        self.dismissViewControllerAnimated(true, completion: {});
        self.navigationController?.popToRootViewControllerAnimated(true)
        
    }
}
