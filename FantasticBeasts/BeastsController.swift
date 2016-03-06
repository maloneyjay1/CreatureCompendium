//
//  BeastsController.swift
//  FantasticBeasts
//
//  Created by Jay Maloney on 2/29/16.
//  Copyright © 2016 Jay Maloney. All rights reserved.
//

import Foundation
import UIKit

class BeastsController {
    
    static let sharedInstance = BeastsController()
    
    var creatureIndex = Int()
    
    var beastLore:String = ""
    var beastName:String = ""
    var beastImage = UIImage()
    
    func clearData() {
        self.beastName = ""
        self.beastLore = ""
    }
    
    func retrieveAllLoreAndName(searchTerm:String, completion:(success:Bool) -> Void) {
        dispatch_async(dispatch_get_main_queue()) {
            CreatureController.allCreatureLoreForNameAsString(searchTerm) { (creatureString, name) -> Void in
                self.beastLore = ""
                print(self.beastLore)
                self.beastName = ""
                print(self.beastName)
                self.beastImage = UIImage()
                
                self.beastLore = creatureString
                print(self.beastLore)
                self.beastName = searchTerm
                print(self.beastName)
                completion(success: true)
            }
        }
    }
    
    func retrieveImage(searchTerm:String, index:Int, completion:(success:Bool) -> Void) {
        //create image object
        CreatureController.creatureImageURLForNameAndIndex(searchTerm, index: index) { (creatureImageObject) -> Void in
            ImageController.sharedInstance.getUIImageFromURL(creatureImageObject, completion: { (image, imageType, success) -> Void in
                if success {
                    self.beastImage = image
                    completion(success: true)
                } else {
                    print("No Image.")
                    completion(success: false)
                }
            })
        }
        
    }
}
