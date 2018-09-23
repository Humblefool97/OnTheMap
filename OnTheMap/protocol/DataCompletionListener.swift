//
//  DataCompletionListener.swift
//  OnTheMap
//
//  Created by Rajeev Ranganathan on 23/09/18.
//  Copyright © 2018 Rajeev Ranganathan. All rights reserved.
//

import Foundation
protocol DataCompletionListener {
    func onDataLoadSuccess(studentList:[StudentTags]?)
    func onDataLoadFailure(errorString:String?)
}
