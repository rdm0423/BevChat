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
//    var messages: [FIRDataSnapshot]! = []
    var messages = [Message]()
    var group: Group?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Unwrap group and group.identifier
//        MessageController.observeMessages(<#Group Identifier#>) { (messages) in
//            self.messages = messages
//            self.tableview.reloadData()
//        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func SendButtonTapped(sender: AnyObject) {
        
//        MessageController.createMessage(<#T##groupID: String##String#>, sender: <#T##String#>, messageText: <#T##String#>, image: <#T##UIImage?#>)
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
    
    func sendMessage(data: [String: String]) {
//        var mdata = data
//        mdata[Constants.MessageFields.name] = AppState.sharedInstance.displayName
//        if let photoUrl = AppState.sharedInstance.photoUrl {
//            mdata[Constants.MessageFields.photoUrl] = photoUrl.absoluteString
//        }
        // Push data to Firebase Database
//        self.ref.child("messages").childByAutoId().setValue(mdata)
    }



}
