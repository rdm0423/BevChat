//
//  CreateAccountViewController.swift
//  BevChat
//
//  Created by Ross McIlwaine on 6/14/16.
//  Copyright © 2016 Ross McIlwaine. All rights reserved.
//

import UIKit

class CreateAccountViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var displayNameTextField: UITextField!
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    @IBAction func addProfileImageButtonTapped(sender: AnyObject) {
        
        // present action sheet camera & library
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        
        let actionSheet = UIAlertController(title: "Choose Image", message: nil, preferredStyle: .ActionSheet)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel, handler: nil)
        
        let photoLibraryAction = UIAlertAction(title: "Photo Library", style: .Default) { (_) in
            imagePicker.sourceType = .PhotoLibrary
            self.presentViewController(imagePicker, animated: true, completion: nil)
        }
        
        let cameraAction = UIAlertAction(title: "camera", style: .Default) { (_) in
            imagePicker.sourceType = .Camera
            self.presentViewController(imagePicker, animated: true, completion: nil)
        }
        
        actionSheet.addAction(cancelAction)
        
        if UIImagePickerController.isSourceTypeAvailable(.Camera) {
            actionSheet.addAction(cameraAction)
        }
        
        if UIImagePickerController.isSourceTypeAvailable(.PhotoLibrary) {
            actionSheet.addAction(photoLibraryAction)
        }
        
        presentViewController(actionSheet, animated: true, completion: nil)
    }
    
    @IBAction func createAccountButtonTapped(sender: AnyObject) {
        
        if let displayNameTextField = displayNameTextField.text, firstNameTextField = firstNameTextField.text, lastNameTextField = lastNameTextField.text, email = emailTextField.text, password = passwordTextField.text {
            
            
            // Also need to create the user with the other saved information ****
            
            // be sure cannot create unless matching password **
            
            UserController.authUser(email, password: password, completion: { (user) in
                print(user)
                self.performSegueWithIdentifier("toHomeSegue", sender: self)
            })
        }
    
    }

    @IBAction func alreadyHaveAccountButtonTapped(sender: AnyObject) {
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        
        guard let image = info[UIImagePickerControllerOriginalImage] as? UIImage else {
            return
        }
        imageView.image = image
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func passwordVerify() {
        
        if passwordTextField.text == confirmPasswordTextField.text {
            // successful enter of matching password
        } else {
            // error - mistyped password characters
            
            // present alert
            passwordErrorAlert()
        }
    }
    
    func passwordErrorAlert() {
        
        let alertController = UIAlertController(title: "PASSWORD ERROR", message: "Please be sure your passsword matches exactly. /n Please try again", preferredStyle: .Alert)
        
        let dismissAction = UIAlertAction(title: "Ok", style: .Default, handler: nil)
        
        alertController.addAction(dismissAction)
        
        self.presentViewController(alertController, animated: true, completion: nil)
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
