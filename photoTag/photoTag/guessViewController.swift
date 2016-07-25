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
    
    var done = true

    @IBOutlet weak var clickShowText: UITextView!
    
    
    
    @IBOutlet weak var shadow: GradientView!
    @IBOutlet weak var answerQuestion: UIButton!
    
    @IBOutlet weak var temptsLeft: UILabel!
    
    @IBOutlet weak var eggsLeft: UILabel!
    
    @IBOutlet weak var hintsButton: UIButton!
    
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    
    @IBOutlet weak var guessImage: UIImageView!
    
    @IBOutlet weak var infoSlider: UISlider!
    @IBOutlet weak var swipeText: UITextView!
    
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
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        airDropInit()
        guessImage.hidden = true
        loadingIndicator.startAnimating()
        infoSlider.hidden = true
        shadow.hidden = true
       // swipeText.hidden = true
        swipeText.editable = false
        clickShowText.hidden = true
        clickShowText.editable = false
        
        
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
        
        
        let tapReconginzer = UITapGestureRecognizer(target: self, action: #selector(guessViewController.tapClear(_:)))
        self.view.addGestureRecognizer(tapReconginzer)
        
    }
    
    func tapClear(gesture: UITapGestureRecognizer)
    {
        self.guessImage.alpha = 1.0
        if !done{
            return
        }
        let clickInfo = dataReceived!["clickHidenInfo"]
        
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
                                        
                                        self.infoSlider.hidden = false
                                        self.shadow.hidden = true
                },
                                      completion: nil)
        }
        else
        {
            UIView.transitionWithView(guessImage,
                                      duration:1,
                                      options:  UIViewAnimationOptions.TransitionCrossDissolve ,
                                      animations: {
                                        self.shadow.hidden = true
                                        self.guessImage.alpha = 1.0
                                        self.clickShowText.hidden = true
                                      //  self.clickShowText.text = clickInfo![0]
                                        
                                        
                },
                                      completion: nil)
            
            
        }
        
        
    
    }

    func respondToSwipe(gesture: UIGestureRecognizer)
    {
        self.guessImage.alpha = 1.0
        
        if !done
        {
            return
        }
        
        let upDownLeftRight = dataReceived!["swipeInfo"]
        
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
        
        let selectedValue = Float(sender.value)
        let result = selectedValue / Float(10)
        guessImage.alpha = CGFloat(result)
        clickShowText.hidden = false
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
   

   
}

extension guessViewController:MCSessionDelegate{
    func session(session: MCSession, peer peerID: MCPeerID, didChangeState state: MCSessionState) {
        switch state {
        case MCSessionState.Connected:
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
            
            self.loadingIndicator.stopAnimating()
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
        }
    }
}


















