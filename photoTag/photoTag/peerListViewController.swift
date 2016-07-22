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
    
    @IBOutlet weak var peerTableView: UITableView!
    
    let appDelegate = MPCManager()
    
    var isAdvertising: Bool?

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
        let selectPeer = appDelegate.foundPeer[indexPath.row] as MCPeerID
        appDelegate.browser?.invitePeer(selectPeer, toSession: appDelegate.session!, withContext: nil, timeout: 20)
    }
    
    func foundPeer() {
        print("all peers:")
        for (index,peer) in appDelegate.foundPeer.enumerate(){
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
        }
    }

   
}
















