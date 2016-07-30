//
//  enumCommon.swift
//  photoTag
//
//  Created by Liyuan Liu on 7/5/16.
//  Copyright © 2016 Jerry. All rights reserved.
//

import Foundation
import UIKit

enum flagType : Int{
    case expanded
    case closed
    
}


class TextViewArray{
    var infoHideTextView = [UITextView]()
    init()
    {
        //nothing
    }
    func hide()
    {
        for hide in infoHideTextView{
          
            hide.alpha = 0.04
            hide.textColor = UIColor.clearColor()
            hide.editable = false
            hide.selectable = false
            
        }
    }
    func show()
    {
        for hide in infoHideTextView{
            hide.editable = true
            hide.selectable = true
            
            hide.alpha = 0.75
            hide.backgroundColor = UIColor(white: 1.0, alpha: 1.0)
            
            hide.textColor = UIColor.blackColor()
        }
    }
}

extension RangeReplaceableCollectionType where Generator.Element : Equatable {
    
    // Remove first collection element that is equal to the given `object`:
    mutating func removeObject(object : Generator.Element) {
        if let index = self.indexOf(object) {
            self.removeAtIndex(index)
        }
    }
}

extension UIImageView{
    func blurImage(){
        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.Light)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = self.bounds
        
        blurEffectView.autoresizingMask = [.FlexibleWidth, .FlexibleHeight] // for supporting device rotation
        self.addSubview(blurEffectView)
    }
   /* func addTextView(locationView:CGPoint,new:UITextView)
    {
        let location = CGRect(x: locationView.x - 25 , y: locationView.y-25, width: 55, height: 55)
        new.frame = location
        //let new = UITextView(frame: location)
        new.initializeMyArgument()
        self.addSubview(new)
        
       
    }*/
}


extension UITextView{
    func increaseFontSize(divide:CGFloat)
    {
        self.font =  UIFont(name: self.font!.fontName, size: self.frame.size.height/divide )!
    }
    func initializeMyArgument(){
        self.backgroundColor = UIColor(white: 1.0, alpha: 0.5)
        self.selectable = true
        self.text = "beautifullly you see these words ?tetteteteoooooooooooooooooooooooooooooo"
        
        self.increaseFontSize(4)
        
        self.editable = true
        self.userInteractionEnabled = true
        //self.userInteractionEnabled = true
        //newtextView.delegate = self
        self.layer.cornerRadius = self.frame.size.height/2
        self.clipsToBounds = true
    }
}
struct locationInfoStruct{
    var x:CGFloat
    var y:CGFloat
    var info:String?
}

extension String{
    func getCGFloat()->CGFloat
    {
        let fl = CGFloat((self as NSString).floatValue)
        return fl
    }
    func getLocationAndInfo() -> locationInfoStruct?
    {
        
       
        var array = self.componentsSeparatedByString(",")
        
        let a = array[0].characters.count
        let b = array[1].characters.count
        let index = self.startIndex.advancedBy(a+b+2)
        let info = self.substringFromIndex(index)
        let tempx = CGFloat((array[0] as NSString).floatValue)
        let tempy = CGFloat((array[1] as NSString).floatValue)
       
        let result = locationInfoStruct(x: tempx, y: tempy, info: info)
        
        return result

    }
  /*  func seperateLocationInfo(seperator:Character)->[String]
    {
        var result = [String]()
        
        let tempArray = self.characters.split{$0 == seperator}.map(String.init)
        
        result.append(tempArray[0])
        result.append(tempArray[1])
        
        let a = result[0].characters.count
        let b = result[1].characters.count
        
        let index = self.startIndex.advancedBy(a+b+2)
        let info = self.substringFromIndex(index)
        result.append(info)
        return result
        
        return result
    }*/
}















