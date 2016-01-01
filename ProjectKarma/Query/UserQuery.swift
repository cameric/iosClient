//
//  User.swift
//  ProjectKarma
//
//  Created by Spencer Michaels on 12/30/15.
//  Copyright © 2015 Cameric. All rights reserved.
//

import AVOSCloud

enum QueryError: ErrorType {
    // Response is not readable, e.g. because it's not of the expected type.
    case MalformedResponse
    
    // Response is readable, but missing some expected element
    case IncompleteResponse(missing: String)
}

/**
Convert the result of an AVQuery to a User object.

- parameter result: The query result.

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
    guard let avatar: AVFile = resultDict["avatar"] as? AVFile else {
        throw QueryError.IncompleteResponse(missing: "email")
    }
    
    return User(username: username, name: name, email: email, avatar: UIImage(data: avatar.getData()))
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