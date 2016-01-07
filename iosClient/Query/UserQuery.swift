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
     Get truncated user info according to a UID

     - parameter id: The target UID.
     - parameter onCompletion: A closure called upon either success of the query or an error during it.
     
     - returns: A shortened version of user info, including only necessary information.
        Returns nil if the given UID does not match any existing user.
    */
    static func getUserShortById(id: String, success: AVUser -> Void, failure: ErrorType -> Void) {
        // Set up parameters to be used in the query
        // Make sure the dictionary keys are EXACTLY those defined in the JS functions on the server
        let params = [
            "id" : id
        ]
        
        AVCloud.callFunctionInBackground("getUserShortById", withParameters: params) { (result: AnyObject!, error: NSError!) -> Void in
            if error != nil {
                failure(error)
            } else {
                do {
                    let user: AVUser = try QueryUtils.avObjectFromQueryResult(result)
                    success(user)
                } catch {
                    failure(QueryError.MalformedResponse)
                }
            }
        }

    }

    /**
     Gets a list of users (short format) matching the given keyword
     
     - parameter id: The keyword to search
     - parameter onCompletion: A closure called upon either success of the query or an error during it.
     
     - returns: A list of users (short format) matching the given keyword
     */
    static func getUsersShortByKeyword(keyword: String, success: [AVUser] -> Void, failure: ErrorType -> Void) {
        // Set up parameters to be used in the query
        // Make sure the dictionary keys are EXACTLY those defined in the JS functions on the server
        let params = [
            "keyword" : keyword
        ]
        
        AVCloud.callFunctionInBackground("getUsersShortByKeyword", withParameters: params) { (result: AnyObject!, error: NSError!) in
            if error != nil {
                failure(error)
            } else {
                do {
                    let userList: [AVUser] = try QueryUtils.listFromQueryResult(result, elemParser: QueryUtils.avObjectFromQueryResult)
                    success(userList)
                } catch {
                    failure(QueryError.MalformedResponse)
                }
            }
        }
    }
    
    /**
     Use cloud function to signup using Sina Weibo
     
     - parameter uid: the target UID
     - parameter accessToken: Sina specified Weibo access token (effective for 36000s)
     - parameter onCompletion: A closure called upon either success of the query or an error during it.

     - return: a user object using the information given by Weibo API
    */
    static func signUpWithWeibo(uid: String, accessToken: String, success: AVUser -> Void, failure: ErrorType -> Void) {
        let params = [
            "uid": uid,
            "accessToken": accessToken
        ]
        
        AVCloud.callFunctionInBackground("signUpWithWeibo", withParameters: params) { (result: AnyObject!, error: NSError!) -> Void in
            if error != nil {
                // If the server gives us an error, pass it along
                failure(error)
            } else {
                do {
                    let user: AVUser = try QueryUtils.avObjectFromQueryResult(result)
                    success(user)
                } catch {
                    failure(QueryError.MalformedResponse)
                }
            }
        }
    }
}