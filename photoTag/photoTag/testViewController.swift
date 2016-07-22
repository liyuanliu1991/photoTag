//
//  testViewController.swift
//  photoTag
//
//  Created by Liyuan Liu on 7/22/16.
//  Copyright © 2016 Jerry. All rights reserved.
//

import UIKit

class testViewController: UIViewController {

    @IBOutlet weak var testImageView: UIImageView!
    var image:UIImage?
    override func viewDidLoad() {
        super.viewDidLoad()

        testImageView.image = image
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
