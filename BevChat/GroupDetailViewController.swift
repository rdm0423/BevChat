//
//  GroupDetailViewController.swift
//  BevChat
//
//  Created by Ross McIlwaine on 6/16/16.
//  Copyright © 2016 Ross McIlwaine. All rights reserved.
//

import UIKit
import Firebase

class GroupDetailViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate {

    @IBOutlet weak var messageTextField: UITextField!
    @IBOutlet weak var tableview: UITableView!
    var ref: FIRDatabaseReference!
    var messages = [Message]()
    var group: Group?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Unwrap group and group.identifier
        if let group = group,
        let groupID = group.identifier {
            MessageController.observeMessagesInGroup(groupID, completion: { (messages) in
                self.messages = messages
                self.tableview.reloadData()
            })
        }
        
    }
    
    @IBAction func SendButtonTapped(sender: AnyObject) {
        

    }
    
    // MARK: - Table view data source
    
    // UITableViewDataSource protocol methods
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("messageCell", forIndexPath: indexPath)

        let message = messages[indexPath.row]
        cell.textLabel?.text = message.sender
        cell.detailTextLabel?.text = message.messageText
        cell.imageView?.image = message.image
    
        return cell
    }
    
    // UITextViewDelegate protocol methods
    
//    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
//        guard let text = textField.text else { return true }
//        
//        let newLength = text.utf16.count + string.utf16.count - range.length
//        return newLength <= self.msglength.integerValue // Bool
//    }
    
//    func textFieldShouldReturn(textField: UITextField) -> Bool {
//        let data = [messageTextField: textField.text! as String]
//        sendMessage(data)
//        return true
//    }
    
    // data: [String : AnyObject]
//    func messageSend() {
//        
//        if let group = group,
//            let groupID = group.identifier,
//            let sender = messages.sender,
//            let messageText = messageTextField.text {
//            
//            MessageController.createMessage(groupID, sender: sender, messageText: messageText)
//        }
//        
//    }
}
