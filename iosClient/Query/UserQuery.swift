//
//  UserQuery.swift
//  iosClient
//
//  Created by Spencer Michaels on 12/30/15.
//  Copyright © 2015 Cameric. All rights reserved.
//

import AVOSCloud

class UserQueryServices {

    /**
    Convert the result of an AVQuery to a User object.

    - parameter result: A query result.

    - returns: A User object based on information in the query
     
    - throws: QueryError
    */
    static func userFromQueryResult(result: AnyObject!) throws -> User {
        // The response from the server should be in the form of [String: AnyObject].
        // If it isn't, the data retrieved is considered malformed.    
        guard let user = result as? User else {
            throw QueryError.MalformedResponse
        }

        return user
    }

    /**
     Construct a user object if he/she has logged in

     - returns: a formulated user object if the corresponding user session 
         can be found from LeanCloud server. 
            Return nil if the user hasn't logged in yet
     
     Note that guard is not used here because currentUser() is guaranteed to 
     return a dictionary that includes the corrsponding keys
    */
    static func getCurrentUserIfLoggedIn() -> User? {
        guard let curUser = User.currentUser() else {
            return nil
        }
        return curUser
    }

    /**
     Get truncated user info according to a UID

     - parameter id: The target UID.
     - parameter onCompletion: A closure called upon either success of the query or an error during it.
     
     - returns: A shortened version of user info, including only necessary information.
            Returns nil if the given UID does not match any existing user.
    */
    static func getUserShortById(id: String, onCompletion: (User!, ErrorType!) -> Void) -> Void {
        // Set up parameters to be used in the query
        // Make sure the dictionary keys are EXACTLY those defined in the JS functions on the server
        let params = [
            "id" : id
        ]
        
        QueryUtils.asyncQueryParseToObject("getUserShortById", params: params, parser: userFromQueryResult, onCompletion: onCompletion)
    }
    
    /**
     Use cloud function to signup using Sina Weibo
     
     - parameter uid: the target UID
     - parameter accessToken: Sina specified Weibo access token (effective for 36000s)
     - parameter onCompletion: A closure called upon either success of the query or an error during it.

     - return: a user object using the information given by Weibo API
    */
    static func signUpWithWeibo(uid: String, accessToken: String, onCompletion: (User!, ErrorType!) -> Void) -> Void {
        let params = [
            "uid": uid,
            "accessToken": accessToken
        ]
        
        QueryUtils.asyncQueryParseToObject("signUpWithWeibo", params: params, parser: userFromQueryResult, onCompletion: onCompletion)
    }
}