//
//  WaterfallLayout.swift
//  Papers
//
//  Created by Tim Mitra on 2/16/16.
//  Copyright © 2016 Razeware LLC. All rights reserved.
//

import UIKit

protocol WaterfallLayoutDelegate {
    
    
    func collectionView(collectionView: UICollectionView, heightForItemAtIndexPath indexPath:NSIndexPath) -> CGFloat
}

class WaterfallLayout: UICollectionViewLayout {
    
    var delegate = WaterfallLayoutDelegate!()
    var numberOfColums = 1
    private var cache = [UICollectionViewLayoutAttributes]()
    private var contentHeight: CGFloat = 0
    
    private var width: CGFloat {
        get {
            return CGRectGetWidth(collectionView!.bounds)
        }
    }
    
    override func collectionViewContentSize() -> CGSize {
        
      
        return CGSize(width: width, height: contentHeight)
    }
    
    override func prepareLayout() {
        
        cache.removeAll()
        
            
            let columnWidth = width / CGFloat(numberOfColums)
            
            var xOffsets = [CGFloat]()
            for column in 0..<numberOfColums {
                xOffsets.append(CGFloat(column) * columnWidth)
            }
            
            var yOffsets = [CGFloat](count: numberOfColums, repeatedValue: 0)
            
            var column = 0
     
        
            for item in 0..<collectionView!.numberOfItemsInSection(0) {
                
                let indexPath = NSIndexPath(forItem: item, inSection: 0)
                let height = delegate.collectionView(collectionView!, heightForItemAtIndexPath: indexPath)
                
                let frame = CGRect(x: xOffsets[column], y: yOffsets[column], width: columnWidth, height: height)
                
                let attributes = UICollectionViewLayoutAttributes(forCellWithIndexPath: indexPath)
                attributes.frame = frame
                cache.append(attributes)
            
                contentHeight = max(contentHeight, CGRectGetMaxY(frame))
            
                
                
                yOffsets[column] = yOffsets[column] + height
                
                if column >= (numberOfColums - 1) {
                    column = 0
                } else {
                    column = 1
                }
            }
       
    }
    
    override func layoutAttributesForElementsInRect(rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        
        var layoutAttributes = [UICollectionViewLayoutAttributes]()
        
        for attributes in cache {
            if CGRectIntersectsRect(attributes.frame, rect) {
                layoutAttributes.append(attributes)
            }
        }
        
        return layoutAttributes
        
    }
    
    
}
