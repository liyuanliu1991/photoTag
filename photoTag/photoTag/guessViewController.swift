//
//  guessViewController.swift
//  photoTag
//
//  Created by Liyuan Liu on 7/19/16.
//  Copyright © 2016 Jerry. All rights reserved.
//

import UIKit
import MultipeerConnectivity

class guessViewController: UIViewController {
    
    let serviceType = "eggPhoto"
    
    var assistant: MCAdvertiserAssistant?
    var session: MCSession?
    var peerID:MCPeerID?
    
    var dataReceived:Dictionary<String,[String]>?
    
    var tapTimes = 0
    var loadTimes = 0
    var done = false
    var eggFindNums = 0
    var qa:[String]?
    
    var infoHideTextView = TextViewArray()
    
    var totalTapsAllowed = 0
    
    var clickTaps = 0
    
    @IBOutlet weak var clickShowText: UITextView!
    
    
    
    @IBOutlet weak var shadow: GradientView!
    @IBOutlet weak var answerQuestion: UIButton!
    
    @IBOutlet weak var temptsLeft: UILabel!
    
    @IBOutlet weak var eggsLeft: UILabel!
    
    @IBOutlet weak var hintsButton: UIButton!
    
   
    
    @IBOutlet weak var guessImage: UIImageView!
    
    @IBOutlet weak var infoSlider: UISlider!
    @IBOutlet weak var swipeText: UITextView!
    
    
    func initDataReceived()
    {
        self.dataReceived = ["clickHidenInfo":[""],"swipeInfo":["","","",""],"sliderInfo":["","","","","","","","","",""],"qa":["",""],"hints":[""],"tempts":[""]]
    }
    
    func airDropInit()
    {
        self.peerID = MCPeerID(displayName: UIDevice.currentDevice().name)
        self.session = MCSession(peer: peerID!)
        self.session?.delegate = self
        
        self.assistant = MCAdvertiserAssistant(serviceType: serviceType, discoveryInfo: nil, session: self.session!)
        self.assistant?.start()
    }
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        assistant?.stop()
        initDataReceived()
        answerQuestion.hidden = true
        temptsLeft.hidden = true
        eggsLeft.hidden = true
        hintsButton.hidden = true
    }
    func delay(seconds seconds: Double, completion:()->()) {
        let popTime = dispatch_time(DISPATCH_TIME_NOW, Int64( Double(NSEC_PER_SEC) * seconds ))
        
        dispatch_after(popTime, dispatch_get_main_queue()) {
            completion()
        }
    
    }
    func demoSpinner() {
        
      //  SwiftSpinner.showWithDelay(5, title: "Shouldn't see this one", animated: true)
      //  SwiftSpinner.hide()
        
        SwiftSpinner.showWithDelay(1.0, title: "Connecting...", animated: true)
        
        delay(seconds: 2.0, completion: {
            SwiftSpinner.show("Connecting \nto satellite...").addTapHandler({
                print("tapped")
                SwiftSpinner.hide()
                }, subtitle: "Tap to hide while connecting! This will affect only the current operation.")
        })
        
        delay(seconds: 6.0, completion: {
            SwiftSpinner.show("Authenticating user account")
        })
        
        delay(seconds: 10.0, completion: {
            SwiftSpinner.show("Failed to connect, waiting...", animated: false)
        })
        
        delay(seconds: 14.0, completion: {
            SwiftSpinner.setTitleFont(UIFont(name: "Futura", size: 22.0))
            SwiftSpinner.show("Retrying to authenticate")
        })
        
        delay(seconds: 18.0, completion: {
            SwiftSpinner.show("Connecting...")
        })
        
        delay(seconds: 21.0, completion: {
            SwiftSpinner.setTitleFont(nil)
            SwiftSpinner.showWithDuration(2.0, title: "Connected", animated: false)
        })
        
        delay(seconds: 24.0) {
            NSTimer.scheduledTimerWithTimeInterval(0.1, target: self, selector: #selector(self.timerFire), userInfo: nil, repeats: true)
        }
        
        delay(seconds: 34.0, completion: {
            self.demoSpinner()
        })
    }
    var progress = 0.0
    func timerFire(timer: NSTimer) {
        progress += (timer.timeInterval/5)
        SwiftSpinner.showWithProgress(progress, title: "Downloading Data...")
        if progress >= 1 {
            timer.invalidate()
            SwiftSpinner.showWithDuration(2.0, title: "Complete!", animated: false)
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
      //  SwiftSpinner.showWithDelay(10.0, title: "Waiting For Request....", animated: true)
        
        
        
        airDropInit()
        guessImage.hidden = true
        
        
        let lSize = CGSize(width: 300.0, height: 300.0)
        infoSlider.hidden = true
        shadow.hidden = true
        swipeText.hidden = true
        swipeText.editable = false
        clickShowText.hidden = true
        clickShowText.editable = false
        
        
            SwiftSpinner.show("Waiting For Request.....").addTapHandler({
                print("tapped")
                SwiftSpinner.hide()
                }, subtitle: "Tap to quit while waiting! This will affect only the current operation.")
      
        
    }
    
    @IBAction func showHints(sender: AnyObject) {
        
        let alert = UIAlertController(title: "Hints:",
                                      message: dataReceived!["hints"]![0],
                                      preferredStyle: UIAlertControllerStyle.Alert)
        
        let ok = UIAlertAction(title: "OK",
                               style: UIAlertActionStyle.Default, handler:nil)
        
        
        alert.addAction(ok)
        
        
        self.presentViewController(alert, animated: true, completion: nil)
        
    }
    
    
    @IBAction func QAAction(sender: AnyObject) {
        
        if qa![0] == ""
        {
            let alertNo = UIAlertController(title: "No question",
                                          message: "No question",
                                          preferredStyle: UIAlertControllerStyle.Alert)
            let ok = UIAlertAction(title: "OK",
                                       style: UIAlertActionStyle.Cancel,
                                       handler: nil)
            alertNo.addAction(ok)
            self.presentViewController(alertNo, animated: true, completion: nil)
            return

        }
        
        let alert = UIAlertController(title: "Question:",
                                      message: "\(qa![0])",
                                      preferredStyle: UIAlertControllerStyle.Alert)
        
        let ok = UIAlertAction(title: "OK",
                               style: UIAlertActionStyle.Default) { (action: UIAlertAction) in
                                
                                if let alertTextField = alert.textFields?.first where alertTextField.text != nil {
                                    let answer = alertTextField.text
                                    if answer == self.qa![1]
                                    {
                                        self.done = true
                                        self.infoSlider.hidden = false
                                    }
                                    
                                }
                                
        }
        
        let cancel = UIAlertAction(title: "Cancel",
                                   style: UIAlertActionStyle.Cancel,
                                   handler: nil)
        
        alert.addTextFieldWithConfigurationHandler { (textField: UITextField) in
            
            textField.placeholder = "Answer here"
            
        }
        
        alert.addAction(ok)
        alert.addAction(cancel)
        
        self.presentViewController(alert, animated: true, completion: nil)

        
    }
    func addHideInfo()
    {
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(guessViewController.respondToSwipe(_:)))
        swipeLeft.direction = UISwipeGestureRecognizerDirection.Left
        self.view.addGestureRecognizer(swipeLeft)
        
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(guessViewController.respondToSwipe(_:)))
        swipeRight.direction = UISwipeGestureRecognizerDirection.Right
        self.view.addGestureRecognizer(swipeRight)
        
        let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(guessViewController.respondToSwipe(_:)))
        swipeDown.direction = UISwipeGestureRecognizerDirection.Down
        self.view.addGestureRecognizer(swipeDown)
        
        
        let swipeUp = UISwipeGestureRecognizer(target: self, action: #selector(guessViewController.respondToSwipe(_:)))
        swipeUp.direction = UISwipeGestureRecognizerDirection.Up
        self.view.addGestureRecognizer(swipeUp)
        
        
      //  let tapReconginzer = UITapGestureRecognizer(target: self, action: #selector(guessViewController.tapClear(_:)))
        //self.view.addGestureRecognizer(tapReconginzer)
        
        let tapTemptsReconginzer = UITapGestureRecognizer(target: self, action: #selector(guessViewController.tapTempts(_:)))
        self.view.addGestureRecognizer(tapTemptsReconginzer)

        
        let temp = dataReceived!["tempts"]![0]
        if temp == ""
        {
            self.temptsLeft.text = "unlimites tempts"
            self.totalTapsAllowed = -1
        }
        else if let tempInt = Int(temp)
        {
            self.temptsLeft.text = "\(tempInt) tempts left"
            self.totalTapsAllowed = tempInt
        }
        let eggs = dataReceived!["locationInfo"]
        if let eggNum = eggs?.count
        {
            self.eggsLeft.text = "\(eggNum) left"
        }
        else
        {
            self.eggsLeft.text = "0 egg left"
        }
        
         self.performReceivedDataLocationPart()
        
        
    }
    func tapTempts(gesture: UITapGestureRecognizer)
    {
        self.shadow.hidden = true
        self.guessImage.alpha = 1
        
        if totalTapsAllowed == tapTimes && !done
        {
            return
        }
        if totalTapsAllowed == -1
        {
            if done
            {
                if(clickTaps%2 == 0)
                {
                    self.clickShowText.hidden = false
                    self.guessImage.alpha = 0.75
                    self.clickShowText.text = dataReceived!["clickHidenInfo"]![0]
                }
                else
                {
                    self.clickShowText.hidden = true
                    self.guessImage.alpha = 1.0
                }
                
                clickTaps += 1
            }

            return
        }
        if done
        {
            if(clickTaps%2 == 0)
            {
                self.clickShowText.hidden = false
                self.guessImage.alpha = 0.75
                self.clickShowText.text = dataReceived!["clickHidenInfo"]![0]
            }
            else
            {
                self.clickShowText.hidden = true
                self.guessImage.alpha = 1.0
            }
            
            clickTaps += 1
        }
        if totalTapsAllowed == tapTimes
        {
            return
        }
        
        if eggFindNums == (dataReceived!["locationInfo"]?.count)!
        {
            self.guessImage.alpha = 1.0
            if !done{
                return
            }
            let clickInfo = dataReceived!["clickHidenInfo"]
            
            swipeText.hidden = true
            self.shadow.hidden = true
            
            tapTimes = tapTimes + 1
            
            if(tapTimes%2 == 1)
            {
                UIView.transitionWithView(guessImage ,
                                          duration:1,
                                          options:  UIViewAnimationOptions.TransitionCrossDissolve ,
                                          animations: {
                                            self.guessImage.alpha = 0.2
                                            
                                            self.clickShowText.hidden = false
                                            self.clickShowText.text = clickInfo![0]
                                            
                                            //   self.infoSlider.hidden = false
                                            
                    },
                                          completion: nil)
            }
            else
            {
                UIView.transitionWithView(shadow,
                                          duration:1,
                                          options:  UIViewAnimationOptions.TransitionCrossDissolve ,
                                          animations: {
                                            
                                            self.guessImage.alpha = 1.0
                                            self.clickShowText.hidden = true
                                            //  self.clickShowText.text = clickInfo![0]
                                            
                                            
                    },
                                          completion: nil)
                
                
            }
            return

        }
        
        if temptsLeft.text == "unlimites tempts"
        {
            return
        }
        
        tapTimes += 1
        temptsLeft.text = "\(totalTapsAllowed - tapTimes) tempts left"
        temptsLeft.reloadInputViews()
    }
    /*func tapClear(gesture: UITapGestureRecognizer)
    {
        self.guessImage.alpha = 1.0
        if !done{
            return
        }
        let clickInfo = dataReceived!["clickHidenInfo"]
        
        swipeText.hidden = true
        self.shadow.hidden = true
        
        tapTimes = tapTimes + 1
        
        if(tapTimes%2 == 1)
        {
            UIView.transitionWithView(guessImage ,
                                      duration:1,
                                      options:  UIViewAnimationOptions.TransitionCrossDissolve ,
                                      animations: {
                                        self.guessImage.alpha = 0.2
                                        
                                        self.clickShowText.hidden = false
                                        self.clickShowText.text = clickInfo![0]
                                        
                                     //   self.infoSlider.hidden = false
                                        
                },
                                      completion: nil)
        }
        else
        {
            UIView.transitionWithView(shadow,
                                      duration:1,
                                      options:  UIViewAnimationOptions.TransitionCrossDissolve ,
                                      animations: {
                                        
                                        self.guessImage.alpha = 1.0
                                        self.clickShowText.hidden = true
                                      //  self.clickShowText.text = clickInfo![0]
                                        
                                        
                },
                                      completion: nil)
            
            
        }
        
        
    
    }*/

    func respondToSwipe(gesture: UIGestureRecognizer)
    {
        self.guessImage.alpha = 1.0
        
        if !done
        {
            return
        }
        
        self.clickShowText.hidden = true
        
        let upDownLeftRight = dataReceived!["swipeInfo"]
        self.swipeText.hidden = false
        if let swipeGesture = gesture as? UISwipeGestureRecognizer{
            switch swipeGesture.direction{
            case UISwipeGestureRecognizerDirection.Left:
                
                UIView.transitionWithView(shadow ,
                                          duration:1,
                                          options:  UIViewAnimationOptions.TransitionCrossDissolve ,
                                          animations: { self.shadow.hidden = false
                                            
                                            self.swipeText.text = upDownLeftRight![2]
                    },
                                          completion: nil)
                
            case UISwipeGestureRecognizerDirection.Right:
                
                UIView.transitionWithView(shadow ,
                                          duration:1,
                                          options:  UIViewAnimationOptions.TransitionFlipFromRight ,
                                          animations: { self.shadow.hidden = false
                                            self.swipeText.text = upDownLeftRight![3]
                    },
                                          completion: nil)
            case UISwipeGestureRecognizerDirection.Up:
                
                UIView.transitionWithView(shadow ,
                                          duration:1,
                                          options:  UIViewAnimationOptions.TransitionCurlUp,
                                          animations: { self.shadow.hidden = false
                                            self.swipeText.text = upDownLeftRight![0]
                    },
                                          completion: nil)
            case UISwipeGestureRecognizerDirection.Down:
                
                UIView.transitionWithView(shadow ,
                                          duration:1,
                                          options:  UIViewAnimationOptions.TransitionCurlDown,
                                          animations: { self.shadow.hidden = false
                                            self.swipeText.text = upDownLeftRight![1]
                    },
                                          completion: nil)
                
                
            default:
                break
                
            }
        }

        
    }
    
    @IBAction func sliderChange(sender: UISlider) {
        if !done
        {
            return
        }
        let selectedValue = Float(sender.value)
        let result = selectedValue / Float(10)
        guessImage.alpha = CGFloat(result)
        clickShowText.hidden = false
        swipeText.hidden = true
        shadow.hidden = true
        let b = dataReceived!["sliderInfo"]
        clickShowText.text = b![Int(selectedValue)]
        
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func foundPeer() {
        
    }
    func lostPeer() {
        
    }
    
    func invitationWasReceived(fromPeer: String) {
        
    }
    func connectWithPeer(peerID: MCPeerID) {
    }
    
    func handleMPCReceivedDataWithNotification(notification: NSNotification)
    {
        
    }
    
    
    func performReceivedDataLocationPart()
    {
        let data = dataReceived!["locationInfo"]
        self.qa = dataReceived!["qa"]
        if data == nil
        {
            return
        }
        for each in data!{
            let tempText = each.getLocationAndInfo()
            let location = CGRect(x: (tempText?.x)!, y: (tempText?.y)!, width: 55, height: 55)
            let newTextView = UITextView(frame: location)
            self.guessImage.addSubview(newTextView)
            
            newTextView.backgroundColor = UIColor(white: 1.0, alpha: 0.5)
            newTextView.selectable = false
            newTextView.text = tempText?.info
            newTextView.textColor = UIColor.clearColor()
            newTextView.increaseFontSize(4)
            newTextView.editable = false
            newTextView.userInteractionEnabled = true
            self.guessImage.userInteractionEnabled = true
           // newTextView.delegate = self
            newTextView.layer.cornerRadius = newTextView.frame.size.height/2
            newTextView.clipsToBounds = true
            
            newTextView.alpha = 0.04
            
            
            
            //shadow effects-----------------------------------------------
            /*  newtextView.layer.shadowOffset = CGSize(width: 10, height: 20)
             newtextView.layer.shadowOpacity = 0.9
             newtextView.layer.shadowRadius = 6*/
            
            
            //-------------------------------------------------------------
            
            
            
            let tapToFind = UITapGestureRecognizer(target: self, action: #selector(guessViewController.tapFind(_:)))
            newTextView.addGestureRecognizer(tapToFind)
            
            infoHideTextView.infoHideTextView.append(newTextView)
            
        }
        
    }
    
    
    
    func tapFind(gesture: UITapGestureRecognizer)
    {
        if totalTapsAllowed == tapTimes
        {
            return
        }
        print("tap!!!!!!")
        if temptsLeft.text != "unlimites tempts"
        {
            tapTimes += 1
            temptsLeft.text = "\(totalTapsAllowed - tapTimes)"
            temptsLeft.reloadInputViews()
        }
        
        
        let target = gesture.view as? UITextView
        
        let locationView = gesture.locationInView(guessImage)
        
        let hideX = (target?.frame.origin.x)!
        let hideY = (target?.frame.origin.y)!
        
        let tapX = locationView.x
        let tapY = locationView.y
        
        if((tapX >= hideX - 15 && tapX <= hideX + 35) && (tapY >= hideY - 15 && tapY <= hideY + 35))
        {
            print("tap location \(locationView.x):\(locationView.y)")
            print("info location \((target?.frame.origin.x)!)\((target?.frame.origin.y)!)")
            
            if(target?.alpha == 0.75)
            {
                
                return
            }
            target?.hidden = false
            target!.editable = false
            target!.selectable = false
            
            target!.alpha = 0.75
            target!.backgroundColor = UIColor(white: 1.0, alpha: 1.0)
            
            target!.textColor = UIColor.blackColor()
            target?.reloadInputViews()
            
            eggFindNums += 1
            eggsLeft.text = "\((dataReceived!["locationInfo"]?.count)! - eggFindNums) eggs left"
            eggsLeft.reloadInputViews()
            if ((dataReceived!["locationInfo"]?.count)! == eggFindNums)
            {
                self.done = true
                infoSlider.hidden = false
                
            }
        }

        
    }
   

   
}

extension guessViewController:MCSessionDelegate{
    func session(session: MCSession, peer peerID: MCPeerID, didChangeState state: MCSessionState) {
        switch state {
        case MCSessionState.Connecting:
         
            delay(seconds: 0.5, completion: {
                SwiftSpinner.setTitleFont(nil)
                SwiftSpinner.show("Connecting.....")
            })
            
            
        case MCSessionState.Connected:
           
            SwiftSpinner.show("Connected!")
          
          
            print("connected with you")
            
            
        default:
            break
        }
        
    }
    func session(session: MCSession, didFinishReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, atURL localURL: NSURL, withError error: NSError?) {
        
    }
    func session(session: MCSession, didStartReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, withProgress progress: NSProgress) {
        
    }
    func session(session: MCSession, didReceiveStream stream: NSInputStream, withName streamName: String, fromPeer peerID: MCPeerID) {
        
    }
    
    func session(session: MCSession, didReceiveData data: NSData, fromPeer peerID: MCPeerID) {
        
       
        
        
        dispatch_async(dispatch_get_main_queue()){
            
            if self.loadTimes == 0
            {
                
                SwiftSpinner.show("Loading Data....")
                self.loadTimes = 2
                
            }
            else
            {
                //SwiftSpinner.show("Loaded!")
                self.loadTimes = 0
            }
            
            
            self.guessImage.hidden = false
           
            let dict = NSKeyedUnarchiver.unarchiveObjectWithData(data)
            if dict == nil
            {
                self.guessImage.image = UIImage(data: data)
                self.guessImage.reloadInputViews()
            }
            else
            {
                self.dataReceived = NSKeyedUnarchiver.unarchiveObjectWithData(data) as? Dictionary<String,[String]>
               
                
                
            }
            if self.loadTimes != 2
            {
                self.addHideInfo()
                SwiftSpinner.showWithDuration(1.0, title: "Loaded!",animated: false)
               self.answerQuestion.hidden = false
                self.eggsLeft.hidden = false
                self.temptsLeft.hidden = false
                self.temptsLeft.hidden = false
                self.session!.disconnect()
            }
            
        }
        
        
    }
}


















