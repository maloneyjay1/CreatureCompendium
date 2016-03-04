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
    
    static let sharedInstance = Constants()
    
    func beastNames() -> [String] {
        return ["Abraxan", "Acromantula", "Aethonan", "Antipodean Opaleye", "Ashwinder", "Billywig", "Blibbering Humdinger", "Bowtruckle", "Centaur", "Chameleon Ghoul", "Chinese Fireball", "Common Welsh Green", "Crumple-Horned Snorkack", "Demiguise", "Diricawl", "Doxy", "Dragon", "Erkling", "Fairy", "Firecrab", "Flesh-Eating Slug", "Flobberworm", "Ghoul", "Giant Squid", "Glumbumble", "Golden Snidget", "Granian", "Griffin", "Grindylow", "Hebridean Black", "Heliopath", "Hippogriff", "Hungarian Horntail", "Imp", "Jarvey", "Jobberknoll", "Kappa", "Kneazle", "Leprechaun", "Lethifold", "Mackled Malaclaw", "Merpeople", "Moke", "Nargle", "Niffler", "Norwegian Ridgeback", "Nundu", "Occamy", "Owl", "Peruvian Salamander", "Peruvian Vipertooth", "Pixie", "Phoenix", "Pogrebin", "Puffskein", "Pygmy Puff", "Quintaped", "Ramora", "Romanian Longhorn", "Salamander", "Sphinx", "Swedish Short-Snout", "Streeler", "Tadfoal", "Thestral", "Three-Headed Dog", "Troll", "Ukrainian Ironbelly", "Unicorn", "Vampyr Mosp", "Werewolf", "Wood Nymph", "Winged Horse", "Wrackspurt", "Yeti"]
    }
    
    func beastRatingForIndex(currentIndex:Int) -> String {
        print("\(currentIndex)")
        return beastRatings()[currentIndex]
    }
    
    func beastRatings() -> [String] {
        return ["XXXX", "XXXXX - known wizard killer", "XX - XXXX",  "XXXXX", "XXX", "XX", "XXXX", "XX chameleon ghoul", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", ""  ]
    }
    
    func beastImageIndex(beast:String) -> Int {
        switch (beast) {
        case let x where x == "Abraxan":
            return 0
        default:
            return 0
        }
    }
    
    func beingNames() -> [String] {
        return ["Being", "Dwarf", "Giant", "Goblin", "Hag", "Vampire", "Veela", "Werewolf"]
    }
    
    func beingImageIndex(being:String) -> Int {
        switch (being) {
        case let x where x == "Being":
            return 0
        default:
            return 0
        }
    }
    
    func ghostsNonBeingAndUnknownNames() -> [String] {
        return ["Banshee", "Bicorn", "Boggart", "Cockatrice", "Cuthbert Binns", "Deathday Party", "Dementor", "Edgar Cloggs", "Fat Friar", "Ghost", "Headless Hunt", "Nicholas de Mimsy-Porpington's five-hundredth Deathday Party", "Ogre", "Patrick Delaney-Podmore", "Phantom Rat", "Poltergeist", "Helena Ravenclaw", "The Toad", "Unidentified ghost horse (I)", "Wailing Widow"]
    }
    
    func ghostImageIndex(ghost:String) -> Int {
        switch (ghost) {
        case let x where x == "Banshee":
            return 0
        default:
            return 0
        }
    }
    
    func ministryOfMagicGreeting() -> String {
        return "Welcome to the official\nMuggle Technology Integration Application for the Department for the Regulation and Control of\n Magical Creatures.\n▼\n\n"
    }
    
    func ministryOfMagicWarning() -> String {
        return "Use of this application by non Ministry of Magic personnel will result in the immediate removal from any and all Ministry duties and position(s), as well as be made subject to a lasting Obliviate charm.\n\n Please report any and all unauthorized usage and direct your relevant inquiries to the Muggle Technology Integration Support Service within your respective creature division.\n\n Beasts: Demeter VanHoorn\n Beings: Helena Pilliwickle\n Spirits and Non-Beings: Donaghan Pomfrey\n▼\n"
    }
    
    func ministryOfMagicInstructions() -> String {
        return "In accordance with Clause 73 of the International Code of Wizarding Secrecy, which states: 'Each wizarding governing body will be responsible for the concealment, care, and control of all magical beasts, beings, and spirits dwelling within its territory's borders.\n\nShould any such creature cause harm to, or draw the notice of, the Muggle community, that nation's wizarding governing body will be subject to discipline by the International Confederation of Wizards.'\n\nYour duties include but are not limited to the following;\n investigate complaints regarding any and all magical creatures within jurisdiction, direct relevant action to division task force when necessary.  Employees attached to endangered-status sub-divisions will also be expected to carry out relevant breeding documentation and regulatory affairs therein.\n▼\n"
    }
    
    func ministryOfMagicNewEmployeeNote() -> String {
        return "If you are a new employee, please register your wand with Merwyn Kettleburn between the hours of 9:15 and 9:55, Tuesday or Friday at the Department for the Regulation and Control of Magical Creatures Personnel Liason Office, 2nd level, unit 4A."
    }
    
    func ministryOfMagicUpdate() -> String {
        return "Whilst on duty this week please be watchful for an escaped juvenile Acromantula. Report all sightings at once to Bertie Frenzen, Beast Division, 5th level, unit 9F."
    }
    
    
}
