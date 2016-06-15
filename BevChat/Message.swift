//
//  Message.swift
//  BevChat
//
//  Created by Ross McIlwaine on 6/15/16.
//  Copyright © 2016 Ross McIlwaine. All rights reserved.
//

import Foundation

struct Message {
    
    let groupID: Group
    let userID: User
    var textString: String?
    var image: NSData?
    var timestamp: NSDate
    
}