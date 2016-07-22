//
//  MPCManager.swift
//  photoTag
//
//  Created by Liyuan Liu on 7/19/16.
//  Copyright © 2016 Jerry. All rights reserved.
//

import UIKit
import MultipeerConnectivity

protocol MPCManagerDelegate{
    func foundPeer()
    func lostPeer()
    func invitationWasReceived(fromPeer:String)
    func connectWithPeer(peerID: MCPeerID)
}

class MPCManager: NSObject, MCSessionDelegate, MCNearbyServiceAdvertiserDelegate, MCNearbyServiceBrowserDelegate {
    
    var delegate: MPCManagerDelegate?
    var session: MCSession?
    var peer: MCPeerID?
    var browser: MCNearbyServiceBrowser?
    var advertiser: MCNearbyServiceAdvertiser?
    var foundPeer = [MCPeerID]()
    var invitationHandler:((Bool,MCSession) -> Void)?
    
    override init() {
        super.init()
        
        peer = MCPeerID(displayName: UIDevice.currentDevice().name)
        
        session = MCSession(peer: peer!)
        session?.delegate = self
        
        browser = MCNearbyServiceBrowser(peer: peer!, serviceType: "appcoda-mpc")
        browser?.delegate = self
        
        advertiser = MCNearbyServiceAdvertiser(peer: peer!, discoveryInfo: nil, serviceType: "appcoda-mpc")
        advertiser?.delegate = self
        
    }
    
    func browser(browser: MCNearbyServiceBrowser, foundPeer peerID: MCPeerID, withDiscoveryInfo info: [String : String]?) {
        for (_,aPeer) in foundPeer.enumerate(){
            if aPeer.displayName == peerID.displayName{
                return
            }
        }
        foundPeer.append(peerID)
        delegate?.foundPeer()
    }

    func browser(browser: MCNearbyServiceBrowser, lostPeer peerID: MCPeerID) {
        for (index, aPeer) in foundPeer.enumerate(){
            if aPeer == peerID{
                foundPeer.removeAtIndex(index)
                break
            }
        }
        delegate?.lostPeer()
    }
    func browser(browser: MCNearbyServiceBrowser, didNotStartBrowsingForPeers error: NSError) {
        print(error.localizedDescription)
    }
    
    func advertiser(advertiser: MCNearbyServiceAdvertiser, didReceiveInvitationFromPeer peerID: MCPeerID, withContext context: NSData?, invitationHandler: (Bool, MCSession) -> Void) {
        self.invitationHandler = invitationHandler
        delegate?.invitationWasReceived(peerID.displayName)
    }
    func advertiser(advertiser: MCNearbyServiceAdvertiser, didNotStartAdvertisingPeer error: NSError) {
        print(error.localizedDescription)
    }
    
    // MARK: MCSessionDelegate method implementation
    func session(session: MCSession, peer peerID: MCPeerID, didChangeState state: MCSessionState) {
        switch state{
        case MCSessionState.Connected:
            print("connected to session:\(session)")
            delegate?.connectWithPeer(peerID)
        case MCSessionState.Connecting:
            print("Connecting to session: \(session)")
        default:
            print("Did not connect to session: \(session)")
        }
    }
    
    func session(session: MCSession, didReceiveData data: NSData, fromPeer peerID: MCPeerID) {
        let dictionary:[String:AnyObject] = ["data": data, "fromPeer": peerID]
        NSNotificationCenter.defaultCenter().postNotificationName("receivedMPCDataNotification", object: dictionary)
    }
    
    func session(session: MCSession, didStartReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, withProgress progress: NSProgress) { }
    
    func session(session: MCSession, didFinishReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, atURL localURL: NSURL, withError error: NSError?) { }
    
    func session(session: MCSession, didReceiveStream stream: NSInputStream, withName streamName: String, fromPeer peerID: MCPeerID) { }
    
    // MARK: Custom method implementation
    func sendData(dataToSend:dataSend,toPeer: MCPeerID)->Bool{
        let dataToSend = NSKeyedArchiver.archivedDataWithRootObject(dataToSend)
        var peerArray = [MCPeerID]()
        peerArray.append(toPeer)

        do {
            try self.session!.sendData(dataToSend, toPeers: peerArray, withMode: MCSessionSendDataMode.Reliable)
            print("success")
            // do something
        } catch {
            print("failure")
            // do something else
        }
        return true
    }
    

}




class dataSend{
    var imageData:NSData
    var clickHideInfo:String?
    var leftInfo:String?
    var rightInfo:String?
    var upInfo:String?
    var downInfo:String?
    var sliderInfo:[String]?
    var locationInfo:Dictionary<String, String?>//location string, hideinfo string
    var hints:[String]?
    var questions:Dictionary<String, String?> // question and answer
    var temptsNum: Int
 
    init(imageData: NSData, clickHideInfo:String?,leftInfo:String?,rightInfo:String?,upInfo:String?,downInfo:String?,sliderInfo:[String]?,locationInfo:Dictionary<String, String?>,hints:[String]?,questions:Dictionary<String, String?>,temptsNum: Int)
    {
        self.imageData = imageData
        if let clickHideInfo = clickHideInfo{
            self.clickHideInfo = clickHideInfo
        }
        if let leftInfo = leftInfo{
            self.leftInfo = leftInfo
        }
        if let rightInfo = rightInfo{
            self.rightInfo = rightInfo
        }
        if let upInfo = upInfo{
            self.upInfo = upInfo
        }
        if let downInfo = downInfo{
            self.downInfo = downInfo
        }
        if let sliderInfo = sliderInfo{
            self.sliderInfo = sliderInfo
        }
        self.locationInfo = locationInfo
        if let hints = hints{
            self.hints = hints
        }
        self.questions = questions
        self.temptsNum = temptsNum
        
    }
}





























