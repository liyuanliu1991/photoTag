//
//  albumTableViewController.swift
//  photoTag
//
//  Created by Liyuan Liu on 7/4/16.
//  Copyright © 2016 Jerry. All rights reserved.
//

import UIKit

class albumTableViewController: UITableViewController {
    
    
    var allDataSets = loadDataFromPlist(addNewAlbumCellImageName: nil)
    var expandCell = [Int]()
    var initPath: NSIndexPath?
    //var whichSectionTapped = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
            }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        switch segue.identifier{
        case .Some("photoSegue"):
            let photoController = segue.destinationViewController as! imageCollectionViewController
            if let indexPath = tableView.indexPathForSelectedRow{
                let mid = allDataSets.categoryCellSets[indexPath.section]
                photoController.photos = mid.albumSets[indexPath.row]
            }
        default:
            break
            
        }
    }

    func longPressGestureRecognized(gesture:UILongPressGestureRecognizer)
    {
        let longPress = gesture as UILongPressGestureRecognizer
        let state = longPress.state
        let locationInView = longPress.locationInView(tableView)
        var indexPath = tableView.indexPathForRowAtPoint(locationInView)
        
        switch state{
        case UIGestureRecognizerState.Began:
            if indexPath != nil{
                initPath = indexPath
            }
            else
            {
                initPath = NSIndexPath(forRow: (indexPath?.row)!, inSection: 0)
            }
        case UIGestureRecognizerState.Changed:
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
            
            
            
            let third = allDataSets.categoryCellSets[initPath!.section].albumSets[(initPath?.row)!]
            
            
            allDataSets.categoryCellSets[(indexPath?.section)!].albumSets.insert(allDataSets.categoryCellSets[initPath!.section].albumSets[(initPath?.row)!], atIndex: (indexPath?.row)!)
            
            allDataSets.categoryCellSets[initPath!.section].albumSets.removeAtIndex(initPath!.row)
            
            tableView.moveRowAtIndexPath(initPath!, toIndexPath: indexPath!)
            initPath = indexPath
            
            default:
            break
        }
        
    }
   

    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        let m = allDataSets.categoryCellSets.count
        return m
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        let  k = allDataSets.categoryCellSets[section].albumSets.count + 2
        
        return k
        
        
    }
    
    @IBAction func addCategory(sender: AnyObject) {
        
        self.tableView.beginUpdates()
        let albums = [albumCellModel]()
        let newCategory = categoryCellModel(leftImageName: "section.png", categoryTitle: "Click to change title", rightImageName: "rightArrow.png", albumset: albums)
        self.allDataSets.categoryCellSets.append(newCategory)
        let indexSet = NSIndexSet(index: self.allDataSets.categoryCellSets.count - 1)
        self.tableView.insertSections(indexSet, withRowAnimation: .Automatic)
        self.tableView.endUpdates()
        //self.tableView.reloadData()

        
    }
    

    //configure each cell
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if(expandCell.count == 0)
        {
            return 0
        }
        else
        {
            if expandCell.contains(indexPath.section)
            {
                if indexPath.row >= allDataSets.categoryCellSets[indexPath.section].albumSets.count
                {
                    return 50
                }
                else
                {
                    return 150
                }
                
            }
            else
            {
                return 0
            }
        }
        
    }
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        if indexPath.row >= allDataSets.categoryCellSets[indexPath.section].albumSets.count
        {
            if indexPath.row == allDataSets.categoryCellSets[indexPath.section].albumSets.count
            {
                let cell = tableView.dequeueReusableCellWithIdentifier("addNewAlbum") as! addNewAlbumTableViewCell
                cell.leftImage.image = allDataSets.addNewAlbumCellSets[0].leftImage
                cell.addNewAlbumLabel.text = allDataSets.addNewAlbumCellSets[0].addNewAlbumLabel!
                return cell
                
            }
            else
            {
                let cell = tableView.dequeueReusableCellWithIdentifier("addNewAlbum") as! addNewAlbumTableViewCell
                cell.leftImage.image = allDataSets.addNewAlbumCellSets[0].leftImage
                cell.addNewAlbumLabel.text = "Click me to delete whole section"
                return cell
            }
 
           
        }
        else
        {
            let cell = tableView.dequeueReusableCellWithIdentifier("album", forIndexPath: indexPath) as! albumTableViewCell
            let album = allDataSets.categoryCellSets[indexPath.section].albumSets[indexPath.row]
            cell.albumCoverImage.image = album.albumCoverImage
            cell.albumSubtitle.text = album.albumSubtitle
            cell.albumTitle.text = album.albumTitle
            cell.ratingImage.image = album.ratingImage
            let ratingTapRecognizer = UITapGestureRecognizer(target: self, action: Selector("ratingClick:"))
            
            cell.ratingImage.userInteractionEnabled = true
            cell.ratingImage.addGestureRecognizer(ratingTapRecognizer)
            
            
            cell.albumTitle.userInteractionEnabled = true
            let albumTitleTapRecognizer = UILongPressGestureRecognizer(target: self, action: Selector("editAlbumTitle:"))
            cell.albumTitle.addGestureRecognizer(albumTitleTapRecognizer)
            
            cell.albumSubtitle.userInteractionEnabled = true
            let albumSubtitleTapRecognizer = UILongPressGestureRecognizer(target: self, action: Selector("editAlbumSubtitle:"))
            cell.albumSubtitle.addGestureRecognizer(albumSubtitleTapRecognizer)
            
           /* let longpress = UILongPressGestureRecognizer(target: self, action: "longPressGestureRecognized:")
            cell.addGestureRecognizer(longpress)*/

            
            return cell
            
        }
        
        
    }
    func editAlbumSubtitle(gesture:UILongPressGestureRecognizer)
    {
        let tapLocation = gesture.locationInView(self.tableView)
        
        let indexPath = self.tableView.indexPathForRowAtPoint(tapLocation)
        var whichSectionTapped:Int?
        if indexPath == nil
        {
            whichSectionTapped = 0
        }
        else
        {
            whichSectionTapped = (indexPath?.section)!
        }
        
        var newName: String?
        let alert = UIAlertController(title: "Album Subtitle",
            message: "Input Name",
            preferredStyle: UIAlertControllerStyle.Alert)
        
        let ok = UIAlertAction(title: "OK",
            style: UIAlertActionStyle.Default) { (action: UIAlertAction) in
                
                if let alertTextField = alert.textFields?.first where alertTextField.text != nil {
                    newName = alertTextField.text
                    
                    self.allDataSets.categoryCellSets[whichSectionTapped!].albumSets[(indexPath?.row)!].albumSubtitle = newName
                    
                    let NSindexPath = NSIndexPath(forRow: (indexPath?.row)!, inSection: whichSectionTapped!)
                    
                    self.tableView.reloadRowsAtIndexPaths([NSindexPath], withRowAnimation: .None)
                }
                
        }
        
        let cancel = UIAlertAction(title: "Cancel",
            style: UIAlertActionStyle.Cancel,
            handler: nil)
        
        alert.addTextFieldWithConfigurationHandler { (textField: UITextField) in
            
            textField.placeholder = "Name here"
            
        }
        
        alert.addAction(ok)
        alert.addAction(cancel)
        
        self.presentViewController(alert, animated: true, completion: nil)
    }
    func editAlbumTitle(gesture:UILongPressGestureRecognizer)
    {
        let tapLocation = gesture.locationInView(self.tableView)
        
        let indexPath = self.tableView.indexPathForRowAtPoint(tapLocation)
        var whichSectionTapped:Int?
        if indexPath == nil
        {
            whichSectionTapped = 0
        }
        else
        {
            whichSectionTapped = (indexPath?.section)!
        }
        
        var newName: String?
        let alert = UIAlertController(title: "Album",
            message: "Input Name",
            preferredStyle: UIAlertControllerStyle.Alert)
        
        let ok = UIAlertAction(title: "OK",
            style: UIAlertActionStyle.Default) { (action: UIAlertAction) in
                
                if let alertTextField = alert.textFields?.first where alertTextField.text != nil {
                    newName = alertTextField.text
                    
                    self.allDataSets.categoryCellSets[whichSectionTapped!].albumSets[(indexPath?.row)!].albumTitle = newName
                    
                    let NSindexPath = NSIndexPath(forRow: (indexPath?.row)!, inSection: whichSectionTapped!)
                    
                    self.tableView.reloadRowsAtIndexPaths([NSindexPath], withRowAnimation: .None)
                }
                
        }
        
        let cancel = UIAlertAction(title: "Cancel",
            style: UIAlertActionStyle.Cancel,
            handler: nil)
        
        alert.addTextFieldWithConfigurationHandler { (textField: UITextField) in
            
            textField.placeholder = "Name here"
            
        }
        
        alert.addAction(ok)
        alert.addAction(cancel)
        
        self.presentViewController(alert, animated: true, completion: nil)
    }
    func ratingClick(gesture:UITapGestureRecognizer)
    {
       // tableView.beginUpdates()
        let tapLocation = gesture.locationInView(self.tableView)
        
        let indexPath = self.tableView.indexPathForRowAtPoint(tapLocation)
        var whichSectionTapped: Int?
        if indexPath == nil
        {
            whichSectionTapped = 0
        }
        else
        {
            whichSectionTapped = (indexPath?.section)!
        }

        if(allDataSets.categoryCellSets[whichSectionTapped!].albumSets[(indexPath?.row)!].ratingImageNameString == "star_male.png")
        {
            allDataSets.categoryCellSets[whichSectionTapped!].albumSets[(indexPath?.row)!].ratingImage = UIImage(named: "star_female.png")
            allDataSets.categoryCellSets[whichSectionTapped!].albumSets[(indexPath?.row)!].ratingImageNameString = "star_female.png"
        }
        else
        {
            allDataSets.categoryCellSets[whichSectionTapped!].albumSets[(indexPath?.row)!].ratingImage = UIImage(named: "star_male.png")
            allDataSets.categoryCellSets[whichSectionTapped!].albumSets[(indexPath?.row)!].ratingImageNameString = "star_male.png"
        }
        
       
        let NSindexPath = NSIndexPath(forRow: (indexPath?.row)!, inSection: whichSectionTapped!)
        tableView.reloadRowsAtIndexPaths([NSindexPath], withRowAnimation: .None)
    
    }
    
    
    //for section header and footer
    override func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let cell = tableView.dequeueReusableCellWithIdentifier("catgeory") as! categoryTableViewCell
        cell.leftImage.image = allDataSets.categoryCellSets[section].leftImage
        cell.categoryTitle.text = allDataSets.categoryCellSets[section].categoryTitle
        cell.rightImage.image = allDataSets.categoryCellSets[section].rightImage
        
        cell.rightImage.userInteractionEnabled = true
        let tapRecognizer = UITapGestureRecognizer(target: self, action: Selector("expandCellTap:"))
        
        
        cell.rightImage.addGestureRecognizer(tapRecognizer)
        
     /*   cell.leftImage.userInteractionEnabled = true
        let deleteTapRecognizer = UITapGestureRecognizer(target: self, action: Selector("deleteSectionTap:"))
        cell.leftImage.addGestureRecognizer((deleteTapRecognizer))*/
        
        
        cell.categoryTitle.userInteractionEnabled = true
        let editCategoryTitle = UILongPressGestureRecognizer(target: self, action: Selector("editCategoryTitle:"))
        cell.categoryTitle.addGestureRecognizer(editCategoryTitle)
        
        return cell.contentView
    }
    func editCategoryTitle(gesture:UILongPressGestureRecognizer)
    {
        
        let target = gesture.view as! UILabel
        /*let tapLocation = gesture.locationInView(self.tableView)
        
        let indexPath = self.tableView.indexPathForRowAtPoint(tapLocation)
        var whichSectionTapped:Int?
        if indexPath == nil
        {
            whichSectionTapped = 0
        }
        else
        {
            whichSectionTapped = (indexPath?.section)!
        }*/
       
        var newName: String?
        let alert = UIAlertController(title: "Category",
            message: "Input Name",
            preferredStyle: UIAlertControllerStyle.Alert)
        
        let ok = UIAlertAction(title: "OK",
            style: UIAlertActionStyle.Default) { (action: UIAlertAction) in
                
                if let alertTextField = alert.textFields?.first where alertTextField.text != nil {
                    newName = alertTextField.text
                    
                    target.text = newName
                    
                    target.reloadInputViews()
                /*    self.allDataSets.categoryCellSets[whichSectionTapped!].categoryTitle = newName
                
                    let indexSet = NSIndexSet(index: whichSectionTapped!)
                    
                    self.tableView.reloadSections(indexSet, withRowAnimation: .Automatic)*/
                }
                
        }
        
        let cancel = UIAlertAction(title: "Cancel",
            style: UIAlertActionStyle.Cancel,
            handler: nil)
        
        alert.addTextFieldWithConfigurationHandler { (textField: UITextField) in
            
            textField.placeholder = "Name here"
            
        }
        
        alert.addAction(ok)
        alert.addAction(cancel)
        
        self.presentViewController(alert, animated: true, completion: nil)

    }
    
/*    func deleteSectionTap(gesture:UITapGestureRecognizer)
    {
        tableView.beginUpdates()
        let tapLocation = gesture.locationInView(self.tableView)
        
        let indexPath = self.tableView.indexPathForRowAtPoint(tapLocation)
        var whichSectionTapped:Int?
        if indexPath == nil
        {
            whichSectionTapped = 0
        }
        else
        {
            whichSectionTapped = (indexPath?.section)!
        }
        if expandCell.contains(whichSectionTapped!)
        {
            expandCell.removeObject(whichSectionTapped!)
            let tapView = gesture.view! as? UIImageView
            tapView?.image = UIImage(named: "rightArrow.png")
            
            
        }
        allDataSets.categoryCellSets.removeAtIndex(whichSectionTapped!)
        let section = NSIndexSet(index: whichSectionTapped!)
        tableView.deleteSections(section, withRowAnimation: .Automatic)
        tableView.endUpdates()
        
    }*/
    
    func expandCellTap(gesture: UITapGestureRecognizer)
    {
        tableView.beginUpdates()
        
        
        
        let tapLocation = gesture.locationInView(self.tableView)
        
        let indexPath = self.tableView.indexPathForRowAtPoint(tapLocation)
        var whichSectionTapped:Int?
        if indexPath == nil
        {
            whichSectionTapped = 0
        }
        else
        {
            whichSectionTapped = (indexPath?.section)!
        }
        
        
        if expandCell.contains(whichSectionTapped!)
        {
            expandCell.removeObject(whichSectionTapped!)
            let tapView = gesture.view! as? UIImageView
            tapView?.image = UIImage(named: "rightArrow.png")
            
            
        }
        else
        {
            expandCell.append(whichSectionTapped!)
            let tapView = gesture.view! as? UIImageView
            tapView?.image = UIImage(named: "dropDown.png")
            
            
        }
        tableView.endUpdates()
    }
    
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        if(indexPath.row == allDataSets.categoryCellSets[indexPath.section].albumSets.count)
        {
            self.tableView(tableView, commitEditingStyle: .Insert, forRowAtIndexPath: indexPath)
        }
        else if indexPath.row > allDataSets.categoryCellSets[indexPath.section].albumSets.count
        {
            tableView.beginUpdates()
            
            if expandCell.contains(indexPath.section)
            {
                expandCell.removeObject(indexPath.section)
   
            }
            allDataSets.categoryCellSets.removeAtIndex(indexPath.section)
            let section = NSIndexSet(index: indexPath.section)
            tableView.deleteSections(section, withRowAnimation: .Automatic)
            
            tableView.endUpdates()
        }
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        
        if(editingStyle == .Delete)
        {
            allDataSets.categoryCellSets[indexPath.section].albumSets.removeAtIndex(indexPath.row)
            let index = NSIndexPath(forRow: indexPath.row, inSection: indexPath.section)
            
            tableView.deleteRowsAtIndexPaths([index], withRowAnimation: .Automatic)
        }
        else if(editingStyle == .Insert)
        {
            let newAlbum = albumCellModel(albumCoverImageName: "defaulNewAlbumCoverImage.png", alubumTitle: "Long press to change title", albumSubtitle: "Long press to change subtitle", ratingImageName: "star_male.png", albumCoverImageData: nil,photos: nil)
            allDataSets.categoryCellSets[indexPath.section].albumSets.append(newAlbum)
            tableView.insertRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
        }
        
        
        
    }
    
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        if(indexPath.row >= allDataSets.categoryCellSets[indexPath.section].albumSets.count)
        {
            return false
        }
        else
        {
            return true
        }
    }
 
    
}





























