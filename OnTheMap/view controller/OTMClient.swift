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
    /**
     * Login using username & passowrd
     *
     */
    func login(
        userName:String,
        password:String,
        completionHandlerForSession: @escaping (_ success: Bool, _ sessionID: String?, _ accountKey:String?,
        _ errorString: String?) -> Void) -> Void {
        
        let jsonBody =  ["udacity":["username":userName,"password":password]]
        let _ = fireNetworkCall(httpMethod:httpMethods.POST, isAuthRequest: true, "", jsonObject: jsonBody as [String : AnyObject]){(result, error) in
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
    /**
     * Gets list of students
     *
     */
    func getStudents(
        completionHandlerForStudents : @escaping (_ success:Bool,
        _ studentTags:[StudentTags]?,
        _ errorString:String?) ->  Void) -> Void{
        
        let parameters:[String:Any] = [:]
        let _ = fireNetworkCall(httpMethod:httpMethods.GET,isAuthRequest: false,"/StudentLocation",parameters: parameters as [String : AnyObject], jsonObject: nil){(result,error) in
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
    
    /**
     * Checks if the student's location has already
     *  been logged or not
     *
     */
    func doesRecordExists(
        uniqueKey:String,
        completionHandlerForStudent : @escaping (_ success:Bool,
        _ isLocationExists:Bool,
        _ studentInfo:StudentTags?,
        _ errorString:String?) ->  Void) -> Void{
        
        let paramter = [NetworkController.Constants.WHERE:"{\"uniqueKey\":\"\(uniqueKey)\"}"]
        let _ = fireNetworkCall(httpMethod:httpMethods.GET, isAuthRequest: false, "/StudentLocation", parameters: paramter as [String:AnyObject], jsonObject: nil){
            (result,error) in
            if let error = error {
                completionHandlerForStudent(false,false,nil,error.description)
            }else{
                if let json = result as? [String:Any]{
                    if let studentList = json["results"] as? [[String:Any]]{
                        completionHandlerForStudent(true,!studentList.isEmpty,self.processDictionary(studentList: studentList),"")
                    }
                }
            }
        }
    }
    
    /**
     * Gets basic information from the student
     *
     */
    func getBasicInformation(userId:String,
                             completionHandlerForStudent : @escaping(
        _ success:Bool,
        _ studentInfo:StudentTags?,
        _ errorString:String?) ->  Void){
        let _ = fireNetworkCall(httpMethod: httpMethods.GET, isAuthRequest: false,"", parameters: [:], jsonObject: nil, isBasicInfoCall:true, userId: userId){
            (result, error) in
            if let error = error {
                completionHandlerForStudent(false,nil,error.description)
            }else{
                if let json = result as? [String:Any]{
                    if let studentInfo = json["user"] as? [String:Any]{
                        let student = StudentTags()
                        student.firstName = studentInfo["first_name"] as! String
                        student.lastName = studentInfo["last_info"] as! String
                        completionHandlerForStudent(true,student,nil)
                    }
                }
            }
        }
    }
    
    func postStudentLocation(studentInfo:StudentTags, completionHandlerForStudent : @escaping(
        _ success:Bool,
        _ errorString:String?) ->  Void){
        
        let jsonBody =  ["uniqueKey":studentInfo.uniqueKey,
                         "firstName":studentInfo.firstName,
                         "lastname": studentInfo.lastName,
                         "mapString": studentInfo.mapString,
                         "mediaURL":studentInfo.mediaUrl,
                         "latitude":studentInfo.latitude,
                         "longitude":studentInfo.longitude] as [String : Any]
        let _ = fireNetworkCall(httpMethod: httpMethods.POST, isAuthRequest: false, "/StudentLocation", parameters: [:], jsonObject: jsonBody as [String : AnyObject], isBasicInfoCall: false, userId: ""){
            (result,error) in
            if let error = error {
                completionHandlerForStudent(false,error.description)
            }else{
                completionHandlerForStudent(true,nil)
            }
        }
        
    }
    
    private func processDictionary(studentList:[[String:Any]])-> StudentTags{
        let studentTag = StudentTags()
        for dictionary in studentList{
            if let first =  dictionary["firstName"]{
                let firstNameAsString = (first as! String)
                if(firstNameAsString.isEmpty){
                    continue
                }
                studentTag.firstName  = firstNameAsString
            }
            
            if  let last = dictionary["lastName"]{
                studentTag.lastName = last as! String
            }
            if let mediaURL = dictionary["mediaURL"]{
                studentTag.mediaUrl = mediaURL as! String
            }
            if let lat = (dictionary["latitude"]), let long = (dictionary["longitude"]){
                let latInDouble = lat as! Double
                let longInDouble = long as! Double
                
                let coordinate = CLLocationCoordinate2D(latitude: latInDouble, longitude: longInDouble)
                // The lat and long are used to create a CLLocationCoordinates2D instance.
                studentTag.coordinate = coordinate
            }
        }
        return studentTag
    }
    
}
