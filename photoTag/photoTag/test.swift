//
//  test.swift
//  photoTag
//
//  Created by Liyuan Liu on 7/27/16.
//  Copyright © 2016 Jerry. All rights reserved.
//

import UIKit

@IBDesignable

class test: UITextView {

   
    var lineWidth:CGFloat{
        return bounds.height/4
    }
    let margin:CGFloat = 10
    
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        
       /* UIView.animateWithDuration(1.0, delay: 0, usingSpringWithDamping: 0.65, initialSpringVelocity: 0.0, options: .CurveEaseInOut, animations: { () -> Void in*/
            
            let test = CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height)
            let s = CGSize(width: 20, height: 50)
            let path = UIBezierPath(roundedRect: test, byRoundingCorners: .AllCorners, cornerRadii: s)
            
            UIColor.redColor().setFill()
            path.stroke()
            
            path.lineWidth = self.lineWidth
            
            UIColor.blueColor().setFill()
            path.fill()
            
         //   }, completion: nil)
        
       
        
    }
    

}
