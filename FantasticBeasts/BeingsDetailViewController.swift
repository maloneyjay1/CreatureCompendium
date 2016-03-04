//
//  BeingsViewController.swift
//  FantasticBeasts
//
//  Created by Jay Maloney on 2/29/16.
//  Copyright © 2016 Jay Maloney. All rights reserved.
//

import UIKit

class BeingsDetailViewController: UIViewController {
    
    static let sharedInstance = BeingsDetailViewController()
    
    @IBOutlet weak var beingName: UILabel!
    @IBOutlet weak var beingImage: UIImageView!
    @IBOutlet weak var beingLore: UITextView!
    
    var creatureSearch:String = ""
    var creatureString:String = ""
    var name:String = ""
    var image = UIImage()
    
    func retrieveBeing(searchTerm:String) -> Void {
        dispatch_async(dispatch_get_main_queue()) {
            let imageIndex:Int = Constants.sharedInstance.beingImageIndex(searchTerm)
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
            self.name = BeingController.sharedInstance.beingName
            self.creatureString = BeingController.sharedInstance.beingLore
            self.image = BeingController.sharedInstance.beingImage
            completion(success: true)
        }
    }
    
    func eraseProps() {
        self.beingName.text? = ""
        print(beingName.text)
        self.beingLore.text = ""
        print(beingLore.text)
        self.beingImage.image = nil
    }
    
    func setupView(name:String, text:String, beingImage:UIImage) {
        dispatch_async(dispatch_get_main_queue()) {
            self.eraseProps()
            print(self.beingName)
            print(self.beingLore)
            
            print(name)
            self.beingName.text! = name
            print(text)
            self.beingLore.text! = "\(text)"
            print(self.image)
            self.beingImage.image = beingImage
        }
    }
    
    override func viewDidDisappear(animated: Bool) {
        BeingController.sharedInstance.clearData()
        let name = BeingController.sharedInstance.beingName
        print(name)
        let text = BeingController.sharedInstance.beingLore
        print(text)
        let image = BeingController.sharedInstance.beingImage
        
        dispatch_async(dispatch_get_main_queue()) {
            self.setupView(name, text: text, beingImage: image)
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let name = BeingController.sharedInstance.beingName
        print(name)
        let text = BeingController.sharedInstance.beingLore
        print(text)
        let image = BeingController.sharedInstance.beingImage
        
        dispatch_async(dispatch_get_main_queue()) {
            self.setupView(name, text: text, beingImage: image)
        }

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
