//
//  enumCommon.swift
//  photoTag
//
//  Created by Liyuan Liu on 7/5/16.
//  Copyright © 2016 Jerry. All rights reserved.
//

import Foundation
import UIKit

enum flagType : Int{
    case expanded
    case closed
    
}

extension RangeReplaceableCollectionType where Generator.Element : Equatable {
    
    // Remove first collection element that is equal to the given `object`:
    mutating func removeObject(object : Generator.Element) {
        if let index = self.indexOf(object) {
            self.removeAtIndex(index)
        }
    }
}