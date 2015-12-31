//
//  User.swift
//  ProjectKarma
//
//  Created by Spencer Michaels on 12/30/15.
//  Copyright © 2015 Cameric. All rights reserved.
//

import UIKit

class User {
    // MARK: Properties
    // MARK: Identity
    var username: String
    var name: String
    var email: String
    
    // MARK: Graphics
    // Note: The avatar is given as generic NSData; if you want to display it, convert to
    // a UIImage via UIImage(data: NSData)
    // TODO: Should this be an AVFile? I'm inclined to say "no" since that exposes AVOSCloud in the model
    var avatar: NSData?
    
    // MARK: Initialization
    init?(username: String, name: String, email: String, avatar: NSData?) {
        self.username = username
        self.name = name
        self.email = email
        
        self.avatar = avatar
        
        // Return nil if any values are invalid
        // This must be done AFTER the above are initialized
        if name.isEmpty {
            return nil
        } else if email.isEmpty {
            return nil
        } else if username.isEmpty {
            return nil
        }
    }
}