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
        static let basicInfoURL = " https://www.udacity.com/api/users"
        static let ApiPathStudentLocation = "/StudentLocation"
        
        //MARK:PARAMS
        static let WHERE = "where"
        //MARK:PAYLOAD KEYS
        static let KEY_ROOT_LOGIN = "udacity"
        static let KEY_LOGIN_USERNAME = "username"
        static let KEY_LOGIN_PASSWORD = "password"
        //MARK:RESPONSE KEYS
        static let KEY_ACCOUNT = "account"
        static let KEY_SESSION = "session"
        static let KEY_ID = "id"
        static let KEY_KEY = "key"
        static let KEY_RESULTS = "results"
        static let KEY_UNIQUE_KEY = "uniqueKey"
        static let KEY_FIRST_NAME = "firstName"
        static let KEY_LAST_NAME = "lastName"
        static let KEY_MEDIA_URL = "mediaURL"
        static let KEY_MAP_STRING = "mapString"
        static let KEY_LATITUDE = "latitude"
        static let KEY_LONGITUDE = "longitude"
        static let KEY_BASIC_INFO_ROOT = "user"
        static let KEY_BASIC_INFO_FIRST_NAME = "first_name"
        static let KEY_BASIC_INFO_LAST_NAME = "last_name"
    }
    
    //MARK : Methods
    struct Methods {
        static let StudentLocation = "/StudentLocation"
    }
    
}
