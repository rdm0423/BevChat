//
//  LogInViewController.swift
//  BevChat
//
//  Created by Ross McIlwaine on 6/14/16.
//  Copyright © 2016 Ross McIlwaine. All rights reserved.
//

import UIKit
import Firebase

class LogInViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    var signedIn = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

    }
    
    override func viewDidAppear(animated: Bool) {
        if let user = FIRAuth.auth()?.currentUser {
            //            self.signedIn(user)
        }
        
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func loginButtonTapped(sender: AnyObject) {
        
        if let email = emailTextField.text, password = passwordTextField.text {
            UserController.authUser(email, password: password, completion: { (success, user) in
                if success {
                    self.performSegueWithIdentifier("toHomeSegue", sender: self)
                } else {
                    // TODO: Present alert saying login was not successful
                }
            })
        }
        //        if let email = emailTextField.text, password = passwordTextField.text {
        //            FIRAuth.auth()?.signInWithEmail(email, password: password, completion: { (user, error) in
        //                if let error = error {
        //                    print(error.localizedDescription)
        //                    return
        //                }
        //                self.signedIn(user)
        //            })
        //        }
    }
    
    @IBAction func createButtonTapped(sender: AnyObject) {
    }
    
    @IBAction func forgotButtonTapped(sender: AnyObject) {
        
        passwordReset()
    }
    
    
    
    func signedIn(user: FIRUser?) {
        
        signedIn = true
        NSNotificationCenter.defaultCenter().postNotificationName("onSignInCompleted", object: nil, userInfo: nil)
        performSegueWithIdentifier("toHomeSegue", sender: self)
        
    }
    
    func passwordReset() {
        
        // code for reset password email link
        let prompt = UIAlertController.init(title: nil, message: "Email:", preferredStyle: UIAlertControllerStyle.Alert)
        let okAction = UIAlertAction.init(title: "OK", style: UIAlertActionStyle.Default) { (action) in
            let userInput = prompt.textFields![0].text
            if (userInput!.isEmpty) {
                return
            }
            FIRAuth.auth()?.sendPasswordResetWithEmail(userInput!) { (error) in
                if let error = error {
                    print(error.localizedDescription)
                    return
                }
            }
        }
        prompt.addTextFieldWithConfigurationHandler(nil)
        prompt.addAction(okAction)
        presentViewController(prompt, animated: true, completion: nil);
    }
    
}
