//
//  User.swift
//  iosClient
//
//  Created by Spencer Michaels on 12/30/15.
//  Copyright © 2015 Cameric. All rights reserved.
//

import AVOSCloud

/**
Convert the result of an AVQuery to a User object.

- parameter result: A query result.

- returns: A User object based on information in the query
 
- throws: QueryError
*/
func userFromQueryResult(result: AnyObject!) throws -> User {
    // The response from the server should be in the form of [String: AnyObject].
    // If it isn't, the data retrieved is considered malformed.
    guard let resultDict = result as? [String: AnyObject] else {
        throw QueryError.MalformedResponse
    }
    
    // Try to get each of the necessary properties from the response. Return nil if any one does not
    // exist or is not convertible to the expected type, which would render the user info invalid
    guard let uid: String = resultDict["objectId"] as? String else {
        throw QueryError.IncompleteResponse(missing: "objectId")
    }
    guard let username: String = resultDict["username"] as? String else {
        throw QueryError.IncompleteResponse(missing: "username")
    }
    guard let name: String = resultDict["name"] as? String else {
        throw QueryError.IncompleteResponse(missing: "name")
    }
    guard let email: String = resultDict["email"] as? String else {
        throw QueryError.IncompleteResponse(missing: "email")
    }
    
    // TODO: A user's avatar can probably be nil (not set), so maybe we shouldn't consider the user invalid if it's nil...
//    guard let avatar: AVFile = resultDict["avatar"] as? AVFile else {
//        throw QueryError.IncompleteResponse(missing: "avatar")
//    }
    
    return User(
        uid: uid,
        username: username,
        name: name,
        email: email)
}

/**
 Construct a user object if he/she has logged in

 - returns: a formulated user object if the corresponding user session 
     can be found from LeanCloud server. 
        Return nil if the user hasn't logged in yet
 
 Note that guard is not used here because currentUser() is guaranteed to 
 return a dictionary that includes the corrsponding keys
*/
func getCurrentUserIfLoggedIn() -> User? {
    if let curUser = AVUser.currentUser() {
        return User(
            uid: curUser["objectId"] as! String,
            username: curUser["username"] as! String,
            name: curUser["name"] as! String,
            email: curUser["email"] as! String)
    }
    return nil
}

/**
 Get truncated user info according to a UID

 - parameter id: The target UID.
 - parameter onCompletion: A closure called upon either success of the query or an error during it.
 
 - returns: A shortened version of user info, including only necessary information.
        Returns nil if the given UID does not match any existing user.
*/
func getUserShortById(id: String, onCompletion: (User!, ErrorType!) -> Void) -> Void {
    // Set up parameters to be used in the query
    // Make sure the dictionary keys are EXACTLY those defined in the JS functions on the server
    let params = [
        "id" : id
    ]
    
    asyncQueryParseToObject("getUserShortById", params: params, parser: userFromQueryResult, onCompletion: onCompletion)
}