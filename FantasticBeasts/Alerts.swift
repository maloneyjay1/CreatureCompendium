//
//  Alerts.swift
//  FantasticBeasts
//
//  Created by Jay Maloney on 2/29/16.
//  Copyright © 2016 Jay Maloney. All rights reserved.
//

import Foundation
import UIKit

extension BeastsTableViewController {
    func generalAlert(title title: String, message: String, actionTitle: String){
        
        let alertViewController = UIAlertController(title: title, message: message, preferredStyle: .Alert)
        let alertAction = UIAlertAction(title: actionTitle, style: .Default, handler: nil)
        alertViewController.addAction(alertAction)
        presentViewController(alertViewController, animated: true, completion: nil)
    }
}

extension BeingsTableViewController {
    func generalAlert(title title: String, message: String, actionTitle: String){
        
        let alertViewController = UIAlertController(title: title, message: message, preferredStyle: .Alert)
        let alertAction = UIAlertAction(title: actionTitle, style: .Default, handler: nil)
        alertViewController.addAction(alertAction)
        presentViewController(alertViewController, animated: true, completion: nil)
    }
}

extension GhostsAndOtherTableViewController {
    func generalAlert(title title: String, message: String, actionTitle: String){
        
        let alertViewController = UIAlertController(title: title, message: message, preferredStyle: .Alert)
        let alertAction = UIAlertAction(title: actionTitle, style: .Default, handler: nil)
        alertViewController.addAction(alertAction)
        presentViewController(alertViewController, animated: true, completion: nil)
    }
}
