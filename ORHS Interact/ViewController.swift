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
    @IBOutlet weak var signOutButton: StyleButton!
    @IBOutlet weak var disconnectButton: StyleButton!
    @IBOutlet weak var returnButton: UIButton!
    
	
	func refreshInterface() {
			debugPrint("refreshInterface")
		if let currentUser = GIDSignIn.sharedInstance().currentUser {
			debugPrint("A user is active")
			if GIDSignIn.sharedInstance().currentUser.profile.email.rangeOfString("eduhsd.k12.ca.us") != nil {
			debugPrint("refresh - this is an ORHS Account")
			self.performSegueWithIdentifier("LoginSegue", sender: self)
			signInButton.hidden = true
            signOutButton.hidden = false
            disconnectButton.hidden = false
			returnButton.hidden = false
            statusLabel.text = "Welcome, \(currentUser.profile.name)!"
				
			}
			else {
				debugPrint("not ORHS no refresh")
				GIDSignIn.sharedInstance().signOut()
				statusLabel.text = "Only ORHS Google accounts can login."
				signInButton.hidden = false
				signOutButton.hidden = true
                disconnectButton.hidden = true
				returnButton.hidden = true
			}
        } else {
			debugPrint("no refresh because noone is here")
            signInButton.hidden = false
            signOutButton.hidden = true
            disconnectButton.hidden = true
			returnButton.hidden = true
            statusLabel.text = "Sign in using your ORHS Google account."
		}

	}
	
	
    @IBAction func signOutWasPressed(sender: AnyObject) {
		GIDSignIn.sharedInstance().signOut()
		debugPrint("User signed out")
        refreshInterface()
	}
    @IBAction func disconnectWasPressed(sender: AnyObject) {
        GIDSignIn.sharedInstance().disconnect()
    }
    @IBAction func returnWasPressed(sender: AnyObject) {
		self.performSegueWithIdentifier("LoginSegue", sender: self)
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
		horizontalMotionEffect.minimumRelativeValue = -40
		horizontalMotionEffect.maximumRelativeValue = 40
		
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
	
/*	override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
		if (segue.identifier == "loginSegue") {
			let HomeViewController = (segue.destinationViewController as HomeViewControllerClass)

		}*/
	

}