
//
//  ViewController.swift
//  FantasticBeasts
//
//  Created by Jay Maloney on 2/20/16.
//  Copyright © 2016 Jay Maloney. All rights reserved.
//

import UIKit
import Foundation

class ViewController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var lore: UITextView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        CreatureController.creatureImageObjectForNameAndIndex("Werewolf", index: 2) { (creatureImageObject) -> Void in
            
            ImageController.sharedInstance.getUIImageFromURL(creatureImageObject, completion: { (image, imageType) -> Void in
                CreatureController.singleCreatureLoreObjectStringForIndexAndName("Werewolf", index: 0, completion: { (cLoreSectionTitle, cLoreSectionText, cCreatureName, searchTerm) -> Void in
                    self.titleLabel.text = "\(cLoreSectionTitle)"
                    self.lore.text = "\(cLoreSectionText)"
                    self.name.text = searchTerm
                    self.imageView.image = image
                })
            })
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}