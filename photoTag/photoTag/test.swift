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

/*  func longPressGestureRecognized(gesture:UILongPressGestureRecognizer)
 {
 let longPress = gesture as UILongPressGestureRecognizer
 let state = longPress.state
 let locationInView = longPress.locationInView(tableView)
 var indexPath = tableView.indexPathForRowAtPoint(locationInView)
 
 switch state{
 case UIGestureRecognizerState.Began:
 if(initPath?.section == nil)
 {
 if(initPath?.row == nil)
 {
 initPath = NSIndexPath(forRow: 0, inSection: 0)
 }
 else
 {
 initPath = NSIndexPath(forRow: (initPath?.row)!, inSection: 0)
 }
 
 }
 if (initPath?.row == nil)
 {
 initPath = NSIndexPath(forRow: 0, inSection: (initPath?.section)!)
 }
 if(indexPath?.section == nil)
 {
 if(indexPath?.row == nil)
 {
 indexPath = NSIndexPath(forRow: 0, inSection: 0)
 }
 else
 {
 indexPath = NSIndexPath(forRow: (indexPath?.row)!, inSection: 0)
 }
 
 }
 if (indexPath?.row == nil)
 {
 indexPath = NSIndexPath(forRow: 0, inSection: indexPath!.section)
 }
 if (initPath?.section)! >= allDataSets.categoryCellSets.count && (initPath?.section)! != 0
 {
 initPath = NSIndexPath(forRow: (initPath?.row)!, inSection: allDataSets.categoryCellSets.count - 1)
 }
 if (initPath?.row)! >= allDataSets.categoryCellSets[initPath!.section].albumSets.count && (initPath?.row)! != 0{
 initPath = NSIndexPath(forRow: allDataSets.categoryCellSets[initPath!.section].albumSets.count - 1, inSection: (initPath?.section)!)
 
 }
 if (indexPath?.section)! >= allDataSets.categoryCellSets.count && (indexPath?.section)! != 0{
 indexPath = NSIndexPath(forRow: indexPath!.row, inSection: allDataSets.categoryCellSets.count - 1)
 }
 if (indexPath?.row)! >= allDataSets.categoryCellSets[(indexPath?.section)!].albumSets.count && (indexPath?.row)! != 0{
 indexPath = NSIndexPath(forRow: allDataSets.categoryCellSets[(indexPath?.section)!].albumSets.count - 1, inSection: indexPath!.section)
 }
 
 
 
 _ = allDataSets.categoryCellSets[initPath!.section].albumSets[(initPath?.row)!]
 
 
 allDataSets.categoryCellSets[(indexPath?.section)!].albumSets.insert(allDataSets.categoryCellSets[initPath!.section].albumSets[(initPath?.row)!], atIndex: (indexPath?.row)!)
 
 allDataSets.categoryCellSets[initPath!.section].albumSets.removeAtIndex(initPath!.row)
 
 tableView.moveRowAtIndexPath(initPath!, toIndexPath: indexPath!)
 initPath = indexPath
 
 //case UIGestureRecognizerState.Changed:
 
 default:
 break
 }
 
 }*/


