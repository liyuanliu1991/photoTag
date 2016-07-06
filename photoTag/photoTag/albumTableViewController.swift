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
        return allDataSets.categoryCellSets.count
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        
            return allDataSets.categoryCellSets[section].albumSets.count + 1


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
                return 150
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
        
        whichSectionTapped = section
        
        cell.rightImage.addGestureRecognizer(tapRecognizer)
       
        
        return cell
    }
    
    func expandCellTap(gesture: UITapGestureRecognizer)
    {
        tableView.beginUpdates()
        
        if expandCell.contains(whichSectionTapped)
        {
            expandCell.removeObject(whichSectionTapped)
        }
        else
        {
            expandCell.append(whichSectionTapped)
        }
        tableView.endUpdates()
    }
    
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
  /*  override func tableView(tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let cell = tableView.dequeueReusableCellWithIdentifier("addNewAlbum") as! addNewAlbumTableViewCell
        cell.leftImage.image = allDataSets.addNewAlbumCellSets[section].leftImage
        cell.addNewAlbumLabel.text = allDataSets.addNewAlbumCellSets[section].addNewAlbumLabel!
        
        return cell.contentView
        
    }
    override func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        
        if expandCell.contains(section)
        {
            return 50
        }
        else
        {
            return 0
        }
    }*/
    
  }

//还是把footer做成一个真正的cell吧































