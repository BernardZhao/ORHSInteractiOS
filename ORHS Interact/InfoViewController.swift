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
        
        aboutInteract.isEditable = false
        behindtheScenes.isEditable = false
        aboutBehindtheScenes.isEditable = false
        

        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func joinPressed(_ sender: AnyObject) {
        UIApplication.shared.openURL(URL(string: "https://goo.gl/forms/k9uHclWR4jazJjYj2")!)
    }
    
    @IBAction func websitePressed(_ sender: AnyObject) {
                UIApplication.shared.openURL(URL(string: "https://orhsinteract.com")!)
    }

    @IBAction func resourcesPressed(_ sender: AnyObject) {
                UIApplication.shared.openURL(URL(string: "https://drive.google.com/folderview?id=0BwJLvdTM6Ac4UWlqSHlKTGhxRFk&usp=sharing")!)
    }
    @IBAction func githubPressed(_ sender: AnyObject) {
                UIApplication.shared.openURL(URL(string: "https://github.com/ORHS-Web-App-Dev")!)
    }
}
