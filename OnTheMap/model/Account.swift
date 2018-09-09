//
//  Account.swift
//  OnTheMap
//
//  Created by Rajeev Ranganathan on 02/09/18.
//  Copyright © 2018 Rajeev Ranganathan. All rights reserved.
//

import Foundation

class Account {
    var registered:Bool
    var key:String = ""
    
     public init(_ isRegistered:Bool , _ accountKey:String) {
        registered = isRegistered
        key = accountKey
    }
    
}
