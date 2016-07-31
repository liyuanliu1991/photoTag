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

 
    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return allDataSets.categoryCellSets.count
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return allDataSets.categoryCellSets[section].albumSets.count + 2
        
    }
    
    @IBAction func addCategory(sender: AnyObject) {
        
        self.tableView.beginUpdates()
        let albums = [albumCellModel]()
        let newCategory = categoryCellModel(leftImageName: "section.png", categoryTitle: "Long press to change title", rightImageName: "rightArrow.png", albumset: albums)
        self.allDataSets.categoryCellSets.append(newCategory)
        let indexSet = NSIndexSet(index: self.allDataSets.categoryCellSets.count - 1)
        self.tableView.insertSections(indexSet, withRowAnimation: .Automatic)
        self.tableView.endUpdates()

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
                cell.addNewAlbumLabel.text = "Click to delete the category"
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
            let ratingTapRecognizer = UITapGestureRecognizer(target: self, action: #selector(albumTableViewController.ratingClick(_:)))
            
            cell.ratingImage.userInteractionEnabled = true
            cell.ratingImage.addGestureRecognizer(ratingTapRecognizer)
            
            
            cell.albumTitle.userInteractionEnabled = true
            let albumTitleTapRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(albumTableViewController.editAlbumTitle(_:)))
            cell.albumTitle.addGestureRecognizer(albumTitleTapRecognizer)
            
            cell.albumSubtitle.userInteractionEnabled = true
            let albumSubtitleTapRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(albumTableViewController.editAlbumSubtitle(_:)))
            cell.albumSubtitle.addGestureRecognizer(albumSubtitleTapRecognizer)
            
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
                                    if newName == ""
                                    {
                                        newName = "Subtitle cannot be null"
                                    }
                                    
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
                    if newName == ""
                    {
                        newName = "Title cannot be null"
                    }
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
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(albumTableViewController.expandCellTap(_:)))
        cell.rightImage.tag = section
        cell.rightImage.addGestureRecognizer(tapRecognizer)
        
        cell.leftImage.userInteractionEnabled = true
        let tapRecognizerLeft = UITapGestureRecognizer(target: self, action: #selector(albumTableViewController.expandCellTapLeftImage(_:)))
        cell.leftImage.tag = section
        cell.leftImage.addGestureRecognizer(tapRecognizerLeft)


        cell.categoryTitle.userInteractionEnabled = true
        let tapRecognizerLeftTitle = UITapGestureRecognizer(target: self, action: #selector(albumTableViewController.expandCellTapTitle(_:)))
        cell.categoryTitle.tag = section
        cell.categoryTitle.addGestureRecognizer(tapRecognizerLeftTitle)
        
        
     /*   cell.leftImage.userInteractionEnabled = true
        let deleteTapRecognizer = UITapGestureRecognizer(target: self, action: Selector("deleteSectionTap:"))
        cell.leftImage.addGestureRecognizer((deleteTapRecognizer))*/
        
        
        cell.categoryTitle.userInteractionEnabled = true
        let editCategoryTitle = UILongPressGestureRecognizer(target: self, action: #selector(albumTableViewController.editCategoryTitle(_:)))
        cell.categoryTitle.addGestureRecognizer(editCategoryTitle)
        
       
        return cell.contentView
    }
    func editCategoryTitle(gesture:UILongPressGestureRecognizer)
    {
        
        let target = gesture.view! as! UILabel
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
                    if newName == ""
                    {
                        newName = "Title cannot be null"
                    }
                    target.text = newName
                    
                    target.reloadInputViews()
               
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
   
    
    func expandCellTapTitle(gesture: UITapGestureRecognizer)
    {
        tableView.beginUpdates()
        
        let target = gesture.view! as? UILabel
        
        //let tapLocation = gesture.locationInView(self.tableView)
        
        // let indexPath = self.tableView.indexPathForRowAtPoint(tapLocation)
        var whichSectionTapped:Int?
        
        whichSectionTapped = target?.tag
        
        
        
        if expandCell.contains(whichSectionTapped!)
        {
            expandCell.removeObject(whichSectionTapped!)
          //  allDataSets.categoryCellSets[whichSectionTapped!].rightImage = UIImage(named: "rightArrow.png")
            
            
        }
        else
        {
            expandCell.append(whichSectionTapped!)
          //  allDataSets.categoryCellSets[whichSectionTapped!].rightImage = UIImage(named: "dropDown.png")
            
            
        }
        tableView.endUpdates()
    }
    
    
    func expandCellTap(gesture: UITapGestureRecognizer)
    {
        tableView.beginUpdates()
        
        let target = gesture.view!
        
        //let tapLocation = gesture.locationInView(self.tableView)
        
        // let indexPath = self.tableView.indexPathForRowAtPoint(tapLocation)
        var whichSectionTapped:Int?
        
        whichSectionTapped = target.tag
        
        
        
        if expandCell.contains(whichSectionTapped!)
        {
            expandCell.removeObject(whichSectionTapped!)
           // let tapView = gesture.view! as? UIImageView
           // tapView?.image = UIImage(named: "rightArrow.png")
            
            
        }
        else
        {
            expandCell.append(whichSectionTapped!)
          //  let tapView = gesture.view! as? UIImageView
           // tapView?.image = UIImage(named: "dropDown.png")
            
            
        }
        tableView.endUpdates()
    }

    
    func expandCellTapLeftImage(gesture: UITapGestureRecognizer)
    {
        tableView.beginUpdates()
        
        let target = gesture.view! 
        
        //let tapLocation = gesture.locationInView(self.tableView)
        
       // let indexPath = self.tableView.indexPathForRowAtPoint(tapLocation)
        var whichSectionTapped:Int?
     
        whichSectionTapped = target.tag
        
        
        
        if expandCell.contains(whichSectionTapped!)
        {
            expandCell.removeObject(whichSectionTapped!)
          //  allDataSets.categoryCellSets[whichSectionTapped!].rightImage = UIImage(named: "rightArrow.png")
            
            
        }
        else
        {
            expandCell.append(whichSectionTapped!)
           // allDataSets.categoryCellSets[whichSectionTapped!].rightImage = UIImage(named: "dropDown.png")
            
            
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





























