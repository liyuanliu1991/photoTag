//
//  imageCollectionViewController.swift
//  photoTag
//
//  Created by Liyuan Liu on 7/11/16.
//  Copyright © 2016 Jerry. All rights reserved.
//

import UIKit
import AVFoundation
import AssetsLibrary
import MobileCoreServices
import Foundation

class imageCollectionViewController: UICollectionViewController,UINavigationControllerDelegate {
    private let reuseIdentifier = "photoCell"
    
    var photos:albumCellModel?
    var mylayout: WaterfallLayout?
    override func viewDidLoad() {
        super.viewDidLoad()

        
        
        navigationController?.toolbarHidden = true
        
        let layout = collectionViewLayout as! WaterfallLayout
        layout.delegate = self
        layout.numberOfColums = 2
        mylayout = layout
        
        let plusButton = UIBarButtonItem(title: "Add", style: .Plain, target: self, action: "Add:")
        navigationItem.rightBarButtonItem = plusButton
        
     //   let takePhotoButton = UIBarButtonItem(title: "Take Photo", style: .Plain, target: self, action: "TakePhoto:")
      //  navigationItem.leftBarButtonItem = takePhotoButton
        
    }
    
    func TakePhoto(sender:UIBarButtonItem)
    {
        if isCameraAvailable() && doesCameraSupportTakingPhotos()
        {
            let controller = UIImagePickerController()
            controller.view.backgroundColor = UIColor.whiteColor()
            controller.sourceType = UIImagePickerControllerSourceType.Camera
            controller.mediaTypes = [kUTTypeImage as String]
            controller.allowsEditing = true
            controller.delegate = self
            
            let sysVersion = (UIDevice.currentDevice().systemVersion as NSString).floatValue
            if sysVersion >= 8.0{
                controller.modalPresentationStyle = UIModalPresentationStyle.OverCurrentContext
            }
            
            if !self.isAuthorized(){
                if sysVersion >= 8.0 {
                    let alertVC = UIAlertController(title: nil, message: "deny", preferredStyle: UIAlertControllerStyle.Alert)
                    let openIt = UIAlertAction(title: "open", style: UIAlertActionStyle.Default, handler: { (alert:UIAlertAction) -> Void in
                        UIApplication.sharedApplication().openURL(NSURL(string: UIApplicationOpenSettingsURLString)!)
                    })
                    alertVC.addAction(openIt)
                    self.presentViewController(alertVC, animated: true, completion: nil)
                }else{
                    let alertVC = UIAlertController(title: "notice", message: "please set privacy", preferredStyle: UIAlertControllerStyle.Alert)
                    self.presentViewController(alertVC, animated: true, completion: nil)
                }
            }else{
                self.presentViewController(controller, animated: true, completion: nil)
            }
        }else{
            print("doesn't support taking photo")
            
        }
        

    }
    
    func Add(sender:UIBarButtonItem)
    {
        if self.isPhotoLibraryAvailable(){
            let controller = UIImagePickerController()
            controller.view.backgroundColor = UIColor.whiteColor()
            controller.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
            var mediaTypes = [String]()
            if self.canUserPickPhotosFromPhotoLibrary()
            {
                mediaTypes.append(kUTTypeImage as String)
                
            }
            controller.allowsEditing = true
            controller.mediaTypes = mediaTypes
            if (UIDevice.currentDevice().systemVersion as NSString).floatValue >= 8.0{
                controller.modalPresentationStyle = UIModalPresentationStyle.OverCurrentContext
            }
            controller.delegate = self
            self.presentViewController(controller, animated: true, completion: nil)
            
        }
        else
        {
            print("doesn't support")
        }

        
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

  
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showDetail"{
            let detail = segue.destinationViewController as! detailViewController
            let cell = collectionView?.indexPathsForSelectedItems()
            
            if photos?.photoSet[cell![0].row].showHidenImage == true
            {
                detail.detailImage = photos?.photoSet[cell![0].row].hiddenImage
            }
            else
            {
                detail.detailImage = photos?.photoSet[cell![0].row].image
            }
            
            
        }
    }

    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let  k = photos!.photoSet.count
        if let photos = photos
        {
            return photos.photoSet.count
        }
        // #warning Incomplete implementation, return the number of items
        return 0
    }

    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("photoCell", forIndexPath: indexPath) as! imageCollectionViewCell
        
        cell.imageView.image = photos?.photoSet[indexPath.row].image
        
        let i = indexPath.row
        
        
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: "respondToSwipe:")
        swipeLeft.direction = UISwipeGestureRecognizerDirection.Left
        self.view.addGestureRecognizer(swipeLeft)
        
        let swipeRight = UISwipeGestureRecognizer(target: self, action: "respondToSwipe:")
        swipeRight.direction = UISwipeGestureRecognizerDirection.Right
        self.view.addGestureRecognizer(swipeRight)
      
    
        return cell
    }
    func respondToSwipe(gesture: UIGestureRecognizer)
    {
        if let swipeGesture = gesture as? UISwipeGestureRecognizer{
            switch swipeGesture.direction{
            case UISwipeGestureRecognizerDirection.Left:
                let swipe = gesture as! UISwipeGestureRecognizer
                let locationInView = swipe.locationInView(collectionView)
                var indexPath = collectionView?.indexPathForItemAtPoint(locationInView)
                if(indexPath == nil)
                {
                    indexPath = NSIndexPath(forRow: 0, inSection: 0)
                }
                photos?.photoSet.removeAtIndex(indexPath!.row)
                
                collectionView?.deleteItemsAtIndexPaths([indexPath!])
            case UISwipeGestureRecognizerDirection.Right:
                
                let swipe = gesture as! UISwipeGestureRecognizer
                let locationInView = swipe.locationInView(collectionView)
                var indexPath = collectionView?.indexPathForItemAtPoint(locationInView)
                if(indexPath == nil)
                {
                    indexPath = NSIndexPath(forRow: 0, inSection: 0)
                }
              
                
                let cell = collectionView?.cellForItemAtIndexPath(indexPath!) as! imageCollectionViewCell
                
                var effect = [ UIViewAnimationOptions.TransitionCrossDissolve,UIViewAnimationOptions.TransitionCurlDown,UIViewAnimationOptions.TransitionCurlUp, UIViewAnimationOptions.TransitionFlipFromBottom, UIViewAnimationOptions.TransitionFlipFromLeft, UIViewAnimationOptions.TransitionFlipFromRight,UIViewAnimationOptions.TransitionFlipFromTop,UIViewAnimationOptions.TransitionNone]
                

            

                if photos?.photoSet[indexPath!.row].showHidenImage == true
                {
                    photos?.photoSet[indexPath!.row].showHidenImage = false
                    let toImage = photos?.photoSet[indexPath!.row].image
                    
                    
                    UIView.transitionWithView(cell.imageView ,
                        duration:1,
                        options: effect[indexPath!.row % 8],
                        animations: { cell.imageView.image = toImage },
                        completion: nil)
                }
                else
                {
                    photos?.photoSet[indexPath!.row].showHidenImage = true
                    
                    let toImage = photos?.photoSet[indexPath!.row].hiddenImage
                    UIView.transitionWithView(cell.imageView ,
                        duration:1,
                        options: effect[7 - indexPath!.row % 8] ,
                        animations: { cell.imageView.image = toImage },
                        completion: nil)

                }
                
                cell.reloadInputViews()
            
                
                default:
                break
            }
        }
    }

   
}

extension imageCollectionViewController: WaterfallLayoutDelegate {
    
    func collectionView(collectionView: UICollectionView, heightForItemAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        let k = indexPath.row
        
        let width = CGRectGetWidth(collectionView.bounds) / 2
        let ratio =  (photos?.photoSet[indexPath.row].image?.size.height)! / (photos?.photoSet[indexPath.row].image?.size.width)!
        
        let result = width * ratio
        return result
        
    }
    
    
}

extension imageCollectionViewController:UIImagePickerControllerDelegate{
    //MARK: UIImagePickerControllerDelegate
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        let mediaType = info[UIImagePickerControllerMediaType] as! NSString
        if mediaType.isEqualToString(kUTTypeImage as String) {
            let theImage : UIImage!
            if picker.allowsEditing{
                theImage = info[UIImagePickerControllerEditedImage] as! UIImage
            }else{
                theImage = info[UIImagePickerControllerOriginalImage] as! UIImage
            }
            
            
            let indexPath = NSIndexPath(forRow: 0, inSection: 0)
            
            let data = UIImagePNGRepresentation(theImage)
            let newAdd = imageCellModel(imageName: nil, checkIconName: nil,data: data)
            self.photos?.photoSet.insert(newAdd, atIndex: 0)
            
            UIView.animateWithDuration(1.0, delay: 0, usingSpringWithDamping: 0.65, initialSpringVelocity: 0.0, options: .CurveEaseInOut, animations: { () -> Void in
                
              //  self.collectionView!.insertItemsAtIndexPaths([indexPath])
                self.collectionView?.reloadData()
                
                }, completion: nil)
            
            //self.myImageView.image=theImage
        }else{
            
        }
        picker.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        picker.dismissViewControllerAnimated(true) { () -> Void in
            
            print("Cancel")
        }
    }
    
    
    
    func isCameraAvailable() -> Bool{
        return UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera)
    }
    
    
    func isFrontCameraAvailable() -> Bool{
        return UIImagePickerController.isCameraDeviceAvailable(UIImagePickerControllerCameraDevice.Front)
    }
    
    
    func isRearCameraAvailable() -> Bool{
        return UIImagePickerController.isCameraDeviceAvailable(UIImagePickerControllerCameraDevice.Rear)
    }
    
    
    
    func cameraSupportsMedia(paramMediaType:NSString, sourceType:UIImagePickerControllerSourceType) -> Bool {
        var result = false
        if paramMediaType.length == 0 {
            return false
        }
        let availableMediaTypes = NSArray(array: UIImagePickerController.availableMediaTypesForSourceType(sourceType)!)
        availableMediaTypes.enumerateObjectsUsingBlock { (obj:AnyObject, idx:NSInteger, stop:UnsafeMutablePointer<ObjCBool>) -> Void in
            let type = obj as! NSString
            if type.isEqualToString(paramMediaType as String) {
                result = true
                stop.memory = true
            }
        }
        return result
    }
    
    
    func isAuthorized() -> Bool{
        let mediaType = AVMediaTypeVideo
        let authStatus = AVCaptureDevice.authorizationStatusForMediaType(mediaType)
        if authStatus == AVAuthorizationStatus.Restricted ||
            authStatus == AVAuthorizationStatus.Denied{
                return false
        }
        return true
    }
    
    
    func doesCameraSupportShootingVides() -> Bool{
        return self.cameraSupportsMedia(kUTTypeMovie, sourceType: UIImagePickerControllerSourceType.Camera)
    }
    
    func doesCameraSupportTakingPhotos() -> Bool{
        return self.cameraSupportsMedia(kUTTypeImage, sourceType: UIImagePickerControllerSourceType.Camera)
    }
    
    
    
    func isPhotoLibraryAvailable() -> Bool {
        return UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.PhotoLibrary)
    }
    
    func canUserPickPhotosFromPhotoLibrary() -> Bool {
        return self.cameraSupportsMedia(kUTTypeImage, sourceType: UIImagePickerControllerSourceType.PhotoLibrary)
    }

}

