//
//  ImageManager.swift
//  BevChat
//
//  Created by Ross McIlwaine on 6/15/16.
//  Copyright © 2016 Ross McIlwaine. All rights reserved.
//

import UIKit

// MARK: - UIImage extension for saving and retrieving images
extension UIImage {
    var base64String: String? {
        guard let data = UIImageJPEGRepresentation(self, 0.8) else {
            return nil
        }
        
        return data.base64EncodedStringWithOptions(.EncodingEndLineWithCarriageReturn)
    }
    
    convenience init?(base64: String) {
        
        if let imageData = NSData(base64EncodedString: base64, options: .IgnoreUnknownCharacters) {
            self.init(data: imageData)
        } else {
            return nil
        }
    }
}
