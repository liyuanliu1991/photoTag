//
//  detailViewController.swift
//  photoTag
//
//  Created by Liyuan Liu on 7/13/16.
//  Copyright © 2016 Jerry. All rights reserved.
//

import UIKit
import QuartzCore
import MultipeerConnectivity

class detailViewController: UIViewController, UITextViewDelegate, UIAlertViewDelegate  {
    
    let serviceType = "eggPhoto"
    
    var browser: MCBrowserViewController?
    // var assistant: MCAdvertiserAssistant?
    var session: MCSession?
    var peerID: MCPeerID?
    
    func airdropInit()
    {
        self.peerID = MCPeerID(displayName: UIDevice.currentDevice().name)
        self.session = MCSession(peer: peerID!)
        self.session?.delegate = self
        
        self.browser = MCBrowserViewController(serviceType: serviceType, session: self.session!)
        self.browser?.delegate = self
        
        //  self.assistant = MCAdvertiserAssistant(serviceType: serviceType, discoveryInfo: nil, session: self.session!)
        
        //  self.assistant?.start()
        
    }
    
    
    @IBOutlet weak var Guess: UISwitch!
    
    @IBOutlet weak var detailImageView: UIImageView!
    
    @IBOutlet weak var shadow: GradientView!
    
    @IBOutlet weak var information: UITextView!
    
    @IBOutlet weak var clickShowTextView: UITextView!
    
    @IBOutlet weak var slider: UISlider!
    
    @IBOutlet weak var switchHaveFun: UISwitch!
    
    @IBOutlet weak var addSecretsLabel: UILabel!
    
    @IBOutlet weak var guessLabel: UILabel!
    
    @IBOutlet weak var hideNumLeft: UILabel!
    
    @IBOutlet weak var shareButton: UIButton!
    
    var upDownLeftRight = ["upupupupupup","downdowndown","leftleftleft","rightrightright"]
    
    var slideHiddenInforation = ["000000","11111","22222","33333","44444","55555","666666","777777","888888","9999999"]
    
    var clickHidenInfo = "Click Hidden Info"
    
    var infoHideTextView = TextViewArray()
    
    var tapTimes = 0
    var detailImage: UIImage?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        airdropInit()
        
        
        /*  detailImageView.clipsToBounds = true
         
         detailImageView.layer.cornerRadius = detailImageView.frame.size.height/2;*/
        
        
        
        /*detailImageView.frame = self.view.bounds
         detailImageView.blurImage()
         self.view.addSubview(self.detailImageView)*/
        
        detailImageView.image = detailImage
        
        // let imageData = UIImagePNGRepresentation(detailImage!)
        
        //detailImageView.image = UIImage(data: imageData!)
        
        detailImageView.alpha = 1.0
        
        
        
        hideNumLeft.layer.shadowOffset = CGSize(width: 10.0, height: 10.0)
        hideNumLeft.layer.shadowOpacity = 0.6
        hideNumLeft.layer.shadowRadius = 6
        hideNumLeft.hidden = true
        
        addSecretsLabel.layer.shadowOffset = CGSize(width: 10.0, height: 10.0)
        addSecretsLabel.layer.shadowOpacity = 0.6
        addSecretsLabel.layer.shadowRadius = 6
        addSecretsLabel.hidden = false
        
        
        guessLabel.layer.shadowOffset = CGSize(width: 10.0, height: 10.0)
        guessLabel.layer.shadowOpacity = 0.6
        guessLabel.layer.shadowRadius = 6
        guessLabel.hidden = false
        
        
        /* let mask = CALayer()
         
         let test = UIImage(named: "section.png") as! CGImage
         mask.contents = test
         mask.frame = CGRectMake(0, 0, detailImageView.image!.size.width, detailImageView.image!.size.height)
         detailImageView.layer.mask = mask
         detailImageView.layer.masksToBounds = true*/
        
        /*  var aspect = (detailImage?.size.height)! / (self.view.frame.size.width)
         
         var newHeight = aspect * detailImageView.frame.width
         
         detailImageView.frame = CGRectMake(detailImageView.frame.origin.x, detailImageView.frame.origin.y, self.view.frame.size.width, newHeight)*/
        
        clickShowTextView.hidden = true
        
        switchHaveFun.setOn(false, animated: true)
        Guess.setOn(false, animated: true)
        // slider.hidden = true
        
        clickShowTextView.delegate = self
        information.delegate = self
        
        
        
        shadow.hidden = true
        // Do any additional setup after loading the view.
        
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(detailViewController.respondToSwipe(_:)))
        swipeLeft.direction = UISwipeGestureRecognizerDirection.Left
        self.view.addGestureRecognizer(swipeLeft)
        
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(detailViewController.respondToSwipe(_:)))
        swipeRight.direction = UISwipeGestureRecognizerDirection.Right
        self.view.addGestureRecognizer(swipeRight)
        
        let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(detailViewController.respondToSwipe(_:)))
        swipeDown.direction = UISwipeGestureRecognizerDirection.Down
        self.view.addGestureRecognizer(swipeDown)
        
        
        let swipeUp = UISwipeGestureRecognizer(target: self, action: #selector(detailViewController.respondToSwipe(_:)))
        swipeUp.direction = UISwipeGestureRecognizerDirection.Up
        self.view.addGestureRecognizer(swipeUp)
        
        let tapReconginzer = UITapGestureRecognizer(target: self, action: #selector(detailViewController.tapClear(_:)))
        self.view.addGestureRecognizer(tapReconginzer)
        
        
        let addSecretsRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(detailViewController.longPressSecrets(_:)))
        self.view.addGestureRecognizer(addSecretsRecognizer)
        //detailImageView.userInteractionEnabled = true
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        self.session?.disconnect()
        
    }
    
    
    @IBAction func sharePhoto(sender: AnyObject) {
        
        self.presentViewController(self.browser!, animated: true, completion: nil)
        
        
        /*   mpcManager = MPCManager()
         mpcManager?.delegate = self
         mpcManager?.browser?.startBrowsingForPeers()
         
         if mpcManager?.foundPeer.count > 0
         {
         
         selectedPeer.delegate = self
         selectedPeer.title = "Slect Device to Pair"
         for each in (mpcManager?.foundPeer)!{
         selectedPeer.addButtonWithTitle(each.displayName)
         }
         selectedPeer.show()
         }
         else
         {
         print("cannot find peers")
         return
         }
         
         //shareButton.titleLabel?.text = "Browsering"
         
         var test = Dictionary<String,String?>()
         test["test"] = "test2"
         
         var question = Dictionary<String,String?>()
         question["q1"] = "q2"
         
         let data = dataSend(imageData: UIImagePNGRepresentation(detailImage!)!, clickHideInfo: clickShowTextView.text, leftInfo: upDownLeftRight[2], rightInfo: upDownLeftRight[3], upInfo: upDownLeftRight[0], downInfo: upDownLeftRight[1], sliderInfo: slideHiddenInforation, locationInfo: test, hints: nil, questions: question, temptsNum: 10)
         
         mpcManager?.sendData(data, toPeer: self.myselectedPeer!)*/
        
    }
    /*   func alertView(alertView: UIAlertView, clickedButtonAtIndex buttonIndex: Int) {
     self.myselectedPeer = mpcManager?.foundPeer[buttonIndex]
     mpcManager?.browser?.invitePeer(self.myselectedPeer!, toSession: (mpcManager?.session)! , withContext: nil, timeout: 20)
     }*/
    
    
    func longPressSecrets(gesture: UILongPressGestureRecognizer)
    {
        if switchHaveFun.on{
            
            let longPress = gesture as UILongPressGestureRecognizer
            let state = longPress.state
            
            switch state{
            case UIGestureRecognizerState.Began:
                let locationView = longPress.locationInView(detailImageView)
                
                
                let location = CGRect(x: locationView.x - 27.5 , y: locationView.y-27.5, width: 55, height: 55)
                //let location = CGRect(origin: locationView, size: size)
                
                
                //create new text view
                let newtextView = UITextView(frame: location)
                self.detailImageView.addSubview(newtextView)
                
                
                newtextView.backgroundColor = UIColor(white: 1.0, alpha: 0.5)
                newtextView.selectable = true
                newtextView.text = "tetteteteoooooooooooooooooooooooooooooo"
                //newtextView.textColor = UIColor.clearColor()
                newtextView.increaseFontSize(4)
                newtextView.editable = true
                newtextView.userInteractionEnabled = true
                self.detailImageView.userInteractionEnabled = true
                newtextView.delegate = self
                newtextView.layer.cornerRadius = newtextView.frame.size.height/2
                newtextView.clipsToBounds = true
                
                
                //shadow effects-----------------------------------------------
                /*  newtextView.layer.shadowOffset = CGSize(width: 10, height: 20)
                 newtextView.layer.shadowOpacity = 0.9
                 newtextView.layer.shadowRadius = 6*/
                
                
                //-------------------------------------------------------------
                
                //swipe to left is deleteing this one
                let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(detailViewController.deleteTextView(_:)))
                swipeLeft.direction = UISwipeGestureRecognizerDirection.Left
                newtextView.addGestureRecognizer(swipeLeft)
                
                let tapToFind = UITapGestureRecognizer(target: self, action: #selector(detailViewController.tapFind(_:)))
                newtextView.addGestureRecognizer(tapToFind)
                
                infoHideTextView.infoHideTextView.append(newtextView)
                print("begin")
                
            case UIGestureRecognizerState.Changed:
                print("change")
            case UIGestureRecognizerState.Ended:
                
                
                
                print("end")
            default:
                break
            }
            
            
        }
    }
    func tapFind(gesture: UITapGestureRecognizer){
        if !Guess.on{
            return
        }
        let target = gesture.view as? UITextView
        
        let locationView = gesture.locationInView(detailImageView)
        
        let hideX = (target?.frame.origin.x)!
        let hideY = (target?.frame.origin.y)!
        
        let tapX = locationView.x
        let tapY = locationView.y
        
        if((tapX >= hideX - 15 && tapX <= hideX + 35) && (tapY >= hideY - 15 && tapY <= hideY + 35))
        {
            print("tap location \(locationView.x):\(locationView.y)")
            print("info location \((target?.frame.origin.x)!)\((target?.frame.origin.y)!)")
            
            target?.hidden = false
            target!.editable = false
            target!.selectable = false
            
            target!.alpha = 0.75
            target!.backgroundColor = UIColor(white: 1.0, alpha: 1.0)
            
            target!.textColor = UIColor.blackColor()
        }
        
        
    }
    
    
    func deleteTextView(gesture: UIGestureRecognizer){
        
        if !switchHaveFun.on{
            return
        }
        let deleteObject = gesture.view as? UITextView
        
        if let swipeGesture = gesture as? UISwipeGestureRecognizer{
            switch swipeGesture.direction{
            case UISwipeGestureRecognizerDirection.Left:
                deleteObject?.removeFromSuperview()
                infoHideTextView.infoHideTextView.removeObject(deleteObject!)
                
                
            default:
                break
                
            }
        }
    }
    @IBAction func switchAction(sender: AnyObject) {
        self.shadow.hidden = true
        self.detailImageView.alpha = 1.0
        self.clickShowTextView.hidden = true
        
        if switchHaveFun.on{
            self.slider.hidden = true
            if Guess.on{
                Guess.setOn(false, animated: true)
                
            }
            infoHideTextView.show()
            
            
        }
        else
        {
            self.slider.hidden = false
            infoHideTextView.hide()
            
        }
    }
    
    @IBAction func GuessAction(sender: AnyObject) {
        self.shadow.hidden = true
        self.detailImageView.alpha = 1.0
        self.clickShowTextView.hidden = true
        if Guess.on{
            self.slider.hidden = true
            if switchHaveFun.on{
                self.switchHaveFun.setOn(false, animated: true)
                
            }
            infoHideTextView.hide()
            hideNumLeft.hidden = false
            hideNumLeft.text = "\(infoHideTextView.infoHideTextView.count) eggs"
            switchHaveFun.hidden = true
            addSecretsLabel.hidden = true
            shareButton.hidden = true
            
        }
        else
        {
            self.slider.hidden = false
            infoHideTextView.hide()
            hideNumLeft.hidden = true
            switchHaveFun.hidden = false
            addSecretsLabel.hidden = false
            shareButton.hidden = false
            //then hide all found view
        }
        
        
    }
    
    
    
    func tapClear(gesture: UITapGestureRecognizer)
    {
        if switchHaveFun.on || Guess.on{
            
            return
        }
        tapTimes = tapTimes + 1
        if(tapTimes%2 == 1)
        {
            UIView.transitionWithView(detailImageView ,
                                      duration:1,
                                      options:  UIViewAnimationOptions.TransitionCrossDissolve ,
                                      animations: {
                                        self.detailImageView.alpha = 0.2
                                        
                                        self.clickShowTextView.hidden = false
                                        self.clickShowTextView.text = self.clickHidenInfo
                                        
                                        self.slider.hidden = false
                                        self.shadow.hidden = true
                },
                                      completion: nil)
        }
        else
        {
            UIView.transitionWithView(shadow,
                                      duration:1,
                                      options:  UIViewAnimationOptions.TransitionCrossDissolve ,
                                      animations: {
                                        self.shadow.hidden = true
                                        self.detailImageView.alpha = 1.0
                                        self.clickShowTextView.hidden = true
                                        self.clickShowTextView.text = self.clickHidenInfo
                                        
                                        
                },
                                      completion: nil)
            
            
        }
        
        
    }
    func respondToSwipe(gesture: UIGestureRecognizer)
    {
        self.detailImageView.alpha = 1.0
        if switchHaveFun.on || Guess.on{
            return
        }
        if let swipeGesture = gesture as? UISwipeGestureRecognizer{
            switch swipeGesture.direction{
            case UISwipeGestureRecognizerDirection.Left:
                
                UIView.transitionWithView(shadow ,
                                          duration:1,
                                          options:  UIViewAnimationOptions.TransitionCrossDissolve ,
                                          animations: { self.shadow.hidden = false
                                            self.information.text = self.upDownLeftRight[2]
                    },
                                          completion: nil)
                
            case UISwipeGestureRecognizerDirection.Right:
                
                UIView.transitionWithView(shadow ,
                                          duration:1,
                                          options:  UIViewAnimationOptions.TransitionFlipFromRight ,
                                          animations: { self.shadow.hidden = false
                                            self.information.text = self.upDownLeftRight[3]
                    },
                                          completion: nil)
            case UISwipeGestureRecognizerDirection.Up:
                
                UIView.transitionWithView(shadow ,
                                          duration:1,
                                          options:  UIViewAnimationOptions.TransitionCurlUp,
                                          animations: { self.shadow.hidden = false
                                            self.information.text = self.upDownLeftRight[0]
                    },
                                          completion: nil)
            case UISwipeGestureRecognizerDirection.Down:
                
                UIView.transitionWithView(shadow ,
                                          duration:1,
                                          options:  UIViewAnimationOptions.TransitionCurlDown,
                                          animations: { self.shadow.hidden = false
                                            self.information.text = self.upDownLeftRight[1]
                    },
                                          completion: nil)
                
                
            default:
                break
                
            }
        }
        
        
    }
    
    @IBAction func sliderChange(sender: UISlider) {
        let selectedValue = Float(sender.value)
        let result = selectedValue / Float(10)
        detailImageView.alpha = CGFloat(result)
        clickShowTextView.hidden = false
        clickShowTextView.text = slideHiddenInforation[Int(selectedValue)]
        
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    func textView(textView: UITextView, shouldChangeTextInRange range: NSRange, replacementText text: String) -> Bool {
        if(text == "\n") {
            textView.resignFirstResponder()
            return false
        }
        return true
    }
    
    
    
}

extension detailViewController:MCBrowserViewControllerDelegate,MCSessionDelegate{
    func browserViewControllerDidFinish(browserViewController: MCBrowserViewController) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    func browserViewControllerWasCancelled(browserViewController: MCBrowserViewController) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    func session(session: MCSession, didReceiveData data: NSData, fromPeer peerID: MCPeerID) {
        
    }
    func session(session: MCSession, didReceiveStream stream: NSInputStream, withName streamName: String, fromPeer peerID: MCPeerID) {
        
    }
    func session(session: MCSession, didStartReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, withProgress progress: NSProgress) {
        
    }
    func session(session: MCSession, didFinishReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, atURL localURL: NSURL, withError error: NSError?) {
        
    }
    func session(session: MCSession, peer peerID: MCPeerID, didChangeState state: MCSessionState) {
        switch state{
        case MCSessionState.Connected:
            print("connect")
            self.dismissViewControllerAnimated(true, completion: nil)
            
            let msg = UIImageJPEGRepresentation(self.detailImage!, 1.0)
            do
            {
                try self.session?.sendData(msg!, toPeers: (self.session?.connectedPeers)!, withMode: .Unreliable)
                print("succee")
            }
            catch{
                print("failure")
            }
            
        //then transfering data
        default:
            break
        }
    }
    
}





























