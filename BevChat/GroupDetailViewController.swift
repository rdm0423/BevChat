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
    var container: UIView = UIView()
    var loadingView: UIView = UIView()
    var activityIndicator = UIActivityIndicatorView()
    
    var ref: FIRDatabaseReference!
    var messages = [Message]()
    var group: Group?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = group?.name
        
        showActivityIndicatory()
        

        // Get messages
        if let group = group,
        let groupID = group.identifier {
            MessageController.observeMessagesInGroup(groupID, completion: { (messages) in
                self.messages = messages.sort{$0.timestamp.timeIntervalSince1970 < $1.timestamp.timeIntervalSince1970}
                self.tableview.reloadData()
                self.scrollToBottom()
                self.hideActivityIndicator()
            })
            
        }
        
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIKeyboardWillShowNotification, object: self.view.window)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIKeyboardWillHideNotification, object: self.view.window)
        
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
    
    func messageSend() {
        
        if let group = group,
            let groupID = group.identifier,
            let sender = UserController.currentUser,
            let messageText = messageTextField.text {
            // TODO: Finish functionality when we have view setup to take in a message image
            MessageController.createMessage(groupID, sender: sender.displayName, messageText: messageText, senderImage: sender.profilePhoto, messageImage: nil)
        }
        messageTextField.text = ""
        messageTextField.resignFirstResponder()
        scrollToBottom()
    }

    func scrollToBottom() {
        if messages.count > 0 {
            let indexPath = NSIndexPath(forRow: (messages.count - 1), inSection: 0)
            tableview.scrollToRowAtIndexPath(indexPath, atScrollPosition: .Bottom, animated: false)
        }
    }
    
    func keyboardWillShow(sender: NSNotification) {
        guard let userInfo: [NSObject: AnyObject] = sender.userInfo,
            keyboardSize: CGSize = userInfo[UIKeyboardFrameBeginUserInfoKey]?.CGRectValue.size,
            offset: CGSize = userInfo[UIKeyboardFrameEndUserInfoKey]?.CGRectValue.size else { return }
        if keyboardSize.height == offset.height && self.view.frame.origin.y == 0 {
            UIView.animateWithDuration(0.1, animations: {
                self.view.frame.origin.y -= keyboardSize.height
            })
        } else {
            UIView.animateWithDuration(0.1, animations: {
                self.view.frame.origin.y += (keyboardSize.height - offset.height)
            })
        }
        scrollToBottom()
    }
    
    func keyboardWillHide(sender: NSNotification) {
        guard let userInfo: [NSObject: AnyObject] = sender.userInfo,
            keyboardSize: CGSize = userInfo[UIKeyboardFrameBeginUserInfoKey]?.CGRectValue.size else { return }
        self.view.frame.origin.y  += keyboardSize.height
        scrollToBottom()
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillShowNotification, object: self.view.window)
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillHideNotification, object: self.view.window)
    }
    
    // MARK: - Activity Indicator
    
    func showActivityIndicatory() {
        container.frame = view.frame
        container.center = view.center
        container.backgroundColor = UIColorFromHex(0xffffff, alpha: 0.3)
        
        loadingView.frame = CGRectMake(0, 0, 80, 80)
        loadingView.center = view.center
        loadingView.backgroundColor = UIColorFromHex(0x444444, alpha: 0.7)
        loadingView.clipsToBounds = true
        loadingView.layer.cornerRadius = 10
        
        activityIndicator.frame = CGRectMake(0.0, 0.0, 40.0, 40.0);
        activityIndicator.activityIndicatorViewStyle =
            UIActivityIndicatorViewStyle.WhiteLarge
        activityIndicator.center = CGPointMake(loadingView.frame.size.width / 2,
                                    loadingView.frame.size.height / 2);
        loadingView.addSubview(activityIndicator)
        container.addSubview(loadingView)
        view.addSubview(container)
        activityIndicator.startAnimating()
    }
    
    func hideActivityIndicator() {
        activityIndicator.stopAnimating()
        container.removeFromSuperview()
    }
    
    func UIColorFromHex(rgbValue:UInt32, alpha:Double=1.0)->UIColor {
        let red = CGFloat((rgbValue & 0xFF0000) >> 16)/256.0
        let green = CGFloat((rgbValue & 0xFF00) >> 8)/256.0
        let blue = CGFloat(rgbValue & 0xFF)/256.0
        return UIColor(red:red, green:green, blue:blue, alpha:CGFloat(alpha))
    }
}
