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
    // TODO: I presume an avatar can be "not set" in which case we'll use a default image.
    // What's the best way to handle that?
    var avatar: UIImage?
    
    // MARK: Initialization
    init(username: String, name: String, email: String, avatar: UIImage?) {
        self.username = username
        self.name = name
        self.email = email
        self.avatar = avatar
    }
}