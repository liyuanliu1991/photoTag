//
//  albumTableViewCell.swift
//  photoTag
//
//  Created by Liyuan Liu on 7/4/16.
//  Copyright © 2016 Jerry. All rights reserved.
//

import UIKit

class albumTableViewCell: UITableViewCell {
    
    @IBOutlet weak var albumCoverImage: UIImageView!
    
    @IBOutlet weak var albumTitle: UILabel!
    
    @IBOutlet weak var albumSubtitle: UILabel!
    
    @IBOutlet weak var ratingImage: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
