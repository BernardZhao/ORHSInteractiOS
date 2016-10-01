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
        
        self.navigationBar.barStyle = UIBarStyle.black
        
        self.navigationBar.tintColor = UIColor(red:1.00, green:1.00, blue:0.60, alpha:1.0)

        
        let backButton = UIButton(frame: CGRect(x: 0,y: 0,width: 70,height: 70))
        
        let backImage = UIImage(named: "backBtn")
        let tintedBackImage = backImage?.withRenderingMode(UIImageRenderingMode.alwaysTemplate)

        backButton.setImage(tintedBackImage, for: UIControlState())
        backButton.tintColor = UIColor(red:1.00, green:1.00, blue:0.60, alpha:1.0)
        backButton.titleEdgeInsets = UIEdgeInsetsMake(10,10,10,0)
        backButton.setTitle("Back", for:UIControlState())
        backButton.setTitleColor(UIColor(red:1.00, green:1.00, blue:0.60, alpha:1.0), for: UIControlState())
        backButton.addTarget(self, action: #selector(CustomNavigation.leftButtonFunction), for: UIControlEvents.touchUpInside)
        
        let backBarButton = UIBarButtonItem(customView: backButton)
        
        let spacer = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.fixedSpace, target: nil, action: nil)
        spacer.width = -15
        

        let spacer2 = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.fixedSpace, target: nil, action: nil)
        spacer.width = -16
        
        let moreOptionsButton = UIButton(frame: CGRect(x: 0,y: 0,width: 5.5,height: 20))
        let moreOptionsImage = UIImage(named: "threedots-2")
        let tintedMoreOptionsButton = moreOptionsImage?.withRenderingMode(UIImageRenderingMode.alwaysTemplate)
        
        moreOptionsButton.setImage(tintedMoreOptionsButton, for: UIControlState())
        moreOptionsButton.tintColor = UIColor(red:1.00, green:1.00, blue:0.60, alpha:1.0)
        moreOptionsButton.addTarget(self, action: #selector(CustomNavigation.rightButtonFuction), for: UIControlEvents.touchUpInside)
        
        let moreOptionsBarButton = UIBarButtonItem(customView: moreOptionsButton)
 
        let navItem:UINavigationItem = UINavigationItem()
        navItem.leftBarButtonItems = [spacer,backBarButton]
        navItem.rightBarButtonItems = [spacer2, moreOptionsBarButton]
        navigationBar.pushItem(navItem, animated: false)
        
        self.navigationBar.topItem!.title = "Oak Ridge Interact"
        
        
    }
    

    
    func leftButtonFunction(){
        debugPrint("Gotta go back")
        self.dismiss(animated: true, completion: {});
        self.navigationController?.popToRootViewController(animated: true)
        
    }
    
    func rightButtonFuction(){
        debugPrint("Right button pressed - Transitioning views to More Options")
        performSegue(withIdentifier: "MoreOptionsSegue", sender: self)
    }
    
}
