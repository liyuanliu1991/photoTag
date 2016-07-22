//
//  peerListViewController.swift
//  photoTag
//
//  Created by Liyuan Liu on 7/21/16.
//  Copyright © 2016 Jerry. All rights reserved.
//

import UIKit
import MultipeerConnectivity

class peerListViewController: UIViewController,MPCManagerDelegate,UITableViewDelegate, UITableViewDataSource{
    
    var dataToSend: dataSend?
    
    @IBOutlet weak var peerTableView: UITableView!
    
    let appDelegate = MPCManager()
    
    var isAdvertising: Bool?
    
    var selectPeer: MCPeerID?

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        appDelegate.foundPeer.removeAll()
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        appDelegate.delegate = self
        appDelegate.browser?.startBrowsingForPeers()
        appDelegate.advertiser?.startAdvertisingPeer()
        isAdvertising = true
    }

    override func viewWillDisappear(animated: Bool) {
        appDelegate.session?.disconnect()
        appDelegate.foundPeer.removeAll()
        
    }
    override func didReceiveMemoryWarning() {
        
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("num is \(appDelegate.foundPeer.count)")
        return appDelegate.foundPeer.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("peerCell")
        cell?.textLabel?.text = appDelegate.foundPeer[indexPath.row].displayName
        return cell!
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 50
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        selectPeer = appDelegate.foundPeer[indexPath.row] as MCPeerID
        appDelegate.browser?.invitePeer(selectPeer!, toSession: appDelegate.session!, withContext: nil, timeout: 20)
    }
    
    func foundPeer() {
        print("all peers:")
        for (_,peer) in appDelegate.foundPeer.enumerate(){
            print("found peer tablew view \( peer.displayName )")
        }
        
        peerTableView.reloadData()
        
    }
    func lostPeer() {
        
        print("lost peer")
        peerTableView.reloadData()
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
            
           
            
            
            var data: Dictionary<String,NSData> = ["imageData":(self.dataToSend?.imageData)!]
            
          //  let a = (self.dataToSend?.imageData)!
            
           // data["imageData"] = a
            
         /*   data!["clickHideInfo"] = self.dataToSend?.clickHideInfo
            data!["leftInfo"] = self.dataToSend?.leftInfo
            data!["rightInfo"] = self.dataToSend?.rightInfo
            data!["upInfo"] = self.dataToSend?.upInfo
            data!["downInfo"] = self.dataToSend?.downInfo*/
         /*   data["sliderInfo"] = self.dataToSend?.sliderInfo
            data["textViewArray"] = self.dataToSend?.textViewArray
            data["hints"] = self.dataToSend?.hints
            data["questions"] = self.dataToSend?.questions
            data["temptsNum"] = self.dataToSend?.temptsNum*/
            
            
        //    self.appDelegate.sendData(testMsg, toPeer: self.selectPeer!)
            self.appDelegate.sendData(data, toPeer: self.selectPeer!)
            
        }
    }

   
}
















