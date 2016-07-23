//
//  MoreOptionsViewController.swift
//  
//
//  Created by Bernard Zhao on 7/22/16.
//
//


class MoreOptionsViewController: UIViewController {

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tabBarController?.tabBar.hidden = true
        self.navigationItem.hidesBackButton = true
        let backButton = UIButton(frame: CGRectMake(0,0,70,70))
        
        let backImage = UIImage(named: "backBtn")
        let tintedBackImage = backImage?.imageWithRenderingMode(UIImageRenderingMode.AlwaysTemplate)
        
        backButton.setImage(tintedBackImage, forState: UIControlState.Normal)
        backButton.tintColor = UIColor(red:1.00, green:1.00, blue:0.60, alpha:1.0)
        backButton.titleEdgeInsets = UIEdgeInsetsMake(10,10,10,0)
        backButton.setTitle("Back", forState:UIControlState.Normal)
        backButton.setTitleColor(UIColor(red:1.00, green:1.00, blue:0.60, alpha:1.0), forState: UIControlState.Normal)
        backButton.addTarget(self, action: #selector(MoreOptionsViewController.leftButtonFunction), forControlEvents: UIControlEvents.TouchUpInside)
        
        let backBarButton = UIBarButtonItem(customView: backButton)
        
        let spacer = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.FixedSpace, target: nil, action: nil)
        spacer.width = -15

            
        self.navigationItem.leftBarButtonItems = [spacer, backBarButton]
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func leftButtonFunction(sender: UIBarButtonItem) {
        // Perform your custom actions
        self.tabBarController?.tabBar.hidden = false
        // Go back to the previous ViewController
        self.navigationController?.popViewControllerAnimated(true)
    }
   }