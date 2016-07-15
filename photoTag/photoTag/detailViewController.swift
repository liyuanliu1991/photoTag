//
//  detailViewController.swift
//  photoTag
//
//  Created by Liyuan Liu on 7/13/16.
//  Copyright © 2016 Jerry. All rights reserved.
//

import UIKit

class detailViewController: UIViewController {

    
    @IBOutlet weak var detailImageView: UIImageView!
    
    @IBOutlet weak var shadow: GradientView!
    
    @IBOutlet weak var information: UITextView!
    
    var detailImage: UIImage?
    override func viewDidLoad() {
        super.viewDidLoad()

        detailImageView.image = detailImage
        
        shadow.hidden = true
        // Do any additional setup after loading the view.
        
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: "respondToSwipe:")
        swipeLeft.direction = UISwipeGestureRecognizerDirection.Left
        self.view.addGestureRecognizer(swipeLeft)
        
        let swipeRight = UISwipeGestureRecognizer(target: self, action: "respondToSwipe:")
        swipeRight.direction = UISwipeGestureRecognizerDirection.Right
        self.view.addGestureRecognizer(swipeRight)
        
        let swipeDown = UISwipeGestureRecognizer(target: self, action: "respondToSwipe:")
        swipeDown.direction = UISwipeGestureRecognizerDirection.Down
        self.view.addGestureRecognizer(swipeDown)
        
        
        let swipeUp = UISwipeGestureRecognizer(target: self, action: "respondToSwipe:")
        swipeUp.direction = UISwipeGestureRecognizerDirection.Up
        self.view.addGestureRecognizer(swipeUp)
        
        let tapReconginzer = UITapGestureRecognizer(target: self, action: "tapClear:")
        self.view.addGestureRecognizer(tapReconginzer)
        
    }
    func tapClear(gesture: UITapGestureRecognizer)
    {
        UIView.transitionWithView(shadow ,
            duration:1,
            options:  UIViewAnimationOptions.TransitionCrossDissolve ,
            animations: {
                self.shadow.hidden = true
                
            },
            completion: nil)

    }
    func respondToSwipe(gesture: UIGestureRecognizer)
    {
        if let swipeGesture = gesture as? UISwipeGestureRecognizer{
            switch swipeGesture.direction{
            case UISwipeGestureRecognizerDirection.Left:

                UIView.transitionWithView(shadow ,
                    duration:1,
                    options:  UIViewAnimationOptions.TransitionCrossDissolve ,
                    animations: { self.shadow.hidden = false },
                    completion: nil)
                
            case UISwipeGestureRecognizerDirection.Right:
                
                UIView.transitionWithView(shadow ,
                    duration:1,
                    options:  UIViewAnimationOptions.TransitionFlipFromRight ,
                    animations: { self.shadow.hidden = false },
                    completion: nil)
            case UISwipeGestureRecognizerDirection.Up:
                
                UIView.transitionWithView(shadow ,
                    duration:1,
                    options:  UIViewAnimationOptions.TransitionCurlUp,
                    animations: { self.shadow.hidden = false },
                    completion: nil)
            case UISwipeGestureRecognizerDirection.Down:
                
                UIView.transitionWithView(shadow ,
                    duration:1,
                    options:  UIViewAnimationOptions.TransitionCurlDown,
                    animations: { self.shadow.hidden = false },
                    completion: nil)

                
            default:
                break
                
            }
        }
        
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


}
