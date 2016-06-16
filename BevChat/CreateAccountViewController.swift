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
        
        imageSelectionAlert()
    }
    
    @IBAction func createAccountButtonTapped(sender: AnyObject) {
        
        textFieldVerifyForTextEntry()
        
        if let displayNameTextField = displayNameTextField.text, firstNameTextField = firstNameTextField.text, lastNameTextField = lastNameTextField.text, email = emailTextField.text, password = passwordTextField.text, profileImageView = UIImage.init(base64: "") {
            
            // call create user (create user authenticates) ****
            
            UserController.createUser(firstNameTextField, lastName: lastNameTextField, displayName: displayNameTextField, profilePhoto: profileImageView, email: email, password: password, completion: { (user) in
                
                self.performSegueWithIdentifier("toHomeSegue", sender: self)
            })
        }
    }

    @IBAction func alreadyHaveAccountButtonTapped(sender: AnyObject) {
        
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    // MARK: - Image Selection Controller
    
    func imageSelectionAlert() {
        
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
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        
        guard let image = info[UIImagePickerControllerOriginalImage] as? UIImage else {
            return
        }
        profileImageView.image = image
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    // MARK: - Textfield entry Logic Tests
    
    func textFieldVerifyForTextEntry() {
        
        if displayNameTextField.text == nil || firstNameTextField.text == nil || lastNameTextField.text == nil || emailTextField.text == nil || passwordTextField.text == nil || confirmPasswordTextField.text == nil {
            // did not enter text into all fields
            emptyTextFieldErrorAlert()
        } else if isValidEmail("\(emailTextField.text)") == false {
            // not a valid email entered
            emailErrorAlert()
        } else if containsOnlyLettersAndNumbers("\(displayNameTextField.text)") == false {
            // not a valid display name
            displayNameContainsSpecialCharactersErrorAlert()
        } else if isValidDisplayNameAvailible("\(displayNameTextField.text)") == false {
            // display name is taken
            displayNameTakenErrorAlert()
        } else if passwordVerify(passwordTextField.text!, testString2: confirmPasswordTextField.text!) == false { // FORCE UNWRAP - the textfield exists
            passwordErrorAlert()
        }
    }
    
    func isValidDisplayNameAvailible(testString: String) -> Bool {
        
        // check it is availible
        // check it is xMin characters
        
        return true
    }
    
    func containsOnlyLettersAndNumbers(input: String) -> Bool {
        for chr in input.characters {
            if (!(chr >= "a" && chr <= "z") && !(chr >= "A" && chr <= "Z") && !(chr >= "0" && chr <= "9")) {
                return false
            }
        }
        // Valid with only letters and numbers
        return true
    }
    
    func isValidEmail(testString:String) -> Bool {
        // print("validate calendar: \(testStr)")
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluateWithObject(testString)
    }
    
    func passwordVerify(testString1: String, testString2: String) -> Bool {
        
        if testString1 == testString2 {
            // successful enter of matching password
            return true
        } else {
            // error - mistyped password characters
            return false
        }
    }
    
    // MARK: - Alert Controllers
    
    func emptyTextFieldErrorAlert() {
        
        let alertController = UIAlertController(title: "ERROR", message: "Please be sure you complete all TextFields. /n Please try again", preferredStyle: .Alert)
        
        let dismissAction = UIAlertAction(title: "Ok", style: .Default, handler: nil)
        
        alertController.addAction(dismissAction)
        
        self.presentViewController(alertController, animated: true, completion: nil)
    }
    
    func displayNameTakenErrorAlert() {
        
        let alertController = UIAlertController(title: "DISPLAY NAME ERROR", message: "This display name is already taken, please try another name. /n Please try again", preferredStyle: .Alert)
        
        let dismissAction = UIAlertAction(title: "Ok", style: .Default, handler: nil)
        
        alertController.addAction(dismissAction)
        
        self.presentViewController(alertController, animated: true, completion: nil)
    }
    
    func displayNameContainsSpecialCharactersErrorAlert() {
        
        let alertController = UIAlertController(title: "DISPLAY NAME ERROR", message: "The display name cannot contain special characters. /n Please try again with letters and numbers", preferredStyle: .Alert)
        
        let dismissAction = UIAlertAction(title: "Ok", style: .Default, handler: nil)
        
        alertController.addAction(dismissAction)
        
        self.presentViewController(alertController, animated: true, completion: nil)
    }
    
    func emailErrorAlert() {
        
        let alertController = UIAlertController(title: "EMAIL ERROR", message: "Please be sure you enter a valid email address. /n Please try again", preferredStyle: .Alert)
        
        let dismissAction = UIAlertAction(title: "Ok", style: .Default, handler: nil)
        
        alertController.addAction(dismissAction)
        
        self.presentViewController(alertController, animated: true, completion: nil)
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
