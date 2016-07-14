//
//  detailViewController.swift
//  photoTag
//
//  Created by Liyuan Liu on 7/13/16.
//  Copyright © 2016 Jerry. All rights reserved.
//

import UIKit

class detailViewController: UIViewController {

    
    @IBOutlet weak var detailImageView: UIImageView!
    
    var detailImage: UIImage?
    override func viewDidLoad() {
        super.viewDidLoad()

        detailImageView.image = detailImage
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


}
