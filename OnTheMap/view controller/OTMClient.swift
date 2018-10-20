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
        
        let jsonBody =  [Constants.KEY_ROOT_LOGIN:[Constants.KEY_LOGIN_USERNAME:userName,
                                                   Constants.KEY_LOGIN_PASSWORD:password]]
        let _ = fireNetworkCall(httpMethod:httpMethods.POST, isAuthRequest: true, "", jsonObject: jsonBody as [String : AnyObject]){(result, error) in
            /* 3. Send the desired value(s) to completion handler */
            if let error = error {
                print(error)
                completionHandlerForSession(false,nil,nil,error.localizedDescription)
            } else {
                print(result as Any)
                let udacityObj = result as? [String:AnyObject]
                if (udacityObj != nil){
                    let account = udacityObj![Constants.KEY_ACCOUNT]
                    let session = udacityObj![Constants.KEY_SESSION]
                    if let account = account , let session = session{
                        print ("sessionId:\(String(describing: session["id"] as? String))")
                        print(" accountKey : \(String(describing: account["key"] as? String))")
                        completionHandlerForSession(true,session[Constants.KEY_ID] as? String,account[Constants.KEY_KEY] as? String,nil)
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
        _ studentTags:[StudentInformation]?,
        _ errorString:String?) ->  Void) -> Void{
        
        let parameters:[String:Any] = ["limit":100,"order":"updatedAt"]
        let _ = fireNetworkCall(httpMethod:httpMethods.GET,isAuthRequest: false,Constants.ApiPathStudentLocation,parameters: parameters as [String : AnyObject], jsonObject: nil){(result,error) in
            if let error = error {
                print(error)
                completionHandlerForStudents(false,nil,error.description)
            } else {
                print(result as Any)
                if let json = result as? [String:Any]{
                    if let locations = json[Constants.KEY_RESULTS] as? [[String:Any]]{
                        var studentTags:[StudentInformation] = [StudentInformation]()
                        for dictionary in locations{
                            let studentTag = StudentInformation(withDictionary: dictionary)
                            if(studentTag.hasValidInfo){
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
        _ studentInfo:StudentInformation?,
        _ errorString:String?) ->  Void) -> Void{
         
        let paramter = [NetworkController.Constants.WHERE:"{\"uniqueKey\":\"\(uniqueKey)\"}"]
        let _ = fireNetworkCall(httpMethod:httpMethods.GET, isAuthRequest: false, "/StudentLocation", parameters: paramter as [String:AnyObject], jsonObject: nil){
            (result,error) in
            if let error = error {
                completionHandlerForStudent(false,false,nil,error.description)
            }else{
                if let json = result as? [String:Any]{
                    if let studentList = json[Constants.KEY_RESULTS] as? [[String:Any]], studentList[0].isEmpty == false{
                        completionHandlerForStudent(true,true,self.processDictionary(studentList: studentList),"")
                    }else{
                        completionHandlerForStudent(true,false,nil,"")
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
        _ studentInfo:StudentInformation?,
        _ errorString:String?) ->  Void){
        let _ = fireNetworkCall(httpMethod: httpMethods.GET, isAuthRequest: false,"", parameters: [:], jsonObject: nil, isBasicInfoCall:true, userId: userId){
            (result, error) in
            if let error = error {
                completionHandlerForStudent(false,nil,error.description)
            }else{
                if let json = result as? [String:Any]{
                    if let studentInfo = json[Constants.KEY_BASIC_INFO_ROOT] as? [String:Any]{
                        let student = StudentInformation(withDictionary: studentInfo)
                        completionHandlerForStudent(true,student,nil)
                    }
                }
            }
        }
    }
    /**
     *  Post student location
     *
     */
    func postStudentLocation(studentInfo:StudentInformation, completionHandlerForStudent : @escaping(
        _ success:Bool,
        _ errorString:String?) ->  Void){
        
        let jsonBody =  [Constants.KEY_UNIQUE_KEY:studentInfo.uniqueKey,
                         Constants.KEY_FIRST_NAME:studentInfo.firstName,
                         Constants.KEY_LAST_NAME: studentInfo.lastName,
                         Constants.KEY_MAP_STRING: studentInfo.mapString,
                         Constants.KEY_MEDIA_URL:studentInfo.mediaUrl,
                         Constants.KEY_LATITUDE:studentInfo.latitude,
                         Constants.KEY_LONGITUDE:studentInfo.longitude] as [String : Any]
        let _ = fireNetworkCall(httpMethod: httpMethods.POST, isAuthRequest: false, Constants.ApiPathStudentLocation, parameters: [:], jsonObject: jsonBody as [String : AnyObject], isBasicInfoCall: false, userId: ""){
            (result,error) in
            if let error = error {
                completionHandlerForStudent(false,error.description)
            }else{
                completionHandlerForStudent(true,nil)
            }
        }
        
    }
    /*
     *  Convert String response to an Object
     *
     */
    private func processDictionary(studentList:[[String:Any]])-> StudentInformation{
       return StudentInformation(withDictionary: studentList[0])
    }
    
}
