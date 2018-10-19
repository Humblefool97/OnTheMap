//
//  DataCompletionListener.swift
//  OnTheMap
//
//  Created by Rajeev Ranganathan on 23/09/18.
//  Copyright © 2018 Rajeev Ranganathan. All rights reserved.
//

import Foundation
/**
 *  Contract to send the data to VC
 */
protocol DataCompletionListener {
    func onDataLoadSuccess(studentList:[StudentInformation]?)
    func onDataLoadFailure(errorString:String?)
}
