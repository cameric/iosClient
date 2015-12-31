//
//  User.swift
//  ProjectKarma
//
//  Created by Spencer Michaels on 12/30/15.
//  Copyright © 2015 Cameric. All rights reserved.
//

import AVOSCloud

// See here: https://leancloud.cn/api-docs/iOS/Classes/AVCloud.html

/**
 Get truncated user info according to a UID

 - parameter id: The target UID.
 
 - returns: A shortened version of user info, including only necessary information.
        Returns nil if the given UID does not match any existing user.
*/
// NOTE: This query is NOT asynchronous. I'm working on that -- 
func getUserShortById(id: String) -> User? {
    // Set up parameters for the query
    let params = [
        "id" : id
    ]
    
    // Perform the query. If we get a return value, process it; otherwise, return nil
    if let result = AVCloud.callFunction("getUserShortById", withParameters: params) {
        // TODO: How should I handle the possible nonexistence of these fields? Throw an exception, probably.
        let username: String = result["username"] as! String
        let name: String = result["name"] as! String
        let email: String = result["email"] as! String
        let avatar: AVFile = result["avatar"] as! AVFile
        
        return User(username: username, name: name, email: email, avatar: avatar.getData())
    } else {
        return nil
    }
}