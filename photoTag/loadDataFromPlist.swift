//
//  loadDataFromPlist.swift
//  photoTag
//
//  Created by Liyuan Liu on 7/4/16.
//  Copyright © 2016 Jerry. All rights reserved.
//

import Foundation
import UIKit
class loadDataFromPlist:NSObject{
  
    var categoryCellSets = [categoryCellModel]()
    var addNewAlbumCellSets = [addNewAblumCellModel]()
    
    init(addNewAlbumCellImageName:String?)
    {
        super.init()
     
        self.loadCategoryCellSets()
        self.loadAddNewAlbumCellSets(addNewAlbumCellImageName)
        
    }
    
    func loadCategoryCellSets()
    {
        var albumSets = [albumCellModel]()
        let first = albumCellModel(albumCoverImageName: "defaulNewAlbumCoverImage.png", alubumTitle: "default new album name", albumSubtitle: "default new album subtitle", ratingImageName: "star_male.png", albumCoverImageData: nil)
        albumSets.append(first)
        let test = categoryCellModel(leftImageName: "section.png", categoryTitle: "default category title", rightImageName: "rightArrow.png", albumset: albumSets)
        
        categoryCellSets.append(test)
    }
    func loadAddNewAlbumCellSets(addNewAlbumCellImageName:String?)
    {
        var test:addNewAblumCellModel
        if let addNewAlbumCellImageName = addNewAlbumCellImageName
        {
            test = addNewAblumCellModel(leftImageName: addNewAlbumCellImageName, addNewAlbumLabel: "add new album label")
        }
        else
        {
            test = addNewAblumCellModel(leftImageName: "plusSign.png", addNewAlbumLabel: "add new album label")
        }
        addNewAlbumCellSets.append(test)
        
    }
    
    
}