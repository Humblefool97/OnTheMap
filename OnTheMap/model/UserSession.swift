//
//  UserSession.swift
//  OnTheMap
//
//  Created by Rajeev Ranganathan on 02/09/18.
//  Copyright © 2018 Rajeev Ranganathan. All rights reserved.
//

import Foundation

class UserSession {
    public var accountKey:String? = ""
    public var sessionId:String? = ""
    public static let instance = UserSession()
    private init () {}
}
