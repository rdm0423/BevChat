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
    private let kImage = "image"
    private let kTimestamp = "timestamp"
    
    var sender: String
    var messageText: String
    var image: UIImage?
    var timestamp: NSDate
    var identifier: String?
    
    
    var endpoint: String {
        return "messages"
    }
    
    var jsonValue: [String : AnyObject] {
        var jsonDictionary: [String: AnyObject] = [kSender : sender, kMessageText : messageText, kTimestamp : timestamp.timeIntervalSince1970]
        
        guard let imageBase = image?.base64String else {
            return jsonDictionary
        }
        jsonDictionary.updateValue(imageBase, forKey: kImage)
        return jsonDictionary
    }
    
    init(sender: String, messageText: String, image: UIImage? = nil) {
        
        self.sender = sender
        self.messageText = messageText
        self.image = image
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
        
        if let imageString = dictionary[kImage] as? String, let image = UIImage(base64: imageString) {
            self.image = image
        } else {
            self.image = UIImage(named: "stockUser")!
        }
        self.identifier = identifier
    }
}