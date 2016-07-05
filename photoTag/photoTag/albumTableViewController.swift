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
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        var adjustNumOfCells = 0
        var i = 0
        for index in expandCell{
            adjustNumOfCells += allDataSets.categoryCellSets[index].albumSets.count
            i += 1
        }
        adjustNumOfCells += i
        return allDataSets.categoryCellSets.count + adjustNumOfCells

    }
    //configure each cell
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if(expandCell.count == 0)
        {
            return 50
        }
        else
        {
            if(indexPath.row == 0 )
            {
                return 50
            }
            var adjust = 0
            var i = 1
            for index in expandCell{
                adjust += allDataSets.categoryCellSets[index].albumSets.count
                if(indexPath.row != adjust + i && indexPath.row != adjust + i - 1)
                {
                    return 150
                }
                else if(indexPath.row == adjust + i - 1)
                {
                    return 50
                }
                i += 1
            }
            
        }
        return 50
        
    }
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if(expandCell.count == 0)
        {
            let cell = tableView.dequeueReusableCellWithIdentifier("catgeory", forIndexPath: indexPath) as! categoryTableViewCell
            cell.leftImage.image = allDataSets.categoryCellSets[indexPath.row].leftImage
            cell.categoryTitle.text = allDataSets.categoryCellSets[indexPath.row].categoryTitle
            cell.rightImage.image = allDataSets.categoryCellSets[indexPath.row].rightImage
            return cell
        }
        else
        {
            if(indexPath.row == 0 )
            {
                let cell = tableView.dequeueReusableCellWithIdentifier("catgeory", forIndexPath: indexPath) as! categoryTableViewCell
                cell.leftImage.image = allDataSets.categoryCellSets[indexPath.row].leftImage
                cell.categoryTitle.text = allDataSets.categoryCellSets[indexPath.row].categoryTitle
                cell.rightImage.image = allDataSets.categoryCellSets[indexPath.row].rightImage
                return cell
            }
            var adjust = 0
            var i = 1
            for index in expandCell{
                adjust += allDataSets.categoryCellSets[index].albumSets.count
                if(indexPath.row != adjust + i && indexPath.row != adjust + i - 1)
                {
                    let cell = tableView.dequeueReusableCellWithIdentifier("album", forIndexPath: indexPath) as! albumTableViewCell
                    let album = allDataSets.categoryCellSets[index].albumSets[indexPath.row - index - 1]
                    cell.albumCoverImage.image = album.albumCoverImage
                    cell.albumSubtitle.text = album.albumSubtitle
                    cell.albumTitle.text = album.albumTitle
                    cell.ratingImage.image = album.ratingImage
                    return cell
                }
                else if(indexPath.row == adjust + i - 1)
                {
                    let cell = tableView.dequeueReusableCellWithIdentifier("addNewAlbum", forIndexPath: indexPath) as! addNewAlbumTableViewCell
                    cell.leftImage.image = allDataSets.addNewAlbumCellSets[0].leftImage
                    cell.addNewAlbumLabel.text = allDataSets.addNewAlbumCellSets[0].addNewAlbumLabel!
                    return cell
                }
                i += 1
            }
            
        }
        let cell = tableView.dequeueReusableCellWithIdentifier("catgeory", forIndexPath: indexPath) as! categoryTableViewCell
        cell.leftImage.image = allDataSets.categoryCellSets[indexPath.row].leftImage
        cell.categoryTitle.text = allDataSets.categoryCellSets[indexPath.row].categoryTitle
        cell.rightImage.image = allDataSets.categoryCellSets[indexPath.row].rightImage
        return cell
        
    }
    

  }
