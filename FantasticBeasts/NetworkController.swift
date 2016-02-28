//
//  NetworkControllerFile.swift
//  FantasticBeasts
//
//  Created by Jay Maloney on 2/22/16.
//  Copyright © 2016 Jay Maloney. All rights reserved.
//

import Foundation

class NetworkController {
    
    static let sharedInstance = NetworkController()
    
    
    static func baseCreatureURLForSearch(searchTerm:String) -> NSURL {
        let modifiedSearchTerm = searchTerm.stringByReplacingOccurrencesOfString(" ", withString: "+").lowercaseString
        return NSURL(string: "http://harrypotter.wikia.com/api/v1/Search/List/?query=\(modifiedSearchTerm)&limit=1&namespaces=0%2C14")!
    }
    
    static func creatureURLForID(id:String) -> NSURL {
        return NSURL(string: "http://harrypotter.wikia.com/api/v1/Articles/Assimplejson?id=\(id)&limit=1")!
    }
    
    static func imageDataAtURL(url:NSURL, completion:(resultData:NSData?, success:Bool) -> Void) {
        print(url)
        let config = NSURLSessionConfiguration.ephemeralSessionConfiguration()
        let session = NSURLSession(configuration: config)
        let dataTask = session.dataTaskWithURL(url) { (data, response, error) -> Void in
            dispatch_async(dispatch_get_main_queue()) {
                if let error = error {
                    print("JSON NOT Serialized Successfully.")
                    print(error.localizedDescription)
                } else {
                    guard let data = data where error == nil else { return }
                    let priority = DISPATCH_QUEUE_PRIORITY_HIGH
                    dispatch_async(dispatch_get_global_queue(priority, 0)) {
                        dispatch_async(dispatch_get_main_queue()) {
                            print("JSON Serialized Successfully.")
                            completion(resultData: data, success: true)
                        }
                    }
                }
            }
        }
        dataTask.resume()
    }
    
    static func dataAtURL(url:NSURL, completion:(resultData:NSData?, json:jsonDictionary, success:Bool) -> Void) {
        let config = NSURLSessionConfiguration.ephemeralSessionConfiguration()
        let session = NSURLSession(configuration: config)
        let dataTask = session.dataTaskWithURL(url) { (data, response, error) -> Void in
            dispatch_async(dispatch_get_main_queue()) {
                if let error = error {
                    print(error.localizedDescription)
                } else {
                    do
                    {
                        if let json = try NSJSONSerialization.JSONObjectWithData(data!, options: .AllowFragments) as? [String:AnyObject] {
                            //                            print(json)
                            let priority = DISPATCH_QUEUE_PRIORITY_HIGH
                            dispatch_async(dispatch_get_global_queue(priority, 0)) {
                                dispatch_async(dispatch_get_main_queue()) {
                                    print("JSON Serialized Successfully.")
                                    completion(resultData: data, json: json, success: true)
                                }
                            }
                        }
                    } catch {
                        dispatch_async(dispatch_get_main_queue()) {
                            print("JSON Failed to Serialize.")
                            print(error)
                            completion(resultData: (nil), json: ["":""], success: false)
                        }
                    }
                }
            }
        }
        dataTask.resume()
    }
}

