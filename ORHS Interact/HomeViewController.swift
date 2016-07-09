//
//  HomeViewController.swift
//  
//
//  Created by Bernard Zhao on 7/1/16.
//
//
import Foundation
import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet weak var flipper: UIImageView!
    @IBOutlet weak var picture: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    var flipperImages: [UIImage] = []
    var myTimer: NSTimer?
    var counter: Int = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        myTimer = NSTimer.scheduledTimerWithTimeInterval(15, target: self, selector: #selector(HomeViewController.imageFlipper), userInfo: nil, repeats: true)
        flipperImages = [UIImage(named: "image1")!, UIImage(named: "image2")!, UIImage(named: "image3")!, UIImage(named: "image4")!, UIImage(named: "image5")!,]
        picture.image = UIImage(data: NSData(contentsOfURL: GIDSignIn.sharedInstance().currentUser.profile.imageURLWithDimension(150))!)
        picture.layer.cornerRadius = picture.frame.height/2
        picture.layer.borderWidth = 1
        picture.layer.masksToBounds = false
        picture.layer.borderColor = UIColor.blackColor().CGColor
        picture.clipsToBounds = true
        nameLabel.text = GIDSignIn.sharedInstance().currentUser.profile.name
        
        let tabBarController = self.tabBarController
        tabBarController?.setupSwipeGestureRecognizers(true)
        
        
        
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
        flipper.addMotionEffect(group)
    }
    
    func imageFlipper() {

            UIView.transitionWithView(self.flipper, duration:5, options: UIViewAnimationOptions.TransitionCrossDissolve, animations: { self.flipper.image = self.flipperImages[self.counter] }, completion: nil)
            debugPrint("Transitioning from image \(counter) in flipperImages array")
        counter+=1
        if self.counter > 4 {
            self.counter = 0
        }
        }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        //MainViewController
    }

    
}
