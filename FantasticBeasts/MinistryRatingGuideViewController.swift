//
//  MinistryRatingGuideViewController.swift
//  FantasticBeasts
//
//  Created by Jay Maloney on 3/1/16.
//  Copyright © 2016 Jay Maloney. All rights reserved.
//

import UIKit

class MinistryRatingGuideViewController: UIViewController {
    
    @IBOutlet weak var ratingText: UILabel!
    
    let text:String = "X - Boring\n XX - Harmless / may be domesticated\n XXX - Competent wizard should cope\n XXXX - Dangerous / requires specialist knowledge / skilled wizard may handle\n XXXXX - Known wizard killer / impossible to train or domesticate"

    override func viewDidLoad() {
        super.viewDidLoad()
        
        ratingText.text = text


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
