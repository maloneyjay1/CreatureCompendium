//
//  BeastsDetailViewController.swift
//  FantasticBeasts
//
//  Created by Jay Maloney on 2/29/16.
//  Copyright © 2016 Jay Maloney. All rights reserved.
//

import UIKit

class BeastsDetailViewController: UIViewController {
    
    static let sharedInstance = BeastsDetailViewController()
    
    @IBOutlet weak var beastName: UILabel!
    @IBOutlet weak var beastImageView: UIImageView!
    @IBOutlet weak var beastText: UITextView!
    
    var creatureSearch:String = ""
    var creatureString:String = ""
    var name:String = ""
    var image = UIImage()
    
    func retrieveBeast(searchTerm:String) -> Void {
        dispatch_async(dispatch_get_main_queue()) {
            let imageIndex:Int = Constants.sharedInstance.beastImageIndex(searchTerm)
            CreatureController.allCreatureLoreForNameAsString(searchTerm) { (creatureString, name) -> Void in
                self.creatureString = creatureString
                print(creatureString)
                self.name = name
                print(name)
                CreatureController.creatureImageObjectForNameAndIndex(searchTerm, index: imageIndex) { (creatureImageObject) -> Void in
                    ImageController.sharedInstance.getUIImageFromURL(creatureImageObject, completion: { (image, imageType) -> Void in
                        self.image = image
                        print(image)
                    })
                }
            }
        }
    }
    
    
    func updateProps(completion:(success:Bool) -> Void) {
        dispatch_async(dispatch_get_main_queue()) {
            self.name = BeastsController.sharedInstance.beastName
            self.creatureString = BeastsController.sharedInstance.beastLore
            self.image = BeastsController.sharedInstance.beastImage
            completion(success: true)
        }
    }
    
    func eraseProps() {
        self.beastName.text? = ""
        print(beastName.text)
        self.beastText.text = ""
        print(beastText.text)
        self.beastImageView.image = nil
    }
    
    func setupView(name:String, text:String, beastImage:UIImage) {
        dispatch_async(dispatch_get_main_queue()) {
            self.eraseProps()
            print(self.beastName)
            print(self.beastText)
            
            print(name)
            self.beastName.text! = name
            print(text)
            self.beastText.text! = "\(text)"
            print(self.image)
            self.beastImageView.image = beastImage
        }
    }
    
    override func viewDidDisappear(animated: Bool) {
        BeastsController.sharedInstance.clearData()
        let name = BeastsController.sharedInstance.beastName
        print(name)
        let text = BeastsController.sharedInstance.beastLore
        print(text)
        let image = BeastsController.sharedInstance.beastImage
        
        dispatch_async(dispatch_get_main_queue()) {
            self.setupView(name, text: text, beastImage: image)
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let name = BeastsController.sharedInstance.beastName
        print(name)
        let text = BeastsController.sharedInstance.beastLore
        print(text)
        let image = BeastsController.sharedInstance.beastImage
        
        dispatch_async(dispatch_get_main_queue()) {
            self.setupView(name, text: text, beastImage: image)
        }
    }
    
    
    
    
    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
    }
    */
    
}
