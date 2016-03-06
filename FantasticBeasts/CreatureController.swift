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
    
    var imageJSON = jsonDictionary()
    var imageArray = jsonArray()
    
    //Custom JSON dictionary and collection of dictionaries
    //CreatureImageJSON = [caption:src]
    var creatureImageString = ""
    var creatureImageJSON = [String:AnyObject]()
    var creatureImageJSONCollection = [[String:AnyObject]]()
    
    var LoreArray = jsonArray()
    
    var currentCreatureNetworkData = jsonDictionary()
    
    var currentCreatureImageUrlArray = [String]()
    
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
        dispatch_async(dispatch_get_main_queue()) {
            var creatureString:String = ""
            var creatureName:String = ""
            CreatureController.retrieveCreatureNetworkJSON(searchTerm) { (resultsData) -> Void in
                CreatureController.sharedInstance.constructLoreJSONArray(resultsData, completion: { (LoreArray, success, name) -> Void in
                    var currentTitle:String = ""
                    print(creatureString)
                    for n in LoreArray {
                        print(n)
                        if let title = n["title"] as? String {
                            if let text = n["text"] as? String {
                                if !text.isEmpty {
                                    if title == currentTitle {
                                        let appendedString = CreatureController.sharedInstance.stringFormatter("\(text)\n\n")
                                        print(appendedString)
                                        creatureString += appendedString
                                    } else {
                                        let appendedString = CreatureController.sharedInstance.stringFormatter("◇  \(title)  ◇\n\n\(text)\n\n")
                                        
                                        creatureString += appendedString
                                        currentTitle = title
                                    }
                                }
                            }
                        }
                    }
                    if let nameDict = LoreArray[0] as? jsonDictionary {
                        if let name = nameDict["title"] as? String {
                            creatureName = name
                        }
                    }
                    completion(creatureString: creatureString, name: creatureName)
                })
            }
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
    
    
    static func creatureImageURLForNameAndIndex(searchTerm:String, index:Int, completion:(creatureImageURL:String) -> Void) {
        dispatch_async(dispatch_get_main_queue()) {
            
            CreatureController.retrieveCreatureNetworkJSON(searchTerm) { (resultsData) -> Void in
                CreatureController.sharedInstance.constructImageJSONArray(resultsData, completion: { (ImageArray, success) -> Void in
                    if index < ImageArray.count {
                        if let json = ImageArray[index] as? jsonDictionary {
                            if let newImage = CreatureImage(imageJSON: json) {
                                let newImageURL = newImage.cImageURL
                                print(newImageURL)
                                let imageURL = CreatureController.sharedInstance.urlFormatterForSecurity(newImageURL)
                                print(imageURL)
                                completion(creatureImageURL: imageURL)
                            } else {
                                print("No Image")
                                completion(creatureImageURL: "No creature image URL found.")
                            }
                        } else {
                            print("No JSON")
                            completion(creatureImageURL: "No creature image URL found.")
                        }
                    } else {
                        print("Index Out of Range.")
                        completion(creatureImageURL: "http://vignette3.wikia.nocookie.net/harrypotter/images/a/a1/Department_for_the_Regulation_and_Control_of_Magical_Creatures_logo.png/revision/latest?cb=20080319162035")
                    }
                })
            }
        }
    }
    
    
    //only complete with all results from constructImageJSONArray
    func creatureImageUrlArrayForName(searchTerm:String, completion:(creatureImageUrlArray:[String], success: Bool) ->Void) {
        self.currentCreatureImageUrlArray.removeAll()
        CreatureController.retrieveCreatureNetworkJSON(searchTerm) { (resultsData) -> Void in
            CreatureController.sharedInstance.constructImageJSONArray(resultsData, completion: { (ImageArray, success) -> Void in
                if success {
                    var creatureImageArray = [String]()
                    print("\(ImageArray.count)")
                    for n in ImageArray {
                        if let json = n as? jsonDictionary {
                            if let newImage = CreatureImage(imageJSON: json) {
                                let imageURL = newImage.cImageURL
                                let formattedURL = CreatureController.sharedInstance.urlFormatterForSecurity(imageURL)
                                print("\(formattedURL)")
                                
                                creatureImageArray.append(formattedURL)
                                print("CreatureImageURL Array appended, has \(creatureImageArray.count)")
                                self.currentCreatureImageUrlArray = creatureImageArray
                                completion(creatureImageUrlArray: creatureImageArray, success: true)
                            } else {
                                print("No Image")
                                completion(creatureImageUrlArray: creatureImageArray, success: false)
                            }
                        } else {
                            print("No JSON")
                            completion(creatureImageUrlArray: creatureImageArray, success: false)
                        }
                    }
                } else {
                    print("No URLs found.")
                    completion(creatureImageUrlArray: [""], success: false)
                }
            })
        }
    }
    
    
    func creatureImageDataObjectArrayForName(searchTerm:String, completion:(creatureImageArray:jsonArray) -> Void) {
        self.imageArray.removeAll()
        
        CreatureController.retrieveCreatureNetworkJSON(searchTerm) { (resultsData) -> Void in
            CreatureController.sharedInstance.constructImageJSONArray(resultsData, completion: { (ImageArray, success) -> Void in
                self.imageArray = ImageArray
                completion(creatureImageArray: ImageArray)
            })
        }
    }
    
    
    static func retrieveCreatureNetworkJSON(creature:String, completion:(resultsData:jsonDictionary) -> Void) {
        let baseURL = NetworkController.baseCreatureURLForSearch(creature)
        dispatch_async(dispatch_get_main_queue()) {
            NetworkController.dataAtURL(baseURL) { (resultData, json, success) -> Void in
                if let itemsArray = json["items"] as? [[String:AnyObject]] {
                    for idDictionary in itemsArray {
                        if let creatureIDFound = idDictionary["id"] {
                            let creatureURL = NetworkController.creatureURLForID("\(creatureIDFound)")
                            NetworkController.dataAtURL(creatureURL, completion: { (resultData, json, success) -> Void in
                                print("Data retrieved.")
                                completion(resultsData: json)
                            })
                        } else {
                            print("No creatureID found.")
                            completion(resultsData: json)
                        }
                    }
                } else {
                    print("No Items Array found.")
                    completion(resultsData: json)
                }
            }
        }
    }
    
    
    func constructLoreJSONArray(resultData:jsonDictionary, completion:(LoreArray:jsonArray, success:Bool, name:String) -> Void) {
        creatureLoreJSON.removeAll()
        creatureLoreJSONCollection.removeAll()
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
        self.LoreArray.removeAll()
        print(self.LoreArray)
        completion(LoreArray: creatureLoreJSONCollection, success: true, name: "\(nameTitle)")
    }
    
    
    //problem function, NEED TO COMPLETE ONLY IF EVERY ITEM IS PRESENT, OTHERWISE KEEP LOOPING
    func constructImageJSONArray(resultData:jsonDictionary, completion:(ImageArray:jsonArray, success:Bool) -> Void) {
        creatureImageJSON.removeAll()
        creatureImageJSONCollection.removeAll()
        var counter = Int()
       
        if let sectionsArray = resultData["sections"] as? jsonArray {
            print("\(sectionsArray.count)")
            for n in sectionsArray {
                counter += 1
                print("\(counter)")
                if let imageArray = n["images"] as? jsonArray {
                    var currentImage = String()
                    for n in imageArray {
                        if let url = n["src"] as? String {
                            if url != currentImage {
                                if !url.isEmpty {
                                    
                                    creatureImageJSON = ["src":"\(url):"]
                                    let cURL = self.stringFormatter(url)
                                    creatureImageJSON.updateValue("\(cURL)", forKey: "src")
                                    print("\(creatureImageJSON)")
                                    creatureImageJSONCollection.append(creatureImageJSON)
                                    counter += 1
                                    currentImage = url
                                    print("creatureImageJSON appended")
                                    if counter == sectionsArray.count {
                                        print("All ImageJSON found.")
                                        completion(ImageArray: creatureImageJSONCollection, success: true)
                                    } else {
                                        completion(ImageArray: creatureImageJSONCollection, success: false)
                                    }
                                }
                            } else {
                                print("No ImageJSON")
//                                completion(ImageArray: creatureImageJSONCollection, success: false)
                            }
                        } else {
                            print("No image Array")
//                            completion(ImageArray: creatureImageJSONCollection, success: false)
                        }
                    }
                }
            }
        } else {
            print("No sections Array")
//            completion(ImageArray: creatureImageJSONCollection, success: false)
        }
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
