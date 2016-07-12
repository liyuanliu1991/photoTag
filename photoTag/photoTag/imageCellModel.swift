//
//  imageCellModel.swift
//  photoTag
//
//  Created by Liyuan Liu on 7/11/16.
//  Copyright © 2016 Jerry. All rights reserved.
//

import Foundation
import UIKit
class imageCellModel{
    var image:UIImage?
    var checkIcon:UIImage?
    
    init(imageName: String?, checkIconName:String?)
    {
        if let imageName = imageName{
            self.image = UIImage(named: imageName)
        }
        if let checkIconName = checkIconName{
            self.checkIcon = UIImage(named: checkIconName)
        }
    }
    
}