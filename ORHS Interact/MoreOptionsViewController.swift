//
//  MoreOptionsViewController.swift
//  
//
//  Created by Bernard Zhao on 7/22/16.
//
//
import MessageUI

class MoreOptionsViewController: UIViewController , MFMailComposeViewControllerDelegate{

    let officeremail = "orinteract@gmail.com"
    let bugemail = "orhswebandappdevelopment@gmail.com"
    
    @IBOutlet weak var president: UIImageView!
    @IBOutlet weak var vicePresident: UIImageView!
    @IBOutlet weak var hoursCoordinator: UIImageView!
    @IBOutlet weak var eventsCoordinator: UIImageView!
    @IBOutlet weak var secretary: UIImageView!
    @IBOutlet weak var treasurer: UIImageView!
    @IBOutlet weak var mediaCoordinator: UIImageView!
    @IBOutlet weak var greenTeam1: UIImageView!
    @IBOutlet weak var greenTeam2: UIImageView!
    
    @IBOutlet weak var vpText: UILabel!
    @IBOutlet weak var presText: UILabel!
    @IBOutlet weak var hoursText: UILabel!
    @IBOutlet weak var eventsText: UILabel!
    @IBOutlet weak var secText: UILabel!
    @IBOutlet weak var tresText: UILabel!
    @IBOutlet weak var mediaText: UILabel!
    @IBOutlet weak var greentext1: UILabel!
    @IBOutlet weak var greentext2: UILabel!
    
    @IBOutlet weak var scrollview: UIScrollView!
    
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
        self.navigationItem.title = "Do more"
        // Do any additional setup after loading the view, typically from a nib.
        
        self.vicePresident.alpha = 0
        self.president.alpha = 0
        self.hoursCoordinator.alpha = 0
        self.eventsCoordinator.alpha = 0
        self.secretary.alpha = 0
        self.treasurer.alpha = 0
        self.mediaCoordinator.alpha = 0
        self.greenTeam1.alpha = 0
        self.greenTeam2.alpha = 0
        scrollview.contentSize.height = 1000
        
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
    @IBAction func reportABugWasPressed(sender: AnyObject) {
        self.sendEmail(bugemail, subject: "Bug feedback")
        
    }
    @IBAction func contactAnOfficerWasPressed(sender: AnyObject) {
        self.sendEmail(officeremail, subject: "Officer feedback")
    }

    
    func sendEmail(url: String, subject: String) {
        if MFMailComposeViewController.canSendMail() {
            let mail = MFMailComposeViewController()
            mail.mailComposeDelegate = self
            mail.setSubject(subject)
            mail.setToRecipients([url])
            mail.setMessageBody("<p>You're so awesome!</p>", isHTML: true)
            
            presentViewController(mail, animated: true, completion: nil)
        } else {
            // show failure alert
            print("email failure")
        }
    }
    
    func mailComposeController(controller: MFMailComposeViewController, didFinishWithResult result: MFMailComposeResult, error: NSError?) {
        switch result {
        case MFMailComposeResultCancelled:
            print("Mail cancelled")
        case MFMailComposeResultSaved:
            print("Mail saved")
        case MFMailComposeResultSent:
            print("Mail sent")
        case MFMailComposeResultFailed:
            print("Mail sent failure: \(error?.localizedDescription)")
        default:
            break
        }
        controller.dismissViewControllerAnimated(true, completion: nil)
    }
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        UIView.animateWithDuration(1, animations: {
            self.vicePresident.alpha = 1.0
            self.president.alpha = 1.0
            self.hoursCoordinator.alpha = 1.0
            self.eventsCoordinator.alpha = 1.0
            self.secretary.alpha = 1.0
            self.treasurer.alpha = 1.0
            self.mediaCoordinator.alpha = 1.0
            self.greenTeam1.alpha = 1
            self.greenTeam2.alpha = 1
            
        })
    }
    
   }