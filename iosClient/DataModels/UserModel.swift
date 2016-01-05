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
    // MARK: Essentials
    // These are inherent to every user, must always have a value, and cannot be changed after signup
    var uid: String
    var username: String
    
    /**
        Instantiates a User with UID and username. (In the future, any properties that are set at signup
        and left unchanged afterward should be set here.)
    */
    init(uid: String, username: String) {
        self.uid = uid
        self.username = username
    }
    
    // MARK: Contact
    class ContactAddress {
        let address: String
        var isVerified: Bool
        
        init(address: String, isVerified: Bool = false) {
            self.address = address
            self.isVerified = isVerified
        }
    }
    /**
        A dictionary of the form [contact_method_name : ContactAddress], e.g. ["email" : "user@email.com"]
     */
    var contactInfo: [String: ContactAddress] = [:]
    
    // MARK: Public display data
    // This still needs a lot of work -- how should unset properties be represented (e.g. negative scores, or displaying username when no name is given)
    var name: String = ""
    var avatar: UIImage = UIImage()
    var summary: String = ""
    var score: Int = -1
    var category: [String] = []
    
    // MARK: Scheduling
    var appointmentsScheduled: [Appointment] = []
    var appointmentsProvided: [Appointment] = []
    
    // MARK: Personal preferences
    // Maybe move all these into a separate Preferences class if the list gets large
    var favorites: [User] = []
}