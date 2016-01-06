//
//  User.swift
//  iosClient
//
//  Created by Spencer Michaels on 12/30/15.
//  Copyright © 2015 Cameric. All rights reserved.
//

import AVOSCloud
import UIKit

class User : AVUser {
    // MARK: Properties
    
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
    
    // Should this store UIDs instead?
    var favorites: [String] = []
    
    /**
     A dictionary of the form [contact_method_name : contact_address], e.g. ["Work Email" : "user@email.com"]
     */
    var contactInfo: [String: String] = [:]
    
}