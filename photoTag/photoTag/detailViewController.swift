//
//  detailViewController.swift
//  photoTag
//
//  Created by Liyuan Liu on 7/13/16.
//  Copyright © 2016 Jerry. All rights reserved.
//

import UIKit
import QuartzCore

class detailViewController: UIViewController, UITextViewDelegate {

    @IBOutlet weak var Guess: UISwitch!
    
    @IBOutlet weak var detailImageView: UIImageView!
    
    @IBOutlet weak var shadow: GradientView!
    
    @IBOutlet weak var information: UITextView!
    
    @IBOutlet weak var clickShowTextView: UITextView!
    
    @IBOutlet weak var slider: UISlider!
    
    @IBOutlet weak var switchHaveFun: UISwitch!

    @IBOutlet weak var addSecretsLabel: UILabel!
    
    
    
    var upDownLeftRight = ["upupupupupup","downdowndown","leftleftleft","rightrightright"]
    
    var slideHiddenInforation = ["000000","11111","22222","33333","44444","55555","666666","777777","888888","9999999"]
    
    var infoHideTextView = TextViewArray()
    
    var tapTimes = 0
    var detailImage: UIImage?
    override func viewDidLoad() {
        super.viewDidLoad()
        
       
      /*  detailImageView.clipsToBounds = true
        
        detailImageView.layer.cornerRadius = detailImageView.frame.size.height/2;*/
        
        
        
        /*detailImageView.frame = self.view.bounds
        detailImageView.blurImage()
        self.view.addSubview(self.detailImageView)*/
        
        detailImageView.image = detailImage
        
        detailImageView.alpha = 1.0
        
        
       /* let mask = CALayer()
        
            let test = UIImage(named: "section.png") as! CGImage
        mask.contents = test
        mask.frame = CGRectMake(0, 0, detailImageView.image!.size.width, detailImageView.image!.size.height)
        detailImageView.layer.mask = mask
        detailImageView.layer.masksToBounds = true*/
        
      /*  var aspect = (detailImage?.size.height)! / (self.view.frame.size.width)
        
        var newHeight = aspect * detailImageView.frame.width
        
        detailImageView.frame = CGRectMake(detailImageView.frame.origin.x, detailImageView.frame.origin.y, self.view.frame.size.width, newHeight)*/
        
        clickShowTextView.hidden = true
        
        switchHaveFun.setOn(false, animated: true)
        Guess.setOn(false, animated: true)
        // slider.hidden = true
        
        clickShowTextView.delegate = self
        information.delegate = self
        
        
        
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
        
        
        let addSecretsRecognizer = UILongPressGestureRecognizer(target: self, action: "longPressSecrets:")
        self.view.addGestureRecognizer(addSecretsRecognizer)
        //detailImageView.userInteractionEnabled = true
    }
    
   
    
    func longPressSecrets(gesture: UILongPressGestureRecognizer)
    {
        if switchHaveFun.on{
            
            let longPress = gesture as UILongPressGestureRecognizer
            let state = longPress.state
            
            switch state{
            case UIGestureRecognizerState.Began:
                let locationView = longPress.locationInView(detailImageView)
               
                
                let location = CGRect(x: locationView.x - 25 , y: locationView.y-25, width: 55, height: 55)
                //let location = CGRect(origin: locationView, size: size)
                
               
                
                let newtextView = UITextView(frame: location)
                self.detailImageView.addSubview(newtextView)
                
                
                newtextView.backgroundColor = UIColor(white: 1.0, alpha: 0.5)
                newtextView.selectable = true
                newtextView.text = "tetteteteoooooooooooooooooooooooooooooo"
                //newtextView.textColor = UIColor.clearColor()
                newtextView.increaseFontSize(4)
                newtextView.editable = true
                newtextView.userInteractionEnabled = true
                self.detailImageView.userInteractionEnabled = true
                newtextView.delegate = self
                newtextView.layer.cornerRadius = newtextView.frame.size.height/2
                newtextView.clipsToBounds = true
                
                infoHideTextView.infoHideTextView.append(newtextView)
                print("begin")
               /* let locationView = longPress.locationInView(detailImageView)
                
                let newtextView = UITextView()
                newtextView.initializeMyArgument()
                
                self.detailImageView.addTextView(locationView,new: newtextView)
                
                infoHideTextView.infoHideTextView.append(newtextView)
                
                print("begin")*/
            case UIGestureRecognizerState.Changed:
                print("change")
            case UIGestureRecognizerState.Ended:
                
                
                
                print("end")
            default:
                break
            }

            
        }
    }
    
    @IBAction func switchAction(sender: AnyObject) {
        self.shadow.hidden = true
        self.detailImageView.alpha = 1.0
        self.clickShowTextView.hidden = true
        
        if switchHaveFun.on{
            self.slider.hidden = true
            if Guess.on{
                Guess.setOn(false, animated: true)
                
            }
            infoHideTextView.show()
            
           
        }
        else
        {
            self.slider.hidden = false
            infoHideTextView.hide()
            
        }
    }
    
    @IBAction func GuessAction(sender: AnyObject) {
        self.shadow.hidden = true
        self.detailImageView.alpha = 1.0
        self.clickShowTextView.hidden = true
        if Guess.on{
            self.slider.hidden = true
            if switchHaveFun.on{
                self.switchHaveFun.setOn(false, animated: true)
                
            }
            infoHideTextView.hide()
        }
        else
        {
            self.slider.hidden = false
            
            //then hide all found view
        }
        
        
    }

    
    
    func tapClear(gesture: UITapGestureRecognizer)
    {
        if switchHaveFun.on || Guess.on{
            
            return
        }
        tapTimes = tapTimes + 1
        if(tapTimes%2 == 1)
        {
            UIView.transitionWithView(detailImageView ,
                duration:1,
                options:  UIViewAnimationOptions.TransitionCrossDissolve ,
                animations: {
                    self.detailImageView.alpha = 0.5
                   
                    self.clickShowTextView.hidden = false
                    self.clickShowTextView.text = "clickShowTextView"
                    
                    self.slider.hidden = false
                    self.shadow.hidden = true
                },
                completion: nil)
        }
        else
        {
            UIView.transitionWithView(shadow,
                duration:1,
                options:  UIViewAnimationOptions.TransitionCrossDissolve ,
                animations: {
                    self.shadow.hidden = true
                    self.detailImageView.alpha = 1.0
                    self.clickShowTextView.hidden = true
                    self.clickShowTextView.text = "clickShowTextView"
                    
                    
                },
                completion: nil)
            
            
        }
        

    }
    func respondToSwipe(gesture: UIGestureRecognizer)
    {
        self.detailImageView.alpha = 1.0
        if switchHaveFun.on || Guess.on{
            return
        }
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
        clickShowTextView.hidden = false
        clickShowTextView.text = slideHiddenInforation[Int(selectedValue)]
        
        
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    func textView(textView: UITextView, shouldChangeTextInRange range: NSRange, replacementText text: String) -> Bool {
        if(text == "\n") {
            textView.resignFirstResponder()
            return false
        }
        return true
    }

}
