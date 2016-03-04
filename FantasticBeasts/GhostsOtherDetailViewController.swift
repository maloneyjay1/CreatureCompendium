//
//  GhostsOtherDetailViewController.swift
//  FantasticBeasts
//
//  Created by Jay Maloney on 2/29/16.
//  Copyright © 2016 Jay Maloney. All rights reserved.
//

import UIKit

class GhostsOtherDetailViewController: UIViewController {
    
    static let sharedInstance = GhostsOtherDetailViewController()
    
    @IBOutlet weak var ghostName: UILabel!
    @IBOutlet weak var ghostImage: UIImageView!
    @IBOutlet weak var ghostLore: UITextView!
    
    var creatureSearch:String = ""
    var creatureString:String = ""
    var name:String = ""
    var image = UIImage()
    
    func retrieveGhost(searchTerm:String) -> Void {
        dispatch_async(dispatch_get_main_queue()) {
            let imageIndex:Int = Constants.sharedInstance.ghostImageIndex(searchTerm)
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
            self.name = GhostsAndOtherController.sharedInstance.ghostName
            self.creatureString = GhostsAndOtherController.sharedInstance.ghostLore
            self.image = GhostsAndOtherController.sharedInstance.ghostImage
            completion(success: true)
        }
    }
    
    func eraseProps() {
        self.ghostName.text = ""
        self.ghostLore.text = ""
        self.ghostImage.image = nil
    }
    
    func setupView(name:String, text:String, image:UIImage) {
        dispatch_async(dispatch_get_main_queue()) {
            self.eraseProps()
            print(self.ghostName)
            print(self.ghostLore)
            
            print(name)
            self.ghostName.text! = name
            print(text)
            self.ghostLore.text! = "\(text)"
            print(self.image)
            self.ghostImage.image = image
        }
    }
    
    override func viewDidDisappear(animated: Bool) {
        GhostsAndOtherController.sharedInstance.clearData()
        let name = GhostsAndOtherController.sharedInstance.ghostName
        print(name)
        let text = GhostsAndOtherController.sharedInstance.ghostLore
        print(text)
        let image = GhostsAndOtherController.sharedInstance.ghostImage
        
        dispatch_async(dispatch_get_main_queue()) {
            self.setupView(name, text: text, image: image)
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let name = GhostsAndOtherController.sharedInstance.ghostName
        print(name)
        let text = GhostsAndOtherController.sharedInstance.ghostLore
        print(text)
        let image = GhostsAndOtherController.sharedInstance.ghostImage
        
        dispatch_async(dispatch_get_main_queue()) {
            self.setupView(name, text: text, image: image)
        }
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
