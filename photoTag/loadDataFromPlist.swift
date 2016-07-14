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
        
        var photoSets = [imageCellModel]()
        let firstPhoto = imageCellModel(imageName: "o.jpg", checkIconName: "unchecked.png")
        let secondPhoto = imageCellModel(imageName: "b.jpg", checkIconName: "unchecked.png")
        let thridPhoto = imageCellModel(imageName: "c.jpg", checkIconName: "unchecked.png")
        let fourthPhoto = imageCellModel(imageName: "d.jpg", checkIconName: "unchecked.png")
        let fifthPhoto = imageCellModel(imageName: "e.jpg", checkIconName: "unchecked.png")
        let sixPhoto = imageCellModel(imageName: "f.jpg", checkIconName: "unchecked.png")
        let seventhPhoto = imageCellModel(imageName: "g.jpg", checkIconName: "unchecked.png")
        let eighthPhoto = imageCellModel(imageName: "h.jpg", checkIconName: "unchecked.png")
        let ninethPhoto = imageCellModel(imageName: "i.jpg", checkIconName: "unchecked.png")
        let tenthPhoto = imageCellModel(imageName: "k.jpg", checkIconName: "unchecked.png")
        
        
        photoSets.append(firstPhoto)
        photoSets.append(secondPhoto)
        photoSets.append(thridPhoto)
        photoSets.append(fourthPhoto)
        photoSets.append(fifthPhoto)
        photoSets.append(sixPhoto)
        photoSets.append(seventhPhoto)
        photoSets.append(eighthPhoto)
        photoSets.append(ninethPhoto)
        photoSets.append(tenthPhoto)
        

        
        let firstAlbum = albumCellModel(albumCoverImageName: "defaulNewAlbumCoverImage.png", alubumTitle: "default new album name", albumSubtitle: "default new album subtitle", ratingImageName: "star_male.png", albumCoverImageData: nil,photos: photoSets)
        albumSets.append(firstAlbum)
        let test = categoryCellModel(leftImageName: "delete.png", categoryTitle: "default category title", rightImageName: "rightArrow.png", albumset: albumSets)
        
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








