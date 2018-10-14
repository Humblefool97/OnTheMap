//
//  NetworkController.swift
//  OnTheMap
//
//  Created by Rajeev Ranganathan on 19/08/18.
//  Copyright © 2018 Rajeev Ranganathan. All rights reserved.
//

import Foundation
import UIKit

class NetworkController:NSObject {
    // shared session
    var session = URLSession.shared
    enum httpMethods:String{
        case GET
        case POST
        case PUT
    }
    func  fireNetworkCall ( httpMethod       : httpMethods,
                            isAuthRequest    : Bool = false,
                            _ method         : String ,
                            parameters       : [String:AnyObject] = [:],
                            jsonObject       : [String:AnyObject]?,
                            isBasicInfoCall  : Bool = false,
                            userId           : String = "",
                            completionHandler: @escaping ( _ result: AnyObject?, _ error:NSError?) -> Void) -> Void {
        /* 1. Set the parameters */
        
        /* 2/3. Build the URL, Configure the request */
        var url:URL?
        if(isAuthRequest){
            url = URL(string: NetworkController.Constants.AuthorizationURL)
        }else if(isBasicInfoCall){
            url = URL(string: NetworkController.Constants.basicInfoURL+"/\(userId)")
        }else{
            url = getUrlFromParameters(parameters,withPathExtension: method)
        }
        let request = NSMutableURLRequest(url:url!)
        request.addValue(NetworkController.Constants.VALUE_CONTENT_TYPE, forHTTPHeaderField: NetworkController.Constants.CONTENT_TYPE)
        request.addValue(NetworkController.Constants.VALUE_API_KEY, forHTTPHeaderField: NetworkController.Constants.KEY_API_KEY)
        request.addValue(NetworkController.Constants.VALUE_APP_ID, forHTTPHeaderField: NetworkController.Constants.KEY_APP_ID)
        switch httpMethod {
        case httpMethods.GET:
            request.httpMethod = "GET"
        case httpMethods.POST:
            request.httpMethod = "POST"
        case httpMethods.PUT:
            request.httpMethod = "PUT"
        }
        if(httpMethod == httpMethods.POST || httpMethod == httpMethods.PUT){
            let jsonData = try? JSONSerialization.data(withJSONObject: jsonObject!, options:[])
            request.httpBody = jsonData
        }
        print(request)
        
        /* 4. Make the request */
        let task = session.dataTask(with: request as URLRequest){ data, response, error in
            
            func sendError(_ error:String){
                print(error)
                let errorInfo = [NSLocalizedDescriptionKey : error]
                completionHandler(nil , NSError(domain: "Networkcall", code: 1, userInfo: errorInfo))
            }
            
            /*Check if there was error*/
            guard (error == nil) else {
                sendError("There was an error with your request: \(error!)")
                return
            }
            /* GUARD: Did we get a successful 2XX response? */
            guard let statusCode = (response as? HTTPURLResponse)?.statusCode, statusCode >= 200 && statusCode <= 299 else {
                sendError("Your request returned a status code other than 2xx!")
                return
            }
            
            /* GUARD: Was there any data returned? */
            guard let data = data else {
                sendError("No data was returned by the request!")
                return
            }
            
            self.convertDataWithCompletionHandler(data,isAuthRequest: isAuthRequest,completionHandlerForConvertData: completionHandler,isBasicInfoCall: isBasicInfoCall)
        }
        
        /* 5. Start the task*/
        task.resume()
    }
    
    // given raw JSON, return a usable Foundation object
    private func convertDataWithCompletionHandler(_ data: Data,isAuthRequest:Bool,completionHandlerForConvertData: (_ result: AnyObject?, _ error: NSError?) -> Void,isBasicInfoCall:Bool = false) {
        var newData = data
        if(isAuthRequest || isBasicInfoCall){
            let range = Range(5..<data.count)
            newData = data.subdata(in: range)
        }
        var parsedResult: AnyObject! = nil
        do {
            parsedResult = try JSONSerialization.jsonObject(with: newData, options: .allowFragments) as AnyObject
        } catch {
            let userInfo = [NSLocalizedDescriptionKey : "Could not parse the data as JSON: '\(data)'"]
            completionHandlerForConvertData(nil, NSError(domain: "convertDataWithCompletionHandler", code: 1, userInfo: userInfo))
        }
        completionHandlerForConvertData(parsedResult, nil)
    }
    
    private func getUrlFromParameters (_ parameters: [String:AnyObject], withPathExtension:String? = nil) -> URL{
        var components = URLComponents()
        components.scheme = NetworkController.Constants.ApiScheme
        components.host = NetworkController.Constants.ApiHost
        components.path = NetworkController.Constants.ApiPath + (withPathExtension ?? "")
        components.queryItems = [URLQueryItem]()
        
        for (key , value) in parameters {
            let queryItem = URLQueryItem(name: key, value: "\(value)")
            components.queryItems?.append(queryItem)
        }
        return components.url!
    }
    
    func instance() -> NetworkController {
        struct Singleton {
            static let instance = NetworkController()
        }
        return Singleton.instance
    }
}


