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
        
        loadMessageCount()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        tableView.reloadData()
    }
    
    // MARK: - Table view data source
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return GroupController.groupArray().count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("groupCell", forIndexPath: indexPath)
        
        let group = groups[indexPath.row]
        cell.textLabel?.text = group.name
        cell.textLabel?.numberOfLines = 0
        cell.detailTextLabel?.text = "\(group.messageIDs.count) \n messages"
        cell.detailTextLabel?.font = UIFont.systemFontOfSize(11.0)
        cell.detailTextLabel?.numberOfLines = 0
        
        
        return cell
    }
    
    @IBAction func logoutButtonTapped(sender: AnyObject) {
        
        let firebaseAuth = FIRAuth.auth()
        do {
            try firebaseAuth?.signOut()
            self.performSegueWithIdentifier("toLoginSegue", sender: self)
        } catch let signoutError as NSError {
            print("Error signing out: \(signoutError)")
        }
    }
    
    func loadMessageCount() {
        
        if groups.count == 5  {
            if let identifier0 = groups[0].identifier,
                let identifier1 = groups[1].identifier,
                let identifier2 = groups[2].identifier,
                let identifier3 = groups[3].identifier,
                let identifier4 = groups[4].identifier {
                GroupController.fetchMessageIDsForGroupID(identifier0) { (messageIDs) in
                    self.groups[0].messageIDs = messageIDs
                    self.tableView.reloadData()
                }
                GroupController.fetchMessageIDsForGroupID(identifier1) { (messageIDs) in
                    self.groups[1].messageIDs = messageIDs
                    self.tableView.reloadData()
                }
                GroupController.fetchMessageIDsForGroupID(identifier2) { (messageIDs) in
                    self.groups[2].messageIDs = messageIDs
                    self.tableView.reloadData()
                }
                GroupController.fetchMessageIDsForGroupID(identifier3) { (messageIDs) in
                    self.groups[3].messageIDs = messageIDs
                    self.tableView.reloadData()
                }
                GroupController.fetchMessageIDsForGroupID(identifier4) { (messageIDs) in
                    self.groups[4].messageIDs = messageIDs
                    self.tableView.reloadData()
                }
            }
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
