//
//  CreatureController.swift
//  FantasticBeasts
//
//  Created by Jay Maloney on 2/21/16.
//  Copyright © 2016 Jay Maloney. All rights reserved.
//

import Foundation

class CreatureController {
    
    static let sharedInstance = CreatureController()
    
    //Custom JSON dictionary and collection of dictionaries
    //creatureLoreJSON = [title:text]
    var creatureLoreString = ""
    var creatureLoreJSON = [String:AnyObject]()
    var creatureLoreJSONCollection = [[String:AnyObject]]()
    
    //Custom JSON dictionary and collection of dictionaries
    //CreatureImageJSON = [caption:src]
    var creatureImageString = ""
    var creatureImageJSON = [String:AnyObject]()
    var creatureImageJSONCollection = [[String:AnyObject]]()
    
    
    //successful test
    static func singleCreatureLoreObjectStringForIndexAndName(searchTerm:String, index:Int, completion:(cLoreSectionTitle:String, cLoreSectionText:String, cCreatureName:String, searchTerm:String) -> Void) {
        CreatureController.retrieveCreatureNetworkJSON(searchTerm) { (resultsData) -> Void in
            CreatureController.sharedInstance.constructLoreJSONArray(resultsData, completion: { (LoreArray, success, name) -> Void in
                if let json = LoreArray[index] as? jsonDictionary {
                    if let newCreature = CreatureLore(loreJSON: json) {
                        let titleString = newCreature.cLoreSectionTitle
                        let textString = newCreature.cLoreSectionText
                        if let creatureName = CreatureName(resultData: json) {
                            completion(cLoreSectionTitle: titleString, cLoreSectionText: textString, cCreatureName: creatureName.cName, searchTerm: searchTerm)
                        }
                    }
                }
            })
        }
    }
    
    
    
    static func allCreatureLoreForNameAsString(searchTerm:String, completion:(creatureString:String, name:String) -> Void) {
        var creatureString:String = ""
        CreatureController.retrieveCreatureNetworkJSON(searchTerm) { (resultsData) -> Void in
            CreatureController.sharedInstance.constructLoreJSONArray(resultsData, completion: { (LoreArray, success, name) -> Void in
                for n in LoreArray {
                    if let text = n["title"] as? String {
                        if !text.isEmpty {
                            let appendedString = CreatureController.sharedInstance.stringFormatter("\(text)\n\n")
                            creatureString += appendedString
                        }
                    }
                }
                completion(creatureString: creatureString, name: name)
            })
        }
    }
    
    
    //completes with array of lore objects
    static func creatureLoreObjectArrayForName(searchTerm:String, completion:(creatureLoreArray:[CreatureLore], name:String) -> Void) {
        var creatureLoreArray:[CreatureLore] = []
        CreatureController.retrieveCreatureNetworkJSON(searchTerm) { (resultsData) -> Void in
            CreatureController.sharedInstance.constructLoreJSONArray(resultsData, completion: { (LoreArray, success, name) -> Void in
                for n in LoreArray {
                    if let json = n as? jsonDictionary {
                        if let newCreature = CreatureLore(loreJSON: json) {
                            creatureLoreArray.append(newCreature)
                            if let creatureName = CreatureName(resultData: json) {
                                completion(creatureLoreArray: creatureLoreArray, name: creatureName.cName)
                            }
                        }
                    }
                }
            })
        }
    }
    
    
    static func creatureImageObjectForNameAndIndex(searchTerm:String, index:Int, completion:(creatureImageObject:String) -> Void) {
        CreatureController.retrieveCreatureNetworkJSON(searchTerm) { (resultsData) -> Void in
            CreatureController.sharedInstance.constructImageJSONArray(resultsData, completion: { (ImageJson, ImageArray) -> Void in
                if index < ImageArray.count {
                    if let json = ImageArray[index] as? jsonDictionary {
                        if let newImage = CreatureImage(imageJSON: json) {
                            let newImageURL = newImage.cImageURL
                            print(newImageURL)
                            let imageURL = CreatureController.sharedInstance.urlFormatterForSecurity(newImageURL)
                            print(imageURL)
                            completion(creatureImageObject: imageURL)
                        } else {
                            print("No Image")
                            completion(creatureImageObject: "No creature image URL found.")
                        }
                    } else {
                        print("No JSON")
                        completion(creatureImageObject: "No creature image URL found.")
                    }
                } else {
                    print("Index Out of Range.")
                    completion(creatureImageObject: "http://atom.smasher.org/error/xp.png.php?icon=skull3&title=ERROR&url=&text=Bummer+dude%2C+looks+like+there%27s+no+image+here.&b1=&b2=&b3=")
                }
            })
        }
    }
    
    
    //completes with array of image objects
    static func creatureImageObjectArrayForName(searchTerm:String, completion:(creatureImageArray:[String]) -> Void) {
        var creatureImageArray:[String] = []
        CreatureController.retrieveCreatureNetworkJSON(searchTerm) { (resultsData) -> Void in
            CreatureController.sharedInstance.constructImageJSONArray(resultsData, completion: { (ImageJson, ImageArray) -> Void in
                for n in ImageArray {
                    if let json = n as? jsonDictionary {
                        if let newImage = CreatureImage(imageJSON: json) {
                            let imageURL = newImage.cImageURL
                            let formattedURL = CreatureController.sharedInstance.urlFormatterForSecurity(imageURL)
                            creatureImageArray.append(formattedURL)
                        }
                    }
                }
                completion(creatureImageArray: [])
            })
        }
    }
    
    
    static func retrieveCreatureNetworkJSON(creature:String, completion:(resultsData:jsonDictionary) -> Void) {
        let baseURL = NetworkController.baseCreatureURLForSearch(creature)
        NetworkController.dataAtURL(baseURL) { (resultData, json, success) -> Void in
            if let itemsArray = json["items"] as? [[String:AnyObject]] {
                for idDictionary in itemsArray {
                    if let creatureIDFound = idDictionary["id"] {
                        let creatureURL = NetworkController.creatureURLForID("\(creatureIDFound)")
                        NetworkController.dataAtURL(creatureURL, completion: { (resultData, json, success) -> Void in
                            completion(resultsData: json)
                        })
                    }
                }
            }
        }
    }
    
    
    //UPDATE TO REMOVE TITLE?
    func constructLoreJSONArray(resultData:jsonDictionary, completion:(LoreArray:jsonArray, success:Bool, name:String) -> Void) {
        var nameTitle = String()
        if let sectionsArray = resultData["sections"] as? jsonArray {
            for n in sectionsArray {
                if let title = n["title"] as? String {
                    creatureLoreJSON = ["title":"\(title):"]
                    if let contentArray = n["content"] as? jsonArray {
                        for n in contentArray {
                            if let text = n["text"] as? String {
                                if !text.isEmpty {
                                    let cText = self.stringFormatter(text)
                                    nameTitle = "\(title)"
                                    print(nameTitle)
                                    creatureLoreJSON.updateValue("\(cText)", forKey: "text")
                                    creatureLoreJSON.updateValue("\(title)", forKey: "title")
                                    creatureLoreJSONCollection.append(creatureLoreJSON)
                                } else {
                                    print("No Lore in this JSON.")
                                    completion(LoreArray: [[:]], success: false, name: "\(title)")
                                }
                            }
                        }
                    } else {
                        print("No content found in this JSON.")
                        completion(LoreArray: [[:]], success: false, name: "")
                    }
                } else {
                    print("No title found in this JSON.")
                    completion(LoreArray: [[:]], success: false, name:"")
                }
            }
        } else {
            print("No section found in this JSON.")
            completion(LoreArray: [[:]], success: false,name:"")
        }
        
        completion(LoreArray: creatureLoreJSONCollection, success: true, name: "\(nameTitle)")
    }
    
    func constructImageJSONArray(resultData:jsonDictionary, completion:(ImageJson:jsonDictionary, ImageArray:jsonArray) -> Void) {
        
        if let sectionsArray = resultData["sections"] as? jsonArray {
            for n in sectionsArray {
                    if let imageArray = n["images"] as? jsonArray {
                        for n in imageArray {
                            print("\(imageArray.count)")
                            if let url = n["src"] as? String {
                                if !url.isEmpty {
                                    creatureImageJSON = ["src":"\(url):"]
                                    let cURL = self.stringFormatter(url)
                            
                                 
                                    creatureImageJSON.updateValue("\(cURL)", forKey: "src")
                                    creatureImageJSONCollection.append(creatureImageJSON)
                                    
                                }
                            }
                        }
                    }
            }
        }
        completion(ImageJson: creatureImageJSON, ImageArray: creatureImageJSONCollection)
    }
    
}

extension CreatureController {
    
    func urlFormatterForSecurity(string:String) -> String {
        let secureString:String = string.stringByReplacingOccurrencesOfString("http", withString: "https")
        return secureString
    }
    
    func stringFormatter(string:String) -> String {
        let newString:String = ("\(string) ")
        return newString
    }
    
    func stringFormatterWithPeriod(string:String) -> String {
        return ("\(string), ")
    }
    
    //LOCAL PERSISTENCE/LOAD METHODS, NOT CURRENTLY SUPPORTED BY CLASS INITS
    func saveLoreToNSUserDefaults (names:[[String:AnyObject]], completion:(success:Bool) -> Void) {
        NSUserDefaults.standardUserDefaults().setObject(names, forKey: "loreCollection")
    }
    
    func saveImageURLsToNSUserDefaults (names:[[String:AnyObject]], completion:(success:Bool) -> Void) {
        NSUserDefaults.standardUserDefaults().setObject(names, forKey: "imageURLs")
    }
    
    func eraseNSUserDefaults (completion:(success:Bool) -> Void) {
        NSUserDefaults.standardUserDefaults().removeObjectForKey("loreCollection")
        NSUserDefaults.standardUserDefaults().removeObjectForKey("imageURLs")
    }
    
    func loadLoreFromNSUserdefaults (creatureLore:[[String:AnyObject]], completion:(success:Bool) -> Void) {
        if let loreCollection = NSUserDefaults.standardUserDefaults().objectForKey("loreCollection") as? [[String:AnyObject]] {
            self.creatureLoreJSONCollection = loreCollection
        }
    }
    
    func loadImageURLsFromNSUserDefaults (imageURLs:[[String:AnyObject]], completion:(success:Bool) -> Void) {
        if let imageURLs = NSUserDefaults.standardUserDefaults().objectForKey("imageURLs") as? [[String:AnyObject]] {
            self.creatureImageJSONCollection = imageURLs
        }
    }
}
