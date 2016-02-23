//
//  Constants.swift
//  FantasticBeasts
//
//  Created by Jay Maloney on 2/20/16.
//  Copyright © 2016 Jay Maloney. All rights reserved.
//

import Foundation

typealias jsonDictionary = [String:AnyObject]
typealias jsonArray = [AnyObject]

class Constants {
    
    func beastNames() -> [String] {
        return ["Acromantula", "Billywig", "Centaur", "Demiguise", "Erkling", "Fairy", "Ghoul", "Glumbumble", "Hebridean Black", "Imp", "Jarvey", "Kappa", "Leprechaun", "Mackled Malaclaw", "Niffler", "Occamy", "Peruvian Salamander", "Quintaped", "Ramora", "Salamander", "Tadfoal", "Unicorn", "Vampyr Mosp", "Werewolf", "Yeti"]
    }
    
    func beingNames() -> [String] {
        return ["Being", "Dwarf", "Giant", "Goblin", "Hag", "Vampire", "Werewolf"]
    }
    
    func ghostsAndNonBeingNames() -> [String] {
        return ["Deathday Party", "Cuthbert Binns", "Edgar Cloggs", "Patrick Delaney-Podmore", "Fat Friar", "Ghost", "Headless Hunt", "Nicholas de Mimsy-Porpington's five-hundredth Deathday Party", "Phantom Rat", "Helena Ravenclaw", "The Toad", "Unidentified ghost horse (I)", "Wailing Widow", "Boggart", "Dementor", "Poltergeist"]
    }
    
}
