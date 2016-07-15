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
    
    @IBOutlet weak var clickShowTextView: UITextView!
    
    @IBOutlet weak var slider: UISlider!
    
    
    var upDownLeftRight = ["upupupupupup","downdowndown","leftleftleft","rightrightright"]
    
    var slideHiddenInforation = ["000000","11111","22222","33333","44444","55555","666666","777777","888888","9999999"]
    
    var tapTimes = 1
    var detailImage: UIImage?
    override func viewDidLoad() {
        super.viewDidLoad()

        detailImageView.image = detailImage
        
        detailImageView.alpha = 1.0
        
       // slider.hidden = true
        
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
        tapTimes = tapTimes + 1
        if(tapTimes%2 == 1)
        {
            UIView.transitionWithView(shadow,
                duration:1,
                options:  UIViewAnimationOptions.TransitionCrossDissolve ,
                animations: {
                    self.shadow.hidden = true
                    self.detailImageView.alpha = 1.0
                   // self.slider.hidden = true
                    
                },
                completion: nil)
        }
        else
        {
            UIView.transitionWithView(detailImageView ,
                duration:1,
                options:  UIViewAnimationOptions.TransitionCrossDissolve ,
                animations: {
                    self.detailImageView.alpha = 0.5
                    self.clickShowTextView.text = "clickShowTextView"
                    
                    self.slider.hidden = false
                    self.shadow.hidden = true
                },
                completion: nil)
        }
        

    }
    func respondToSwipe(gesture: UIGestureRecognizer)
    {
        self.detailImageView.alpha = 1.0
        if let swipeGesture = gesture as? UISwipeGestureRecognizer{
            switch swipeGesture.direction{
            case UISwipeGestureRecognizerDirection.Left:

                UIView.transitionWithView(shadow ,
                    duration:1,
                    options:  UIViewAnimationOptions.TransitionCrossDissolve ,
                    animations: { self.shadow.hidden = false
                        self.information.text = self.upDownLeftRight[2]
                    },
                    completion: nil)
                
            case UISwipeGestureRecognizerDirection.Right:
                
                UIView.transitionWithView(shadow ,
                    duration:1,
                    options:  UIViewAnimationOptions.TransitionFlipFromRight ,
                    animations: { self.shadow.hidden = false
                        self.information.text = self.upDownLeftRight[3]
                    },
                    completion: nil)
            case UISwipeGestureRecognizerDirection.Up:
                
                UIView.transitionWithView(shadow ,
                    duration:1,
                    options:  UIViewAnimationOptions.TransitionCurlUp,
                    animations: { self.shadow.hidden = false
                        self.information.text = self.upDownLeftRight[0]
                    },
                    completion: nil)
            case UISwipeGestureRecognizerDirection.Down:
                
                UIView.transitionWithView(shadow ,
                    duration:1,
                    options:  UIViewAnimationOptions.TransitionCurlDown,
                    animations: { self.shadow.hidden = false
                        self.information.text = self.upDownLeftRight[1]
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
        detailImageView.alpha = CGFloat(result)
        
        clickShowTextView.text = slideHiddenInforation[Int(selectedValue)]
        
        
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


}
