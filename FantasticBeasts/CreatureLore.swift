//
//  CreatureLore.swift
//  FantasticBeasts
//
//  Created by Jay Maloney on 2/21/16.
//  Copyright © 2016 Jay Maloney. All rights reserved.
//

import Foundation

class CreatureLore {
    //Initializes from creatureLoreJSON, via CreatureController.
    //creatureLoreJSON is a dictionary within creatureLoreJSONCollection.
    //Can also initialize from supplied parameters for user creation of made-up creature.
    static let loreJSON = CreatureController.sharedInstance.creatureLoreJSON
    
    private var _cLoreSectionTitle:String
//    private var _cLoreSectionText:String
    
    var cLoreSectionTitle:String {return _cLoreSectionTitle}
//    var cLoreSectionText:String {return _cLoreSectionText}
    
    init(cLoreSectionTitle:String, cLoreSectionText:String) {
        self._cLoreSectionTitle = cLoreSectionTitle
//        self._cLoreSectionText = cLoreSectionText
    }
    
    init?(loreJSON:jsonDictionary) {
        if let cLoreSectionTitle = loreJSON["title"] as? String {
            self._cLoreSectionTitle = cLoreSectionTitle
        } else {
            self._cLoreSectionTitle = "No Title Found."
        }
        
//        if let cLoreSectionText = loreJSON["text"] as? String {
//            self._cLoreSectionText = cLoreSectionText
//        } else {
//            self._cLoreSectionText = "No Text Found."
//        }
    }
}