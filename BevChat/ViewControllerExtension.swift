//
//  ViewControllerExtension.swift
//  BevChat
//
//  Created by Ross McIlwaine on 6/30/16.
//  Copyright © 2016 Ross McIlwaine. All rights reserved.
//

import UIKit

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }
}
