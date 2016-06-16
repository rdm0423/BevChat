//
//  User.swift
//  BevChat
//
//  Created by Ross McIlwaine on 6/15/16.
//  Copyright © 2016 Ross McIlwaine. All rights reserved.
//

import UIKit

class User: FirebaseType {
    
    private let kFirstName = "firstName"
    private let kLastName = "lastName"
    private let kDisplayName = "displayName"
    private let kProfilePhoto = "profilePhoto"
    
    let firstName: String
    let lastName: String
    let displayName: String
    let profilePhoto: UIImage
    var identifier: String?
    
    var endpoint: String {
        return "users"
    }
    
    var jsonValue: [String : AnyObject] {
        
        var jsonDictionary = [kFirstName : firstName, kLastName : lastName, kDisplayName : displayName]
        guard let imageBase = profilePhoto.base64String else {
            return jsonDictionary
        }
        jsonDictionary.updateValue(imageBase, forKey: kProfilePhoto)
        return jsonDictionary
    }
    
    init(firstName: String, lastName: String, displayName: String, profilePhoto: UIImage, identifier: String) {
        self.firstName = firstName
        self.lastName = lastName
        self.displayName = displayName
        self.profilePhoto = profilePhoto
        self.identifier = identifier
    }
    
    required init?(dictionary: [String : AnyObject], identifier: String) {
        
        guard let firstName = dictionary[kFirstName] as? String,
            let lastName = dictionary[kLastName] as? String,
            let displayName = dictionary[kDisplayName] as? String else {
                return nil
        }
        self.firstName = firstName
        self.lastName = lastName
        self.displayName = displayName
        
        if let profilePhotoString = dictionary[kProfilePhoto] as? String, let profilePhoto = UIImage(base64: profilePhotoString) {
            self.profilePhoto = profilePhoto
        } else {
            self.profilePhoto = UIImage(named: "stockUser")!
            
        }
        self.identifier = identifier
    }
    
}