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
}
