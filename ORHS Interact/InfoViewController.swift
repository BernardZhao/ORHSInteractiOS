//
//  InfoViewController.swift
//  ORHS Interact
//
//  Created by Bernard Zhao on 7/4/16.
//  Copyright © 2016 Web and App Development. All rights reserved.
//

import Foundation
import UIKit

class InfoViewController: UIViewController {
    @IBOutlet weak var aboutInteract: UITextView!
    @IBOutlet weak var behindtheScenes: UITextView!
    @IBOutlet weak var aboutBehindtheScenes: UITextView!
    @IBOutlet weak var resourcesButton: UIButton!


    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        aboutInteract.editable = false
        behindtheScenes.editable = false
        aboutBehindtheScenes.editable = false
        

        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func joinPressed(sender: AnyObject) {
        UIApplication.sharedApplication().openURL(NSURL(string: "https://docs.google.com/forms/d/1-ctFeAA4864rmHKsSczlP04mas-20f5n5aDrcX5btbc/viewform")!)
    }
    
    @IBAction func websitePressed(sender: AnyObject) {
                UIApplication.sharedApplication().openURL(NSURL(string: "https://orhsinteract.wix.com/1516")!)
    }

    @IBAction func resourcesPressed(sender: AnyObject) {
                UIApplication.sharedApplication().openURL(NSURL(string: "https://drive.google.com/folderview?id=0BwJLvdTM6Ac4UWlqSHlKTGhxRFk&usp=sharing")!)
    }
    @IBAction func githubPressed(sender: AnyObject) {
                UIApplication.sharedApplication().openURL(NSURL(string: "https://github.com/ORHS-Web-App-Dev")!)
    }
}