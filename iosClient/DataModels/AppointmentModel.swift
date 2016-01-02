//
//  AppointmentModel.swift
//  iosClient
//
//  Created by Spencer Michaels on 1/1/16.
//  Copyright © 2016 Cameric. All rights reserved.
//

import Foundation

class Appointment {
    // MARK: Properties
    var type: String
    
    // AVCloud queries provide pointers for these two, which are basically wrapped IDs.
    // I think the IDs can just be represented as strings and stored here.
    var provider: String
    var client: String
   
    var startTime: NSDate
    var endTime: NSDate
    
    // MARK: Initialization
    init(type: String, provider: String, client: String, startTime: NSDate, endTime: NSDate) {
        self.type = type
        self.provider = provider
        self.client = client
        self.startTime = startTime
        self.endTime = endTime
    }
}