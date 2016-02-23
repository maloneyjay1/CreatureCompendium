//
//  Creature.swift
//  FantasticBeasts
//
//  Created by Jay Maloney on 2/20/16.
//  Copyright © 2016 Jay Maloney. All rights reserved.
//

import Foundation

class CreatureName {
    
    //Initializes directly from network call completion (resultData).
    //Can also initialize from supplied parameters for user creation of made-up creature.
    
    private var _cName:String
    
    var cName:String {return _cName}
    
    init(cName:String, cTitleText:String) {
        self._cName = cName
    }
    
    init?(resultData:jsonDictionary) {
        if let sectionsArray = resultData["sections"] as? jsonArray,
            nameDict = sectionsArray[0] as? jsonDictionary,
            cName = nameDict["title"] as? String {
                self._cName = cName
        } else {
            self._cName = "No Name Found."
        }
    }
}

