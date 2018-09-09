//
//  OTMClient.swift
//  OnTheMap
//
//  Created by Rajeev Ranganathan on 26/08/18.
//  Copyright © 2018 Rajeev Ranganathan. All rights reserved.
//

import Foundation
import MapKit

extension NetworkController {
    
    func login(userName:String , password:String, completionHandlerForSession: @escaping (_ success: Bool, _ sessionID: String?, _ accountKey:String?,_ errorString: String?) -> Void) -> Void {
        
        let jsonBody =  ["udacity":["username":userName,"password":password]]
        let _ = fireNetworkCall(isPost: true, isAuthRequest: true, "", jsonObject: jsonBody as [String : AnyObject]){(result, error) in
            /* 3. Send the desired value(s) to completion handler */
            if let error = error {
                print(error)
                completionHandlerForSession(false,nil,nil,error.description)
            } else {
                print(result as Any)
                let udacityObj = result as? [String:AnyObject]
                if (udacityObj != nil){
                    let account = udacityObj!["account"]
                    let session = udacityObj!["session"]
                    if let account = account , let session = session{
                        print ("sessionId:\(String(describing: session["id"] as? String))")
                        print(" accountKey : \(String(describing: account["key"] as? String))")
                        completionHandlerForSession(true,session["id"] as? String,account["key"] as? String,nil)
                    }
                }
            }
        }
    }
    
    func getStudents(completionHandlerForStudents : @escaping (_ success:Bool, _ studentTags:[StudentTags]?, _ errorString:String?) ->  Void) -> Void{
        
        let parameters:[String:Any] = ["limit":100]
        let _ = fireNetworkCall(isPost: false,isAuthRequest: false,"/StudentLocation",parameters: parameters as [String : AnyObject], jsonObject: nil){(result,error) in
            if let error = error {
                print(error)
                completionHandlerForStudents(false,nil,error.description)
            } else {
                print(result as Any)
                if let json = result as? [String:Any]{
                    if let locations = json["results"] as? [[String:Any]]{
                        // Notice that the float values are being used to create CLLocationDegree values.
                        // This is a version of the Double type.
                        var studentTags:[StudentTags] = [StudentTags]()
                        for dictionary in locations{
                            var isValidCell = false
                            let studentTag = StudentTags()
                            if let first =  dictionary["firstName"]{
                                let firstNameAsString = (first as! String)
                                if(firstNameAsString.isEmpty){
                                    continue
                                }
                                studentTag.firstName  = firstNameAsString
                                isValidCell = true
                            }
                            
                            if  let last = dictionary["lastName"]{
                                studentTag.lastName = last as! String
                                isValidCell = true
                            }
                            if let mediaURL = dictionary["mediaURL"]{
                                studentTag.mediaUrl = mediaURL as! String
                                isValidCell = true
                            }
                            
                            if let lat = (dictionary["latitude"]), let long = (dictionary["longitude"]){
                                let latInDouble = lat as! Double
                                let longInDouble = long as! Double
                                
                                let coordinate = CLLocationCoordinate2D(latitude: latInDouble, longitude: longInDouble)
                                // The lat and long are used to create a CLLocationCoordinates2D instance.
                                studentTag.coordinate = coordinate
                                isValidCell = true
                            }
                            if(isValidCell){
                                studentTags.append(studentTag)
                            }
                        }
                        completionHandlerForStudents(true, studentTags, nil)
                    }
                }
            }
        }
        
    }
}
