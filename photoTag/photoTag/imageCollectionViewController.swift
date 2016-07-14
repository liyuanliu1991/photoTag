//
//  imageCollectionViewController.swift
//  photoTag
//
//  Created by Liyuan Liu on 7/11/16.
//  Copyright © 2016 Jerry. All rights reserved.
//

import UIKit



class imageCollectionViewController: UICollectionViewController {
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
        if let photos = photos
        {
            let  k = photos.photoSet.count
            return photos.photoSet.count
        }
        // #warning Incomplete implementation, return the number of items
        return 0
    }

    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("photoCell", forIndexPath: indexPath) as! imageCollectionViewCell
        
        cell.imageView.image = photos?.photoSet[indexPath.row].image
        
     //   cell.upLabel.text = photos?.photoSet[indexPath.row].upLabel
      //  cell.rightLabel.text = photos?.photoSet[indexPath.row].rightLabel
        //cell.downLabel.text = photos?.photoSet[indexPath.row].downLabel
       // cell.upLabel.hidden = true
       // cell.rightLabel.hidden = true
       // cell.downLabel.hidden = true
        
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: "respondToSwipe:")
        swipeLeft.direction = UISwipeGestureRecognizerDirection.Left
        self.view.addGestureRecognizer(swipeLeft)
        
        let swipeRight = UISwipeGestureRecognizer(target: self, action: "respondToSwipe:")
        swipeRight.direction = UISwipeGestureRecognizerDirection.Right
        self.view.addGestureRecognizer(swipeRight)
        
      /*  let swipeUp = UISwipeGestureRecognizer(target: self, action: "respondToSwipe:")
        swipeUp.direction = UISwipeGestureRecognizerDirection.Up
        self.view.addGestureRecognizer(swipeUp)
        
        let swipeDown = UISwipeGestureRecognizer(target: self, action: "respondToSwipe:")
        swipeDown.direction = UISwipeGestureRecognizerDirection.Down
        self.view.addGestureRecognizer(swipeDown)*/

        // Configure the cell
    
        return cell
    }
    func respondToSwipe(gesture: UIGestureRecognizer)
    {
        if let swipeGesture = gesture as? UISwipeGestureRecognizer{
            switch swipeGesture.direction{
            case UISwipeGestureRecognizerDirection.Left:
                let swipe = gesture as! UISwipeGestureRecognizer
                var locationInView = swipe.locationInView(collectionView)
                var indexPath = collectionView?.indexPathForItemAtPoint(locationInView)
                if(indexPath == nil)
                {
                    indexPath = NSIndexPath(forRow: 0, inSection: 0)
                }
                photos?.photoSet.removeAtIndex(indexPath!.row)
                
                collectionView?.deleteItemsAtIndexPaths([indexPath!])
            case UISwipeGestureRecognizerDirection.Right:
                
                let swipe = gesture as! UISwipeGestureRecognizer
                var locationInView = swipe.locationInView(collectionView)
                var indexPath = collectionView?.indexPathForItemAtPoint(locationInView)
                if(indexPath == nil)
                {
                    indexPath = NSIndexPath(forRow: 0, inSection: 0)
                }
                print("right")
                
                let cell = collectionView?.cellForItemAtIndexPath(indexPath!) as! imageCollectionViewCell
                
                if photos?.photoSet[indexPath!.row].showHidenImage == true
                {
                    photos?.photoSet[indexPath!.row].showHidenImage = false
                    let toImage = photos?.photoSet[indexPath!.row].image
                    UIView.transitionWithView(cell.imageView ,
                        duration:2,
                        options: UIViewAnimationOptions.TransitionCrossDissolve,
                        animations: { cell.imageView.image = toImage },
                        completion: nil)
                }
                else
                {
                    photos?.photoSet[indexPath!.row].showHidenImage = true
                    
                    let toImage = photos?.photoSet[indexPath!.row].hiddenImage
                    UIView.transitionWithView(cell.imageView ,
                        duration:1,
                        options: UIViewAnimationOptions.TransitionFlipFromRight ,
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
        
        let width = CGRectGetWidth(collectionView.bounds) / 2
        let ratio =  (photos?.photoSet[indexPath.row].image?.size.height)! / (photos?.photoSet[indexPath.row].image?.size.width)!
        
        let result = width * ratio
        return result
        
    }
    
    
}

