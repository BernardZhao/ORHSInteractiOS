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
    @IBOutlet weak var hoursButton: UIButton!
    @IBOutlet weak var hoursDescription: UILabel!


    
    var flipperImages: [UIImage] = []
    var myTimer: Timer?
    var counter: Int = 1

    let hoursURL: URL = URL(string: "https://spreadsheets.google.com/feeds/list/13CkOpYGJA3V6fOwlli6XAu133F7TptnIW-eZjFhDZjc/od6/public/values?alt=json")!
    var sheets: SpreadsheetIntegration?
    var recordedHours: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        myTimer = Timer.scheduledTimer(timeInterval: 15, target: self, selector: #selector(HomeViewController.imageFlipper), userInfo: nil, repeats: true)
        flipperImages = [UIImage(named: "image1")!, UIImage(named: "image2")!, UIImage(named: "image3")!, UIImage(named: "image4")!, UIImage(named: "image5")!,]
        flipper.alpha = 0.8
        picture.image = UIImage(data: try! Data(contentsOf: GIDSignIn.sharedInstance().currentUser.profile.imageURL(withDimension: 150)))
        picture.layer.cornerRadius = picture.frame.height/2
        picture.layer.borderWidth = 1
        picture.layer.masksToBounds = false
        picture.layer.borderColor = UIColor.darkGray.cgColor
        picture.clipsToBounds = true
        nameLabel.text = GIDSignIn.sharedInstance().currentUser.profile.name
        hoursDescription.isHidden = true
        hoursButton.titleLabel?.textAlignment = NSTextAlignment.center
        
        let tabBarController = self.tabBarController
        tabBarController?.setupSwipeGestureRecognizers(true)
        self.findHours(hoursURL, name: GIDSignIn.sharedInstance().currentUser.profile.name)
        
 
        // Set vertical effect
        
        let verticalMotionEffect = UIInterpolatingMotionEffect(keyPath: "center.y",
                                                               type: .tiltAlongVerticalAxis)
        verticalMotionEffect.minimumRelativeValue = -20
        verticalMotionEffect.maximumRelativeValue = 20
        
        // Set horizontal effect
        
        let horizontalMotionEffect = UIInterpolatingMotionEffect(keyPath: "center.x",
                                                                 type: .tiltAlongHorizontalAxis)
        horizontalMotionEffect.minimumRelativeValue = -40
        horizontalMotionEffect.maximumRelativeValue = 40
        
        // Create group to combine both
        let group = UIMotionEffectGroup()
        group.motionEffects = [horizontalMotionEffect, verticalMotionEffect]
        
        // Add both effects to your view
        flipper.addMotionEffect(group)
    }
    
    func imageFlipper() {

            UIView.transition(with: self.flipper, duration:5, options: UIViewAnimationOptions.transitionCrossDissolve, animations: { self.flipper.image = self.flipperImages[self.counter] }, completion: nil)
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


    @IBAction func hoursWasPressed(_ sender: AnyObject) {
        self.hoursDescription.isHidden = false
        if let measure = recordedHours {
            if (measure < 25){
                UIView.transition(with: self.hoursDescription, duration: 0.5, options: [.transitionCrossDissolve], animations: {self.hoursDescription.text = "You have \(25-measure) hours left to complete."}, completion: nil)
            } else if (measure<30){
                UIView.transition(with: self.hoursDescription, duration: 0.5, options: [.transitionCrossDissolve], animations: {self.hoursDescription.text = "Congrats! You've completed your hours for this year."}, completion: nil)
            }
            else if (measure<40) {
                UIView.transition(with: self.hoursDescription, duration: 0.5, options: [.transitionCrossDissolve], animations: {self.hoursDescription.text = "You're going above and beyond."}, completion: nil)
            } else if (measure<50){
                UIView.transition(with: self.hoursDescription, duration: 0.5, options: [.transitionCrossDissolve], animations: {self.hoursDescription.text = "You are a volunteering beast."}, completion: nil)
            }else if (measure == 69) {
                UIView.transition(with: self.hoursDescription, duration: 0.5, options: [.transitionCrossDissolve], animations: {self.hoursDescription.text = "\u{1F440}"}, completion: nil)
            } else {
                UIView.transition(with: self.hoursDescription, duration: 0.5, options: [.transitionCrossDissolve], animations: {self.hoursDescription.text = "\u{1F4AF}You keep service \u{1F44D}above\u{1F44D} yourself.\u{1F44C} \u{1F525} Bless up \u{1F64F} Major Bag Alert \u{1F4B0} \u{1F4AF}"}, completion: nil)            }
            
        }
    }
    
    
    
    func findHours(_ url: URL, name: String) {
        var hours: String = ""

        let sheets = SpreadsheetIntegration()
        
        sheets.downloadJSON(url) {
            (data: Data) in
            
            if let jsonDictionary = SpreadsheetIntegration.parseJSONFromData(data){
                
                let eventDictionaries = jsonDictionary["feed"]!["entry"] as! [[String: AnyObject]]
                
                for x in 0...eventDictionaries.count - 1{
                    let sheetName: String = eventDictionaries[x]["title"]!["$t"] as! String
                    //debugPrint (sheetName)

                    if (sheetName.caseInsensitiveCompare(name) == ComparisonResult.orderedSame){
                        let test: String = eventDictionaries[x]["content"]!["$t"] as! String
                        let splitString = test.components(separatedBy: "totals: ")
                        hours = splitString[1]
                        debugPrint (hours)
                        DispatchQueue.main.async {
                            UIView.transition(with: self.hoursButton, duration: 0.25, options: [.transitionCrossDissolve], animations: {self.hoursButton.setTitle(hours, for: UIControlState())}, completion: nil)
                            self.recordedHours = Int(hours)
                        }

                    }
                    
                }
                
                if (hours == ""){
                debugPrint("wtf")
                DispatchQueue.main.async {
                    self.hoursButton.titleLabel!.font = UIFont(name: "System", size: 30)
                    UIView.transition(with: self.hoursButton, duration: 0.5, options: [.transitionCrossDissolve], animations: {self.hoursButton.setTitle("It appears no recorded hours could be found.", for: UIControlState())}, completion: nil)
                    
                }
                }
 
                
                
            }
            
            
        }
        
    }
    
    
}
