//
//  GhostsAndOtherController.swift
//  FantasticBeasts
//
//  Created by Jay Maloney on 2/29/16.
//  Copyright © 2016 Jay Maloney. All rights reserved.
//

import Foundation
import UIKit

class GhostsAndOtherController {
    
    static let sharedInstance = GhostsAndOtherController()
    
    var creatureIndex = Int()
    
    var ghostLore:String = ""
    var ghostName:String = ""
    var ghostImage = UIImage()
    
    func clearData() {
        self.ghostName = ""
        self.ghostLore = ""
    }
    
    func retrieveAllLoreAndName(searchTerm:String, completion:(success:Bool) -> Void) {
        dispatch_async(dispatch_get_main_queue()) {
            CreatureController.allCreatureLoreForNameAsString(searchTerm) { (creatureString, name) -> Void in
                self.ghostLore = ""
                print(self.ghostLore)
                self.ghostName = ""
                print(self.ghostName)
                self.ghostImage = UIImage()
                
                self.ghostLore = creatureString
                print(self.ghostLore)
                self.ghostName = searchTerm
                print(self.ghostName)
                completion(success: true)
            }
        }
    }
    
    func retrieveImage(searchTerm:String, index:Int, completion:(success:Bool) -> Void) {
        //create image object
        CreatureController.creatureImageURLForNameAndIndex(searchTerm, index: index) { (creatureImageObject) -> Void in
            ImageController.sharedInstance.getUIImageFromURL(creatureImageObject, completion: { (image, imageType, success) -> Void in
                if success {
                    self.ghostImage = image
                    completion(success: true)
                } else {
                    print("No Image.")
                    completion(success: false)
                }
            })
        }
    }
}

