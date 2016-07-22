//
//  guessViewController.swift
//  photoTag
//
//  Created by Liyuan Liu on 7/19/16.
//  Copyright © 2016 Jerry. All rights reserved.
//

import UIKit
import MultipeerConnectivity

class guessViewController: UIViewController,MPCManagerDelegate {
    
    var appDelegate = MPCManager()
    
    var isAdvertising: Bool?


    @IBOutlet weak var answerQuestion: UIButton!
    
    @IBOutlet weak var temptsLeft: UILabel!
    
    @IBOutlet weak var eggsLeft: UILabel!
    
    @IBOutlet weak var hintsButton: UIButton!
    
    @IBOutlet weak var slider: UISlider!
    
    @IBOutlet weak var guessImage: UIImageView!
    
    @IBOutlet weak var shadow: GradientView!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let recvButton = UIBarButtonItem(title: "Hide Me", style: .Plain, target: self, action: "stopAdvertising:")
        navigationItem.rightBarButtonItem = recvButton

        self.shadow.hidden = true
        slider.hidden = true
        
        appDelegate.delegate = self
       // appDelegate.browser?.startBrowsingForPeers()
        appDelegate.advertiser?.startAdvertisingPeer()
        isAdvertising = true

        
   
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func foundPeer() {
        print("found p")
    }
    func lostPeer() {
        print("lost")
    }
    
    func invitationWasReceived(fromPeer: String) {
        let alert = UIAlertController(title: "", message: "\(fromPeer) wants to send you photo.", preferredStyle: UIAlertControllerStyle.Alert)
        
        let acceptAction: UIAlertAction = UIAlertAction(title: "Accept", style: UIAlertActionStyle.Default) { (alertAction) -> Void in
            self.appDelegate.invitationHandler!(true, self.appDelegate.session!)
        }
        
        let declineAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel) { (alertAction) -> Void in
            self.appDelegate.invitationHandler!(false, self.appDelegate.session!)
        }
        
        alert.addAction(acceptAction)
        alert.addAction(declineAction)
        
        NSOperationQueue.mainQueue().addOperationWithBlock { () -> Void in
            self.presentViewController(alert, animated: true, completion: nil)
        }
        
    }
    func connectWithPeer(peerID: MCPeerID) {
        NSOperationQueue.mainQueue().addOperationWithBlock { () -> Void in
            print("connected with \(peerID.displayName )")
        }
    }


   
}
