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
    var expandCell = flagType.needCloseCell
    var adjustNumOfCells = 0
    
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

        return allDataSets.categoryCellSets.count + adjustNumOfCells

    }
    //configure each cell
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 50
    }
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("catgeory", forIndexPath: indexPath) as! categoryTableViewCell
        cell.leftImage.image = allDataSets.categoryCellSets[0].leftImage
        cell.categoryTitle.text = allDataSets.categoryCellSets[0].categoryTitle
        cell.rightImage.image = allDataSets.categoryCellSets[0].rightImage
        return cell
    }
    

  }
