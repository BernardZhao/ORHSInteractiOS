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
    var counter = 0
    
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
    
    @IBOutlet weak var easteregg: UILabel!
    @IBOutlet weak var scrollview: UIScrollView!
    @IBOutlet weak var vasanth: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBarController?.tabBar.isHidden = true
        self.navigationItem.hidesBackButton = true
        let backButton = UIButton(frame: CGRect(x: 0,y: 0,width: 70,height: 70))
        
        let backImage = UIImage(named: "backBtn")
        let tintedBackImage = backImage?.withRenderingMode(UIImageRenderingMode.alwaysTemplate)
        
        backButton.setImage(tintedBackImage, for: UIControlState())
        backButton.tintColor = UIColor(red:1.00, green:1.00, blue:0.60, alpha:1.0)
        backButton.titleEdgeInsets = UIEdgeInsetsMake(10,10,10,0)
        backButton.setTitle("Back", for:UIControlState())
        backButton.setTitleColor(UIColor(red:1.00, green:1.00, blue:0.60, alpha:1.0), for: UIControlState())
        backButton.addTarget(self, action: #selector(MoreOptionsViewController.leftButtonFunction), for: UIControlEvents.touchUpInside)
        
        let backBarButton = UIBarButtonItem(customView: backButton)
        
        let spacer = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.fixedSpace, target: nil, action: nil)
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
        
        let tappedTitle: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(MoreOptionsViewController.titletapped))
        tappedTitle.numberOfTapsRequired = 1
        easteregg.addGestureRecognizer(tappedTitle)
        vasanth.isHidden = true
        easteregg.isUserInteractionEnabled = true
        
        
        // Set vertical effect
        
        let verticalMotionEffect = UIInterpolatingMotionEffect(keyPath: "center.y",
                                                               type: .tiltAlongVerticalAxis)
        verticalMotionEffect.minimumRelativeValue = -40
        verticalMotionEffect.maximumRelativeValue = 40
        
        // Set horizontal effect
        
        let horizontalMotionEffect = UIInterpolatingMotionEffect(keyPath: "center.x",
                                                                 type: .tiltAlongHorizontalAxis)
        horizontalMotionEffect.minimumRelativeValue = -40
        horizontalMotionEffect.maximumRelativeValue = 40
        
        // Create group to combine both
        let group = UIMotionEffectGroup()
        group.motionEffects = [horizontalMotionEffect, verticalMotionEffect]
        
        // Add both effects to your view
        vasanth.addMotionEffect(group)
        // Do any additional setup after loading the view, typically from a nib.
        
        
    }
    
    func titletapped(){
        if (counter > 6) {
        vasanth.isHidden = false
            UIView.transition(with: self.hoursText, duration: 0.5, options: [.transitionCrossDissolve], animations: {self.hoursText.text = "Trap God"}, completion: nil)
            counter = 0
        }
        else {
            counter += 1
        }
        debugPrint (counter)
        print("tapped")
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func leftButtonFunction(_ sender: UIBarButtonItem) {
        // Perform your custom actions
        self.tabBarController?.tabBar.isHidden = false
        // Go back to the previous ViewController
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func reportABugWasPressed(_ sender: AnyObject) {
        self.sendEmail(bugemail, subject: "Bug feedback")
        
    }
    @IBAction func contactAnOfficerWasPressed(_ sender: AnyObject) {
        self.sendEmail(officeremail, subject: "Officer feedback")
    }

    
    func sendEmail(_ url: String, subject: String) {
        if MFMailComposeViewController.canSendMail() {
            let mail = MFMailComposeViewController()
            mail.mailComposeDelegate = self
            mail.setSubject(subject)
            mail.setToRecipients([url])
            mail.setMessageBody("<p>You're so awesome!</p>", isHTML: true)
            
            present(mail, animated: true, completion: nil)
        } else {
            // show failure alert
            print("email failure")
        }
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        switch result {
        case MFMailComposeResult.cancelled:
            print("Mail cancelled")
        case MFMailComposeResult.saved:
            print("Mail saved")
        case MFMailComposeResult.sent:
            print("Mail sent")
        case MFMailComposeResult.failed:
            print("Mail sent failure: \(error?.localizedDescription)")
        default:
            break
        }
        controller.dismiss(animated: true, completion: nil)
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        UIView.animate(withDuration: 1, animations: {
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
