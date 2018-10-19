//
//  UserSession.swift
//  OnTheMap
//
//  Created by Rajeev Ranganathan on 02/09/18.
//  Copyright © 2018 Rajeev Ranganathan. All rights reserved.
//

import Foundation

/**
 * POJO which has information related to accountKey,
 * Info of the user currently logged in,etc..
 */
class UserSession {
    public var accountKey:String? = ""
    public var sessionId:String? = ""
    public var doesUserExist:Bool = false
    public var studentInfo:StudentInformation = StudentInformation()
    public static let instance = UserSession()
    private init () {}
}
