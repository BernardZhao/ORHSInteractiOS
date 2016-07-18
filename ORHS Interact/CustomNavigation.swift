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
        
        self.navigationBar.barStyle = UIBarStyle.Black
        
        self.navigationBar.tintColor = UIColor(red:1.00, green:1.00, blue:0.60, alpha:1.0)

        
        let backButton = UIButton(frame: CGRectMake(0,0,70,70))
        
        let backImage = UIImage(named: "backBtn")
        let tintedBackImage = backImage?.imageWithRenderingMode(UIImageRenderingMode.AlwaysTemplate)

        backButton.setImage(tintedBackImage, forState: UIControlState.Normal)
        backButton.tintColor = UIColor(red:1.00, green:1.00, blue:0.60, alpha:1.0)
        backButton.titleEdgeInsets = UIEdgeInsetsMake(10,10,10,0)
        backButton.setTitle("Back", forState:UIControlState.Normal)
        backButton.setTitleColor(UIColor(red:1.00, green:1.00, blue:0.60, alpha:1.0), forState: UIControlState.Normal)
        backButton.addTarget(self, action: #selector(CustomNavigation.leftButtonFunction), forControlEvents: UIControlEvents.TouchUpInside)
        
        let backBarButton = UIBarButtonItem(customView: backButton)
        
        let spacer = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.FixedSpace, target: nil, action: nil)
        spacer.width = -15
        


        
 
        let navItem:UINavigationItem = UINavigationItem()
        navItem.leftBarButtonItems = [spacer,backBarButton]
        
        navigationBar.pushNavigationItem(navItem, animated: false)
        
        self.navigationBar.topItem!.title = "Oak Ridge Interact"
        
        
    }
    

    
    func leftButtonFunction(){
        debugPrint("Gotta go back")
        self.dismissViewControllerAnimated(true, completion: {});
        self.navigationController?.popToRootViewControllerAnimated(true)
        
    }
}
