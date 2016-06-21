//
//  MessageController.swift
//  BevChat
//
//  Created by Ross McIlwaine on 6/14/16.
//  Copyright © 2016 Ross McIlwaine. All rights reserved.
//

import UIKit
import Firebase

class MessageController {
    
    static let kMessageIDKey = "messageIDs"
    static let kGroup = "groups"
    
    static func createMessage(groupID: String, sender: String, messageText: String, image: UIImage? = nil) {
        
        var message = Message(sender: sender, messageText: messageText, image: image)
        message.save()
        if let messageID = message.identifier {
            FirebaseController.ref.child(kGroup).child(groupID).child(kMessageIDKey).updateChildValues([messageID: true])
        }
    }
    
    static func observeMessagesInGroup(groupID: String, completion: (messages: [Message]) -> Void) {
        
        let messageIDRef = FirebaseController.ref.child(kGroup).child(groupID).child(kMessageIDKey)
        messageIDRef.observeEventType(.Value, withBlock: { data in
            guard let messageIdDicts = data.value as? [String: AnyObject] else {
                completion(messages: [])
                return
            }
            
            let group = dispatch_group_create()
            var messages = [Message]()
            let messageIDs = messageIdDicts.keys
            for id in messageIDs {
                dispatch_group_enter(group)
                FirebaseController.ref.child("messages").child(id).observeSingleEventOfType(.Value, withBlock: { (data) in
                    guard let value = data.value as? [String: AnyObject], let message = Message(dictionary: value, identifier: data.key) else {
                        completion(messages: messages)
                        return
                    }
                    messages.append(message)
                    dispatch_group_leave(group)
                })
            }
            
            dispatch_group_notify(group, dispatch_get_main_queue(), { 
                completion(messages: messages)
            })
        })
    }
}