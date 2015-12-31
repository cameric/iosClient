//
//  User.swift
//  ProjectKarma
//
//  Created by Spencer Michaels on 12/30/15.
//  Copyright © 2015 Cameric. All rights reserved.
//

import UIKit

class User {
    var name: String
    var email: String
    
    var avatar: UIImage?
    
    // MARK: Initialization
    init?(name: String, email: String, avatar: UIImage?) {
        self.name = name
        self.email = email
        self.avatar = avatar
        
        // Return nil if any values are invalid
        // This must be done AFTER the above are initialized
        if name.isEmpty {
            return nil
        } else if email.isEmpty {
            return nil
        }
    }
}