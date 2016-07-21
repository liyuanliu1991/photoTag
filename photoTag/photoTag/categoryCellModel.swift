//
//  categoryCellModel.swift
//  photoTag
//
//  Created by Liyuan Liu on 7/4/16.
//  Copyright © 2016 Jerry. All rights reserved.
//

import Foundation
import UIKit

class categoryCellModel: NSObject {
    var leftImage: UIImage?
    var categoryTitle:String?
    var rightImage: UIImage?
    var albumSets = [albumCellModel]()
    var expand: flagType
    var identtfier:Int?
    init(leftImageName:String?,categoryTitle:String?,rightImageName:String?, albumset : [albumCellModel])
    {
        self.expand = .closed
        if let leftImageName = leftImageName{
            self.leftImage = UIImage(named: leftImageName)
        }
        if let categoryTitle = categoryTitle{
            self.categoryTitle = categoryTitle
        }
        if let rightImageName = rightImageName{
            self.rightImage = UIImage(named: rightImageName)
        }
        if albumset.count != 0
        {
            albumSets = albumset
        }
        
    }
    
}