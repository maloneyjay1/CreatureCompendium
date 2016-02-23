
//
//  ViewController.swift
//  FantasticBeasts
//
//  Created by Jay Maloney on 2/20/16.
//  Copyright © 2016 Jay Maloney. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var label: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        var creatureString:String = ""
        CreatureController.retrieveCreatureNetworkJSON("Giant") { (resultsData) -> Void in
            CreatureController.sharedInstance.constructLoreJSONArray(resultsData, completion: { (LoreArray, success) -> Void in
                for n in LoreArray {
                    if let text = n["title"] as? String {
                        if !text.isEmpty {
                            let appendedString = CreatureController.sharedInstance.stringFormatter("\(text)\n\n")
                            creatureString += appendedString
                        }
                    }
                }
                self.textView.text = creatureString
            })
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}