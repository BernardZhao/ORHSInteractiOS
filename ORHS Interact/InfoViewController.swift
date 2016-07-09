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
    
    
}