//
//  categoryTableViewCell.swift
//  photoTag
//
//  Created by Liyuan Liu on 7/4/16.
//  Copyright © 2016 Jerry. All rights reserved.
//

import UIKit

class categoryTableViewCell: UITableViewCell {
    
    @IBOutlet weak var leftImage: UIImageView!
    
    @IBOutlet weak var categoryTitle: UILabel!
    
    @IBOutlet weak var rightImage: UIImageView!
    
    
    

    override func awakeFromNib() {
        super.awakeFromNib()
        categoryTitle.adjustsFontSizeToFitWidth = true
        categoryTitle.minimumScaleFactor = 0.5
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
