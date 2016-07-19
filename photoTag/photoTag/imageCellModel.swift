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
    
    var hiddenImage: UIImage?
    
    var showHidenImage: Bool
    
    var imageData:NSData?
    init(imageName: String?, checkIconName:String?,data:NSData?)
    {
        if let imageName = imageName{
            self.image = UIImage(named: imageName)
        }
        else if let data = data{
            self.imageData = data
            self.image = UIImage(data: data)
        }
        if let checkIconName = checkIconName{
            self.checkIcon = UIImage(named: checkIconName)
        }
        showHidenImage = false
        
        hiddenImage = UIImage(named: "1.png")
        
    }
    
}