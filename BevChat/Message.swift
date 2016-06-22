//
//  Message.swift
//  BevChat
//
//  Created by Ross McIlwaine on 6/15/16.
//  Copyright © 2016 Ross McIlwaine. All rights reserved.
//

import UIKit

class Message: FirebaseType {
    
    private let kSender = "sender"
    private let kMessageText = "messageText"
    private let kSenderImage = "senderImage"
    private let kMessageImage = "messageImage"
    private let kTimestamp = "timestamp"
    
    var sender: String
    var senderImage: UIImage?
    var messageText: String
    var messageImage: UIImage?
    var timestamp: NSDate
    var identifier: String?
    
    
    var endpoint: String {
        return "messages"
    }
    
    var jsonValue: [String : AnyObject] {
        var jsonDictionary: [String: AnyObject] = [kSender : sender, kMessageText : messageText, kTimestamp : timestamp.timeIntervalSince1970]
        
        if let senderImageBase = senderImage?.base64String {
           jsonDictionary.updateValue(senderImageBase, forKey: kSenderImage)
        }
        
        if let messageImageBase = messageImage?.base64String {
            jsonDictionary.updateValue(messageImageBase, forKey: kMessageImage)
        }
        
        return jsonDictionary
    }
    
    init(sender: String, messageText: String, senderImage: UIImage? = nil, messageImage: UIImage? = nil) {
        
        self.sender = sender
        self.messageText = messageText
        self.senderImage = senderImage
        self.messageImage = messageImage
        self.timestamp = NSDate()
    }
    
    required init?(dictionary: [String : AnyObject], identifier: String) {
        
        guard let sender = dictionary[kSender] as? String,
            let messageText = dictionary[kMessageText] as? String,
            let timestamp = dictionary[kTimestamp] as? Double else {
                return nil
        }
        self.sender = sender
        self.messageText = messageText
        self.timestamp = NSDate.init(timeIntervalSince1970: timestamp)
        
        if let profileImage = dictionary[kSenderImage] as? String, let image = UIImage(base64: profileImage) {
            self.senderImage = image
        } else {
            self.senderImage = UIImage(named: "stockUser")!
        }
        if let messageImage = dictionary[kMessageImage] as? String, let image = UIImage(base64: messageImage) {
            self.messageImage = image
        } else {
            self.messageImage = nil
        }
        self.identifier = identifier
    }
}