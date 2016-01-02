//
//  AppointmentQuery.swift
//  iosClient
//
//  Created by Spencer Michaels on 1/1/16.
//  Copyright © 2016 Cameric. All rights reserved.
//

import Foundation

/**
 Convert the result of an AVQuery to an Appointment object.
 
 - parameter result: A query result.
 
 - returns: A User object based on information in the query
 
 - throws: QueryError
 */
func appointmentFromQueryResult(result: AnyObject!) throws -> Appointment {
    guard let resultDict = result as? [String: AnyObject] else {
        throw QueryError.MalformedResponse
    }
    
    guard let type: String = resultDict["type"] as? String else {
        throw QueryError.IncompleteResponse(missing: "type")
    }
    guard let provider: String = resultDict["provider"] as? String else {
        throw QueryError.IncompleteResponse(missing: "provider")
    }
    guard let client: String = resultDict["client"] as? String else {
        throw QueryError.IncompleteResponse(missing: "client")
    }
    guard let startTime: String = resultDict["startTime"] as? String else {
        throw QueryError.IncompleteResponse(missing: "startTime")
    }
    guard let endTime: String = resultDict["endTime"] as? String else {
        throw QueryError.IncompleteResponse(missing: "endTime")
    }
    
    // We need to convert the times from strings to proper NSDate instances
    let formatter = NSDateFormatter()
    formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'" // TODO move elsewhere as constant
    
    return Appointment(
        type: type,
        provider: provider,
        client: client,
        startTime: formatter.dateFromString(startTime)!,
        endTime: formatter.dateFromString(endTime)!)
}

/**
    Gets all appointments within a certain time range, filtering on either
client, provider, or both.
 
 - parameter client: The ID of the user receiving the service. If nil, it is
    not used as a search criterion (in this case provider MUST be non-nil).
 - parameter provider: The ID of the user providing the service. If nil, it is
    not used as a search criterion (in this case client MUST be non-nil).
 - parameter fromTime: The start of the time range. Appointments that
    start before this time are ignored.
 - parameter toTime: The end of the time range. Appointments that
    start after this time are ignored.
 - parameter onCompletion: A closure called upon either success of the query or an error during it.
 
 - returns: A shortened version of user info, including only necessary information.
 Returns nil if the given UID does not match any existing user.
 */
func getAppointmentsInRange(
    client: String!,
    provider: String!,
    fromTime: NSDate,
    toTime: NSDate,
    onCompletion: ([Appointment]!, ErrorType!) -> Void)
    -> Void
{
    let params = [
        "client": client,
        "provider": provider,
        "fromTime": fromTime,
        "toTime": toTime
    ]
    
    asyncQueryParseToObject(
        "getAppointmentsInRange",
        params: params,
        parser: { (result: AnyObject!) in
            return try listFromQueryResult(result, elemParser: appointmentFromQueryResult) },
        onCompletion: onCompletion)
}