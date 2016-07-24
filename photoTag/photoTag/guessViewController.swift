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

    @IBOutlet weak var answerQuestion: UIButton!
    
    @IBOutlet weak var temptsLeft: UILabel!
    
    @IBOutlet weak var eggsLeft: UILabel!
    
    @IBOutlet weak var hintsButton: UIButton!
    
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    
    @IBOutlet weak var guessImage: UIImageView!
    
    func airDropInit()
    {
        self.peerID = MCPeerID(displayName: UIDevice.currentDevice().name)
        self.session = MCSession(peer: peerID!)
        self.session?.delegate = self
        
        self.assistant = MCAdvertiserAssistant(serviceType: serviceType, discoveryInfo: nil, session: self.session!)
        self.assistant?.start()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        airDropInit()
        guessImage.hidden = true
        loadingIndicator.startAnimating()
        
        
        
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
           // var msg = NSString(data: data, encoding: NSUTF8StringEncoding)
            self.loadingIndicator.stopAnimating()
            self.guessImage.hidden = false
            self.guessImage.image = UIImage(data: data)
            self.guessImage.reloadInputViews()
        }
    }
}


















