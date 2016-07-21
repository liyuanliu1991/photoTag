//
//  guessViewController.swift
//  photoTag
//
//  Created by Liyuan Liu on 7/19/16.
//  Copyright © 2016 Jerry. All rights reserved.
//

import UIKit
import MultipeerConnectivity

class guessViewController: UIViewController, MPCManagerDelegate {

    @IBOutlet weak var answerQuestion: UIButton!
    
    @IBOutlet weak var temptsLeft: UILabel!
    
    @IBOutlet weak var eggsLeft: UILabel!
    
    @IBOutlet weak var hintsButton: UIButton!
    
    @IBOutlet weak var slider: UISlider!
    
    @IBOutlet weak var guessImage: UIImageView!
    
    @IBOutlet weak var shadow: GradientView!
    
    var isAdvertising: Bool?
    var mpcManager: MPCManager?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let recvButton = UIBarButtonItem(title: "Hide Me", style: .Plain, target: self, action: "stopAdvertising:")
        navigationItem.rightBarButtonItem = recvButton

        self.shadow.hidden = true
        slider.hidden = true
        
        mpcManager?.advertiser?.startAdvertisingPeer()
        
        isAdvertising = true
        mpcManager?.delegate = self
        
        // Do any additional setup after loading the view.
    }

    func invitationWasReceived(fromPeer: String) {
        let alert = UIAlertController(title: "", message: "\(fromPeer) wants to chat with you.", preferredStyle: UIAlertControllerStyle.Alert)
        
        let acceptAction: UIAlertAction = UIAlertAction(title: "Accept", style: UIAlertActionStyle.Default) { (alertAction) -> Void in
            self.mpcManager!.invitationHandler!(true, self.mpcManager!.session!)
        }
        
        let declineAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel) { (alertAction) -> Void in
            //self.mpcManager.invitationHandler(false, nil)
            print("decline")
        }
        
        alert.addAction(acceptAction)
        alert.addAction(declineAction)
        
    /*    NSOperationQueue.mainQueue().addOperationWithBlock { () -> Void in
            self.presentViewController(alert, animated: true, completion: nil)
        }*/
    }
    func connectWithPeer(peerID: MCPeerID) {
        //start to recv data
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "handleMPCReceivedDataWithNotification:", name: "receivedMPCDataNotification", object: nil)
    }
    func handleMPCReceivedDataWithNotification(notification:NSNotification)
    {
        let receivedDataDictionary = notification.object as! Dictionary<String,AnyObject>
        
        let data = receivedDataDictionary["data"] as? NSData
        let fromPeer = receivedDataDictionary["fromPeer"] as! MCPeerID
        
        let dataRecv = NSKeyedUnarchiver.unarchiveObjectWithData(data!) as! dataSend
        
        //print("\(dataRecv.hints),\(),\()")
    }
    
    func lostPeer() {
        
    }
    func foundPeer() {
        
    }
    
    func stopAdvertising(sender: UIBarButtonItem)
    {
        mpcManager?.advertiser?.stopAdvertisingPeer()
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
