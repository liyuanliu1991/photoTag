//
//  albumCell.swift
//  photoTag
//
//  Created by Liyuan Liu on 7/4/16.
//  Copyright © 2016 Jerry. All rights reserved.
//

import Foundation
import UIKit
class albumCellModel: NSObject {
    var albumCoverImage: UIImage?
    var albumTitle: String?
    var albumSubtitle: String?
    var ratingImage: UIImage?
    var ratingImageNameString:String?
    var albumCoverImageData: NSData?
    var photoSet = [imageCellModel]()
    init(albumCoverImageName: String?, alubumTitle:String?, albumSubtitle: String?,ratingImageName: String?, albumCoverImageData: NSData?, photos: [imageCellModel]?)
    {
        if let albumCoverImageName = albumCoverImageName{
            self.albumCoverImage = UIImage(named: albumCoverImageName)
        }
        else if let albumCoverImageData = albumCoverImageData{
            self.albumCoverImage = UIImage(data: albumCoverImageData)
        }
        else
        {
            self.albumCoverImage = UIImage(named: "defaulNewAlbumCoverImage.png")
        }
        
        self.albumTitle = albumTitle ?? "Click to change title"
        self.albumSubtitle = albumSubtitle ?? "date"
        if let ratingImageName = ratingImageName{
            self.ratingImage = UIImage(named: ratingImageName)
            self.ratingImageNameString = ratingImageName
        }
        else
        {
            self.ratingImage = UIImage(named: "star_male.png")
        }
        if let photos = photos
        {
            self.photoSet = photos
        }
        
        
    }
}