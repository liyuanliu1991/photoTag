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
            hide.hidden = true
        }
    }
    func show()
    {
        for hide in infoHideTextView{
            hide.hidden = false
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
}



















