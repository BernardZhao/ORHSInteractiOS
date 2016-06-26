//
//  ViewController.swift
//  ORHS Interact
//
//  Created by Bernard Zhao on 5/31/16.
//  Copyright © 2016 Web and App Development. All rights reserved.
//

import UIKit

class ViewController: UIViewController, GIDSignInUIDelegate {

    @IBOutlet weak var signInButton: GIDSignInButton!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var interactbackground: UIImageView!
    @IBOutlet weak var signOutButton: UIButton!

	
		func refreshInterface() {
		if let currentUser = GIDSignIn.sharedInstance().currentUser {
			debugPrint("refresh")
			signInButton.hidden = true
            signOutButton.hidden = false
            statusLabel.text = "Welcome, \(currentUser.profile.name)!"
            //[self.performSegueWithIdentifier("LoginSegue", sender: self)];
        } else {
			debugPrint("no refresh")
            signInButton.hidden = false
            signOutButton.hidden = true
            statusLabel.text = "Sign in, stranger."
	}
	
	}
    @IBAction func signOutWasPressed(sender: AnyObject) {
        GIDSignIn.sharedInstance().signOut()
		debugPrint("Nigga signed out")
        refreshInterface()
    }

	
	override func viewDidLoad() {
		super.viewDidLoad()
		refreshInterface()
		(UIApplication.sharedApplication().delegate as! AppDelegate).signInCallback = refreshInterface
		GIDSignIn.sharedInstance().uiDelegate = self
		GIDSignIn.sharedInstance().signInSilently()
		
		// Set vertical effect
		let verticalMotionEffect = UIInterpolatingMotionEffect(keyPath: "center.y",
		                                                       type: .TiltAlongVerticalAxis)
		verticalMotionEffect.minimumRelativeValue = -20
		verticalMotionEffect.maximumRelativeValue = 20
		
		// Set horizontal effect
		
		let horizontalMotionEffect = UIInterpolatingMotionEffect(keyPath: "center.x",
		                                                         type: .TiltAlongHorizontalAxis)
		horizontalMotionEffect.minimumRelativeValue = -20
		horizontalMotionEffect.maximumRelativeValue = 20
		
		// Create group to combine both
		let group = UIMotionEffectGroup()
		group.motionEffects = [horizontalMotionEffect, verticalMotionEffect]
		
		// Add both effects to your view
		interactbackground.addMotionEffect(group)
		// Do any additional setup after loading the view, typically from a nib.
		
	}
	
	
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}
