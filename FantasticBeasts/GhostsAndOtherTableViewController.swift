//
//  GhostsAndOtherTableViewController.swift
//  FantasticBeasts
//
//  Created by Jay Maloney on 2/28/16.
//  Copyright © 2016 Jay Maloney. All rights reserved.
//

import UIKit

class GhostsAndOtherTableViewController: UITableViewController {
    
    static let sharedInstance = GhostsAndOtherTableViewController()
    
    var creatureSelection:String = ""
    
    var ghosts:[String] = []
    
    override func viewDidAppear(animated: Bool) {
        tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ghosts = Constants.sharedInstance.ghostsNonBeingAndUnknownNames()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    //    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    //        // #warning Incomplete implementation, return the number of sections
    //        return 0
    //    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ghosts.count
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("ghostAndOtherCell", forIndexPath: indexPath)
        
        let creature = Constants.sharedInstance.ghostsNonBeingAndUnknownNames()[indexPath.row]
        
        cell.textLabel?.text = creature
        cell.textLabel?.font = UIFont(name: "Cairo", size: 15)
        
        cell.detailTextLabel?.text = "͢"
        
        cell.imageView?.image = UIImage(named: "ghostResize")
        
        return cell
    }
    
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
    // Return false if you do not want the specified item to be editable.
    return true
    }
    */
    
    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
    if editingStyle == .Delete {
    // Delete the row from the data source
    tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
    } else if editingStyle == .Insert {
    // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }
    }
    */
    
    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {
    
    }
    */
    
    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
    // Return false if you do not want the item to be re-orderable.
    return true
    }
    */
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let indexPath = tableView.indexPathForSelectedRow
        print(indexPath)
        
        if let selectedRow = indexPath?.row {
            dispatch_async(dispatch_get_main_queue()) {
                
                self.creatureSelection = Constants.sharedInstance.ghostsNonBeingAndUnknownNames()[selectedRow]
                
                GhostsAndOtherController.sharedInstance.retrieveAllLoreAndName(self.creatureSelection, completion: { (success) -> Void in
                    GhostsAndOtherController.sharedInstance.retrieveImage(self.creatureSelection, index: 0, completion: { (success) -> Void in
                        if success {
                            if success {
                                GhostsOtherDetailViewController.sharedInstance.updateProps({ (success) -> Void in
                                    if success {
                                        self.performSegueWithIdentifier("toGhostsDetail", sender: self)
                                    }
                                })
                            }
                        }
                    })
                })
            }
        }
    }
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "toGhostsDetail" {
            
            if let destinationViewController = segue.destinationViewController as? GhostsOtherDetailViewController {
                
                let indexPath = tableView.indexPathForSelectedRow
                
                _ = destinationViewController.view
                
                if let selectedRow = indexPath?.row {
                    
                    self.creatureSelection = Constants.sharedInstance.ghostsNonBeingAndUnknownNames()[selectedRow]
                    GhostsAndOtherController.sharedInstance.creatureIndex = selectedRow
                    
                }
            }
        }
        
    }
    
    
}
