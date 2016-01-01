//
//  Query.swift
//  ProjectKarma
//
//  Created by Spencer Michaels on 12/31/15.
//  Copyright © 2015 Cameric. All rights reserved.
//

import AVOSCloud

/**
Make a query to the server, parse the result, and pass it to a closure.

- parameter function: The query to call on the server.
- parameter params: The parameters for the query.
- parameter parser: A function that converts the server's response to the desired object
- parameter onCompletion: A closure called upon either success of the query or an error during it.
If the response to the query is parsed successfully, the resulting object is passed as the first
argument; if the query/parsing fails, the second argument will contain the error thrown by the
server/parser.
*/
func asyncQueryParseToObject<T>(
    query: String,
    params: [String : AnyObject]!,
    parser: (AnyObject! throws -> T),
    onCompletion: (T!, ErrorType!) -> Void)
    -> Void
{
    AVCloud.callFunctionInBackground(query, withParameters: params) { (result: AnyObject!, error: NSError!) -> Void in
        if error != nil {
            // If the server gives us an error, pass it along
            onCompletion(nil, error)
        } else {
            // If we got a response, convert it to type T. If conversion doesn't work out (e.g. because the
            // response had the wrong format), we pass the given error to onCompletion
            do {
                let object = try parser(result)
                onCompletion(object, nil)
            } catch let err {
                onCompletion(nil, err)
            }
            
        }
    }
}