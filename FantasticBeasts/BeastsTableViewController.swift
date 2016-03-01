//
//  BeastsTableViewController.swift
//  FantasticBeasts
//
//  Created by Jay Maloney on 2/28/16.
//  Copyright © 2016 Jay Maloney. All rights reserved.
//

import UIKit

class BeastsTableViewController: UITableViewController {
    
    static let sharedInstance = BeastsTableViewController()
    
    var creatureSelection:String = ""
    
    override func viewDidAppear(animated: Bool) {
        tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        generalAlert(title: "Attention to Employees", message: "\(Constants.sharedInstance.ministryOfMagicUpdate())", actionTitle: "OK")
        
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
        // #warning Incomplete implementation, return the number of rows
        return Constants.sharedInstance.beastNames().count
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("beastCell", forIndexPath: indexPath)
        
        let creature = Constants.sharedInstance.beastNames()[indexPath.row]
        
        cell.textLabel?.text = creature
        
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
        
        if let selectedRow = indexPath?.row {
            self.creatureSelection = Constants.sharedInstance.beastNames()[selectedRow]
            
            BeastsController.sharedInstance.retrieveAllLoreAndName(creatureSelection, completion: { (success) -> Void in
                if success {
                    
                    BeastsDetailViewController.sharedInstance.updateProps()
                    self.performSegueWithIdentifier("toBeastDetail", sender: self)
                }
            })
        }
    }
    
    // MARK: - Navigation
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "toBeastDetail" {
            
            if let destinationViewController = segue.destinationViewController as? BeastsDetailViewController {
                
                let indexPath = tableView.indexPathForSelectedRow
                
                _ = destinationViewController.view
                
                if let selectedRow = indexPath?.row {
                    
                    self.creatureSelection = Constants.sharedInstance.beastNames()[selectedRow]
                    
                }
            }
        }
    }
}
