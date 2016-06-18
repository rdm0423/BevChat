//
//  Group.swift
//  BevChat
//
//  Created by Ross McIlwaine on 6/15/16.
//  Copyright © 2016 Ross McIlwaine. All rights reserved.
//

import Foundation

class Group: FirebaseType {
    
    private let kName = "name"
    private let kMessageIDs = "messageId"
    
    let name: String
    var messageIDs: [String]
    var identifier: String?
    
    var endpoint: String {
        return "groups"
    }
    
    var jsonValue: [String : AnyObject] {
        return [kName : name, kMessageIDs : messageIDs.map {[$0: true]}]
    }
    
    init(name: String) {
        self.name = name
        self.messageIDs = []
    }
    
    required init?(dictionary: [String : AnyObject], identifier: String) {
        
        guard let name = dictionary[kName] as? String,
            let messageIDs = dictionary[kMessageIDs] as? [String] else {
                return nil
        }
        self.name = name
        self.messageIDs = messageIDs
        self.identifier = identifier
    }
}