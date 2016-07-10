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
    var whichSectionTapped = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        let m = allDataSets.categoryCellSets.count
        return m
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        let  k = allDataSets.categoryCellSets[section].albumSets.count + 1
        
        return k
        
        
    }
    
    @IBAction func addCategory(sender: AnyObject) {
        
        var newName: String?
        let alert = UIAlertController(title: "New Category",
            message: "Input Name",
            preferredStyle: UIAlertControllerStyle.Alert)
        
        let ok = UIAlertAction(title: "OK",
            style: UIAlertActionStyle.Default) { (action: UIAlertAction) in
                
                
                if let alertTextField = alert.textFields?.first where alertTextField.text != nil {
                    newName = alertTextField.text
                    self.tableView.beginUpdates()
                    
                    let albums = [albumCellModel]()
                    let newCategory = categoryCellModel(leftImageName: "section.png", categoryTitle: newName, rightImageName: "rightArrow.png", albumset: albums)
                    self.allDataSets.categoryCellSets.append(newCategory)
                    let indexSet = NSIndexSet(index: self.allDataSets.categoryCellSets.count - 1)
                    self.tableView.insertSections(indexSet, withRowAnimation: .Automatic)
                    self.tableView.endUpdates()
                    self.tableView.reloadData()
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
            let cell = tableView.dequeueReusableCellWithIdentifier("addNewAlbum") as! addNewAlbumTableViewCell
            cell.leftImage.image = allDataSets.addNewAlbumCellSets[0].leftImage
            cell.addNewAlbumLabel.text = allDataSets.addNewAlbumCellSets[0].addNewAlbumLabel!
            
            return cell
        }
        else
        {
            let cell = tableView.dequeueReusableCellWithIdentifier("album", forIndexPath: indexPath) as! albumTableViewCell
            let album = allDataSets.categoryCellSets[indexPath.section].albumSets[indexPath.row]
            cell.albumCoverImage.image = album.albumCoverImage
            cell.albumSubtitle.text = album.albumSubtitle
            cell.albumTitle.text = album.albumTitle
            cell.ratingImage.image = album.ratingImage
            
            return cell
            
        }
        
        
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
        
        //return cell
        return cell.contentView
    }
    
    func expandCellTap(gesture: UITapGestureRecognizer)
    {
        tableView.beginUpdates()
        
        let tapLocation = gesture.locationInView(self.tableView)
        
        let indexPath = self.tableView.indexPathForRowAtPoint(tapLocation)
        if indexPath == nil
        {
            whichSectionTapped = 0
        }
        else
        {
            whichSectionTapped = (indexPath?.section)!
        }
        
        
        if expandCell.contains(whichSectionTapped)
        {
            expandCell.removeObject(whichSectionTapped)
            let tapView = gesture.view! as? UIImageView
            tapView?.image = UIImage(named: "rightArrow.png")
            
            
        }
        else
        {
            expandCell.append(whichSectionTapped)
            let tapView = gesture.view! as? UIImageView
            tapView?.image = UIImage(named: "dropDown.png")
            
        }
        tableView.endUpdates()
    }
    
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    
}





























