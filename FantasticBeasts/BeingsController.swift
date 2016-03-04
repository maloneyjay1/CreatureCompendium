//
//  BeingsController.swift
//  FantasticBeasts
//
//  Created by Jay Maloney on 2/29/16.
//  Copyright © 2016 Jay Maloney. All rights reserved.
//

import Foundation
import UIKit

class BeingController {
    
    static let sharedInstance = BeingController()
    
    var creatureIndex = Int()
    
    var beingLore:String = ""
    var beingName:String = ""
    var beingImage = UIImage()
    
    func clearData() {
        self.beingName = ""
        self.beingLore = ""
    }
    
    func retrieveAllLoreAndName(searchTerm:String, completion:(success:Bool) -> Void) {
        dispatch_async(dispatch_get_main_queue()) {
            CreatureController.allCreatureLoreForNameAsString(searchTerm) { (creatureString, name) -> Void in
                self.beingLore = ""
                print(self.beingLore)
                self.beingName = ""
                print(self.beingName)
                self.beingImage = UIImage()
                
                self.beingLore = creatureString
                print(self.beingLore)
                self.beingName = searchTerm
                print(self.beingName)
                completion(success: true)
            }
        }
    }
    
    func retrieveImage(searchTerm:String, index:Int, completion:(success:Bool) -> Void) {
        //create image object
        CreatureController.creatureImageObjectForNameAndIndex(searchTerm, index: index) { (creatureImageObject) -> Void in
            ImageController.sharedInstance.getUIImageFromURL(creatureImageObject, completion: { (image, imageType) -> Void in
                self.beingImage = image
                completion(success: true)
            })
        }
    }
}
