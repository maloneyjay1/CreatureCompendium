//
//  CreatureLore.swift
//  FantasticBeasts
//
//  Created by Jay Maloney on 2/21/16.
//  Copyright © 2016 Jay Maloney. All rights reserved.
//

import Foundation

class CreatureLore {
    
    static let loreJSON = CreatureController.sharedInstance.creatureLoreJSON
    
    private var _cLoreSectionTitle:String
    
    var cLoreSectionTitle:String {return _cLoreSectionTitle}
    
    init(cLoreSectionTitle:String, cLoreSectionText:String) {
        self._cLoreSectionTitle = cLoreSectionTitle
    }
    
    init?(loreJSON:jsonDictionary) {
 
        if let cLoreSectionTitle = loreJSON["title"] as? String {
            self._cLoreSectionTitle = cLoreSectionTitle
        } else {
            self._cLoreSectionTitle = "No Title Found."
        }
    }
}