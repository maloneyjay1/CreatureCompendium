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
    
    func updateProps() {
        self.name = BeastsController.sharedInstance.beastName
        self.creatureString = BeastsController.sharedInstance.beastLore
    }
    
    func setupView(name:String, text:String, beastImage:UIImage) {
        print(name)
        beastName.text! = name
        print(text)
        beastText.text! = "\(text)"
        print(self.image)
        beastImageView.image = UIImage()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let name = BeastsController.sharedInstance.beastName
        let text = BeastsController.sharedInstance.beastLore
        self.setupView(name, text: text, beastImage: UIImage())
    }
    
    override func viewDidAppear(animated: Bool) {
        let name = BeastsController.sharedInstance.beastName
        let text = BeastsController.sharedInstance.beastLore
        self.setupView(name, text: text, beastImage: UIImage())
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
