//
//  CreatureImages.swift
//  FantasticBeasts
//
//  Created by Jay Maloney on 2/21/16.
//  Copyright © 2016 Jay Maloney. All rights reserved.
//

import Foundation

class CreatureImage {
    
    static let imageJSON = CreatureController.sharedInstance.creatureImageJSON
    
//    private var _cImageCaption:String
    private var _cImageURL:String
    
//    var cImageCaption:String {return _cImageCaption}
    var cImageURL:String {return _cImageURL}
    
    init(cImageCaption:String, cImageURL:String) {
//        self._cImageCaption = cImageCaption
        self._cImageURL = cImageURL
    }
    
    init?(imageJSON:jsonDictionary) {
//        if let cImageCaption = imageJSON["caption"] as? String {
//            self._cImageCaption = cImageCaption
//        } else {
//            self._cImageCaption = "No Image Caption Found."
//        }
        
        if let cImageURL = imageJSON["src"] as? String {
            self._cImageURL = cImageURL
        } else {
            self._cImageURL = "No Image URL Found."
        }
    }
}
