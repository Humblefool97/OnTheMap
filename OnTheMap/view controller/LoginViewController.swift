//
//  LoginViewController.swift
//  OnTheMap
//
//  Created by Rajeev Ranganathan on 19/08/18.
//  Copyright © 2018 Rajeev Ranganathan. All rights reserved.
//

import Foundation

class LoginViewController {
    
    
    
    
    
    class func instance() -> LoginViewController {
        struct Singleton {
            static let instance = LoginViewController()
        }
        return Singleton.instance
    }
}
