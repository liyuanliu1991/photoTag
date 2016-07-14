//
//  albumAddNewAlbumCellModel.swift
//  photoTag
//
//  Created by Liyuan Liu on 7/4/16.
//  Copyright © 2016 Jerry. All rights reserved.
//

import Foundation
import UIKit
class addNewAblumCellModel: NSObject {
    
    var leftImage: UIImage?
    var addNewAlbumLabel: String?
    init(leftImageName:String?, addNewAlbumLabel: String?)
    {
        if let leftImageName = leftImageName{
            self.leftImage = UIImage(named: leftImageName)
        }
        else{
            self.leftImage = UIImage(named: "plusSign.png")
        }
        self.addNewAlbumLabel = addNewAlbumLabel ?? "Add New Album"
    }
    
}