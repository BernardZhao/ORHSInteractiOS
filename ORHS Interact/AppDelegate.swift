//
//  AppDelegate.swift
//  ORHS Interact
//
//  Created by Bernard Zhao on 5/31/16.
//  Copyright © 2016 Web and App Development. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, GIDSignInDelegate {
	
    var window: UIWindow?
	var signInCallback: (()->())?

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Initialize sign-in
        // Override point for customization after application launch.        
        var configureError: NSError?
        GGLContext.sharedInstance().configureWithError(&configureError)
        assert(configureError == nil, "Error configuring Google services: \(configureError)")
        
        GIDSignIn.sharedInstance().delegate = self

		UITabBar.appearance().tintColor = UIColor(red:1.00, green:1.00, blue:0.60, alpha:1.0)
		

		return true
    }
	
	func signIn(signIn: GIDSignIn!, didSignInForUser user: GIDGoogleUser!, withError error: NSError!) {
		if (error != nil) {
			print("Looks like we got a sign-in error: \(error.localizedDescription)")
			// Common error includes user clicking cancel.
		} else {
			//let userID = user.userID
			//let idToken = user.authentication.idToken
			let fullName = user.profile.name
			//let givenName = user.profile.givenName
			//let familyName = user.profile.familyName
			let email = user.profile.email
			print("Our user signed in! \(user) \(fullName) \(email)")
			signInCallback!()
		}
	}
	
	/*func signIn(signIn: GIDSignIn!, didDisconnectWithUser user: GIDGoogleUser!, withError error: NSError!) {
		<#code#>
	}*/
	
	func application(application: UIApplication,
	                 openURL url: NSURL, options: [String: AnyObject]) -> Bool {
		return GIDSignIn.sharedInstance().handleURL(url,
		                                            sourceApplication: options[UIApplicationOpenURLOptionsSourceApplicationKey] as? String,
		                                            annotation: options[UIApplicationOpenURLOptionsAnnotationKey])
	}
	

	
	func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
}

