//
//  GroupListTableViewController.swift
//  BevChat
//
//  Created by Ross McIlwaine on 6/14/16.
//  Copyright © 2016 Ross McIlwaine. All rights reserved.
//

import UIKit
import Firebase

class GroupListTableViewController: UITableViewController {

    var groups = [Group]()
    var messages = [Message]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

       groups = GroupController.groupArray()
        
        // Check if user is logged in
        if UserController.currentUser == nil {
            self.performSegueWithIdentifier("toLoginSegue", sender: self)
        }
    }

    // MARK: - Table view data source

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return GroupController.groupArray().count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("groupCell", forIndexPath: indexPath)

        let group = groups[indexPath.row]
        cell.textLabel?.text = group.name
        cell.detailTextLabel?.text = "\(messages.count)"
        

        return cell
    }
    
    @IBAction func logoutButtonTapped(sender: AnyObject) {
        
        let firebaseAuth = FIRAuth.auth()
        do {
            try firebaseAuth?.signOut()
            dismissViewControllerAnimated(true, completion: nil)
        } catch let signoutError as NSError {
            print("Error signing out: \(signoutError)")
        }
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "toDetailSegue" {
            let groupTVC = segue.destinationViewController as? GroupDetailViewController
            if let indexPath = tableView.indexPathForSelectedRow {
                let group = GroupController.groupArray()[indexPath.row]
                groupTVC?.group = group
            }
        }
    }
}
