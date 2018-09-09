//
//  NetworkConstants.swift
//  OnTheMap
//
//  Created by Rajeev Ranganathan on 19/08/18.
//  Copyright © 2018 Rajeev Ranganathan. All rights reserved.
//

import Foundation

extension NetworkController {
    
    // MARK: Constants
    struct Constants {
        
        //MARK:HEADER KEYS
        static let ACCEPT = "Accept"
        static let CONTENT_TYPE = "Content-Type"
        static let KEY_APP_ID = "X-Parse-Application-Id"
        static let KEY_API_KEY = "X-Parse-REST-API-Key"
        
        // MAR:HEADER Values
        static let VALUE_ACCEPT = "application/json"
        static let VALUE_CONTENT_TYPE = "application/json"
        static let VALUE_APP_ID = "QrX47CA9cyuGewLdsL7o5Eb8iug6Em8ye0dnAbIr"
        static let VALUE_API_KEY = "QuWThTdiRmTux3YaDseUSEpUKo7aBYM737yKd4gY"
        
        // MARK: URLs
        static let ApiScheme = "https"
        static let ApiHost = "parse.udacity.com"
        static let ApiPath = "/parse/classes"
        static let AuthorizationURL = "https://www.udacity.com/api/session"
    }
    
    //MARK : Methods
    struct Methods {
        static let StudentLocation = "/StudentLocation"
    }
    
}
