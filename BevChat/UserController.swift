//
//  UserController.swift
//  BevChat
//
//  Created by Ross McIlwaine on 6/14/16.
//  Copyright © 2016 Ross McIlwaine. All rights reserved.
//

import Foundation
import Firebase

class UserController {
    
    static var currentUser: User?
    
    static func createUser(firstName: String, lastName: String, displayName: String, profilePhoto: UIImage, email: String, password: String, completion: (user: User?) -> Void) {
        FIRAuth.auth()?.createUserWithEmail(email, password: password, completion: { (user, error) in
            if let error = error {
                print("There was error while creating user: \(error.localizedDescription)")
                completion(user: nil)
            } else if let firebaseUser = user {
                var user = User(firstName: firstName, lastName: lastName, displayName: displayName, profilePhoto: profilePhoto, identifier: firebaseUser.uid)
                user.save()
                UserController.currentUser = user
                completion(user: user)
            } else {
                completion(user: nil)
            }
        })
    }
    
    static func authUser(email: String, password: String, completion: (success: Bool, user: User?) -> Void) {
        FIRAuth.auth()?.signInWithEmail(email, password: password, completion: { (firebaseUser, error) in
            if let error = error {
                print("Wasn't able log user in: \(error.localizedDescription)")
                completion(success: false, user: nil)
            } else if let firebaseUser = firebaseUser {
                UserController.fetchUserForIdentifier(firebaseUser.uid, completion: { (user) in
                    guard let user = user else {
                        completion(success: false, user: nil)
                        return
                    }
                    UserController.currentUser = user
                    completion(success: true, user: user)
                })
            } else {
                completion(success: false, user: nil)
            }
        })
    }
    
    static func fetchUserForIdentifier(identifier: String, completion: (user: User?) -> Void) {
        FirebaseController.ref.child("users").child(identifier).observeSingleEventOfType(.Value, withBlock: { data in
            guard let dataDict = data.value as? [String: AnyObject],
                user = User(dictionary: dataDict, identifier: data.key) else {
                    completion(user: nil)
                    return
            }
            completion(user: user)
            
            
        })
    }
    
    func saveUserToDefaults() {
        
        NSUserDefaults.standardUserDefaults().setObject(<#T##value: AnyObject?##AnyObject?#>, forKey: <#T##String#>)
    }
    
    static func isUserLoggedIn(user: User) -> Bool {
        
        
    }
}