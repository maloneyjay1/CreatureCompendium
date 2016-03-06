
//
//  ViewController.swift
//  FantasticBeasts
//
//  Created by Jay Maloney on 2/20/16.
//  Copyright © 2016 Jay Maloney. All rights reserved.
//

import UIKit
import Foundation

class Intro: UIViewController {

    @IBOutlet weak var TextView: UITextView!
    
    var imageCount = Int()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        ImageController.sharedInstance.returnImageArrayForCreature("Centaur") { (images) -> Void in
            self.imageCount = images.count
        }
        
        
        
        generalAlert(title: "Attention to Employees", message: "\(Constants.sharedInstance.ministryOfMagicUpdate())", actionTitle: "OK")
        
        TextView.text = "\(Constants.sharedInstance.ministryOfMagicGreeting())\(Constants.sharedInstance.ministryOfMagicWarning())\n\n\(Constants.sharedInstance.ministryOfMagicInstructions())\n\n\(Constants.sharedInstance.ministryOfMagicNewEmployeeNote())"
        
        TextView.contentOffset = CGPointMake(0, -TextView.contentSize.height)
        
    }
    

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}