//
//  guessViewController.swift
//  photoTag
//
//  Created by Liyuan Liu on 7/19/16.
//  Copyright © 2016 Jerry. All rights reserved.
//

import UIKit

class guessViewController: UIViewController {

    @IBOutlet weak var answerQuestion: UIButton!
    
    @IBOutlet weak var temptsLeft: UILabel!
    
    @IBOutlet weak var eggsLeft: UILabel!
    
    @IBOutlet weak var hintsButton: UIButton!
    
    @IBOutlet weak var slider: UISlider!
    
    @IBOutlet weak var guessImage: UIImageView!
    
    @IBOutlet weak var shadow: GradientView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let recvButton = UIBarButtonItem(title: "Receive Secrets", style: .Plain, target: self, action: "recvPhoto:")
        navigationItem.rightBarButtonItem = recvButton

        self.shadow.hidden = true
        slider.hidden = true
        
        // Do any additional setup after loading the view.
    }

    func recvPhoto(sender: UIBarButtonItem)
    {
        
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
