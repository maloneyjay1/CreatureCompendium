//
//  BeastsController.swift
//  FantasticBeasts
//
//  Created by Jay Maloney on 2/29/16.
//  Copyright © 2016 Jay Maloney. All rights reserved.
//

import Foundation

class BeastsController {
    
    static let sharedInstance = BeastsController()
    
    var beastLore:String = ""
    var beastName:String = ""
    
    func retrieveAllLoreAndName(searchTerm:String, completion:(success:Bool) -> Void) {
        CreatureController.allCreatureLoreForNameAsString(searchTerm) { (creatureString, name) -> Void in
            self.beastLore = creatureString
            print(self.beastLore)
            self.beastName = name
            print(self.beastName)
            completion(success: true)
        }
    }
    
    func retrieveImage(searchTerm:String, index:Int, completion:(success:Bool) -> Void) {
        
    }
}

