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
        
        self.navigationItem.title = group?.name

        // Unwrap group and group.identifier
        if let group = group,
        let groupID = group.identifier {
            MessageController.observeMessagesInGroup(groupID, completion: { (messages) in
                self.messages = messages.sort{$0.timestamp.timeIntervalSince1970 < $1.timestamp.timeIntervalSince1970}
                self.tableview.reloadData()
            })
        }
        
    }
    
    @IBAction func SendButtonTapped(sender: AnyObject) {
        
        messageSend()
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
        cell.imageView?.image = message.senderImage
    
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
    func messageSend() {
        
        if let group = group,
            let groupID = group.identifier,
            let sender = UserController.currentUser,
            let messageText = messageTextField.text {
            // TODO: Finish functionality when we have view setup to take in a message image
            MessageController.createMessage(groupID, sender: sender.displayName, messageText: messageText, senderImage: sender.profilePhoto, messageImage: nil)
        }
        
    }
}
