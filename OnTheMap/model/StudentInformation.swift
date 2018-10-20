//
//  StudentTags.swift
//  OnTheMap
//
//  Created by Rajeev Ranganathan on 04/09/18.
//  Copyright © 2018 Rajeev Ranganathan. All rights reserved.
//

import Foundation
import MapKit

/**
 *  Student POJO
 */
class StudentInformation {
    var objectId:String = ""
    var uniqueKey:String = ""
    var firstName:String = ""
    var lastName:String = ""
    var mapString:String = ""
    var mediaUrl:String = ""
    var latitude:Double = 0.0
    var longitude:Double = 0.0
    var coordinate:CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: 0.0, longitude: 0.0)
    var createdAt:Date = Date()
    var updatedAt:Date = Date()
    var hasValidInfo = false
    init(withDictionary dictionary:[String:Any]) {
        if let first =  dictionary[NetworkController.Constants.KEY_FIRST_NAME]{
            let firstNameAsString = (first as! String)
            if(firstNameAsString.isEmpty){
                return
            }
            firstName  = firstNameAsString
            hasValidInfo = true
        }
        
        if  let last = dictionary[NetworkController.Constants.KEY_LAST_NAME]{
            lastName = last as! String
            hasValidInfo = true
        }
        if let mediaURL = dictionary[NetworkController.Constants.KEY_MEDIA_URL]{
            mediaUrl = mediaURL as! String
            hasValidInfo = true
        }
        if let lat = (dictionary[NetworkController.Constants.KEY_LATITUDE]), let long = (dictionary[NetworkController.Constants.KEY_LONGITUDE]){
            let latInDouble: Double? = (lat as? Double) ?? nil
            let longInDouble: Double? = (long as? Double) ?? nil
            guard let latitude = latInDouble, let longitude = longInDouble else {
                return
            }
            let coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
            // The lat and long are used to create a CLLocationCoordinates2D instance.
            self.coordinate = coordinate
            hasValidInfo = true
        }
    }
}
