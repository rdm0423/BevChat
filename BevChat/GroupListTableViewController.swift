//
//  GroupListTableViewController.swift
//  BevChat
//
//  Created by Ross McIlwaine on 6/14/16.
//  Copyright © 2016 Ross McIlwaine. All rights reserved.
//

import UIKit

class GroupListTableViewController: UITableViewController {

    var groups = [Group]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

       groups = GroupController.groupArray()
    }

    // MARK: - Table view data source

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return GroupController.groupArray().count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("groupCell", forIndexPath: indexPath)

        let group = groups[indexPath.row]
        cell.textLabel?.text = group.name
        

        return cell
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        
    }
}
