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
    
    func constructLoreJSONArray(resultData:jsonDictionary, completion:(LoreArray:jsonArray, success:Bool) -> Void) {
        if let sectionsArray = resultData["sections"] as? jsonArray {
            for n in sectionsArray {
                if let title = n["title"] as? String {
                    creatureLoreJSON = ["title":"\(title):"]
                    if let contentArray = n["content"] as? jsonArray {
                        for n in contentArray {
                            if let text = n["text"] as? String {
                                if !text.isEmpty {
                                    let cText = self.stringFormatter(text)
                                    creatureLoreJSON.updateValue("\(title): \(cText)", forKey: "title")
                                    creatureLoreJSONCollection.append(creatureLoreJSON)
                                } else {
                                    print("No Lore in this JSON.")
                                    completion(LoreArray: [[:]], success: false)
                                }
                            } else {
                                print("No text found in this JSON.")
                                completion(LoreArray: [[:]], success: false)
                            }
                        }
                    } else {
                        print("No content found in this JSON.")
                        completion(LoreArray: [[:]], success: false)
                    }
                } else {
                    print("No title found in this JSON.")
                    completion(LoreArray: [[:]], success: false)
                }
            }
        } else {
            print("No section found in this JSON.")
            completion(LoreArray: [[:]], success: false)
        }
        
        completion(LoreArray: creatureLoreJSONCollection, success: true)
    }
    
    func constructImageJSONArray(resultData:jsonDictionary, completion:(ImageJson:jsonDictionary, ImageArray:jsonArray) -> Void) {
        if let sectionsArray = resultData["sections"] as? jsonArray {
            for n in sectionsArray {
                if let imageArray = n["images"] as? jsonArray {
                    for n in imageArray {
                        print("\(imageArray.count)")
                        if let url = n["src"] as? String {
                            if !url.isEmpty {
                                //change back to caption key
                                creatureImageJSON = ["src":"\(url):"]
                                let cURL = self.stringFormatter(url)
                                creatureImageJSON.updateValue("\(cURL)", forKey: "src")
                                creatureImageJSONCollection.append(creatureImageJSON)
                                completion(ImageJson: creatureImageJSON, ImageArray: creatureImageJSONCollection)
                            }
                        }
                    }
                }
            }
        }
    }
}

extension CreatureController {
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
