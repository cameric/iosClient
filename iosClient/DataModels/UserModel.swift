//
//  User.swift
//  iosClient
//
//  Created by Spencer Michaels on 12/30/15.
//  Copyright © 2015 Cameric. All rights reserved.
//

import UIKit

class User {
    // MARK: Properties
    // MARK: Identity
    // Essential infomation
    var uid: String
    var category: [String] // TODO: maybe changed to custom type later
    var username: String
    var name: String
    var email: String
    var emailVerified: Bool
    
    // Supplementary information
    var summary: String
    var mobile: String
    var score: Int
    var isQualified: Bool
    // var type: AnyObject!
    
    // TODO: Favorite section
    var favorite: [User]
    
    // TODO: appointment section
    // var availableTimes: [NSDate]
    // var appointments: [Appointment] // ?
    
    // MARK: Graphics
    // TODO: I presume an avatar can be "not set" in which case we'll use a default image.
    // What's the best way to handle that?
    var avatar: UIImage?
    
    // MARK: Initialization
    init(uid: String, username: String, name: String, email: String) {
        self.uid = uid
        self.username = username
        self.name = name
        self.email = email
        
        // Currently, the initializer only initializes essential informations,
        // leaving all other fields default. This definitely needs to be changed
        // in the future, but so far we keep the initializer simple so that we 
        // can speed up the development process of core features.
        //  - Tony
        self.category = []
        self.emailVerified = false
        self.summary = ""
        self.mobile = ""
        self.score = 0
        self.isQualified = false
        self.favorite = []
    }
}