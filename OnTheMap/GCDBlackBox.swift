//
//  GCDBlackBox.swift
//  OnTheMap
//
//  Created by Rajeev Ranganathan on 19/08/18.
//  Copyright © 2018 Rajeev Ranganathan. All rights reserved.
//

import Foundation

func performUIUpdatesOnMain (_ updates: @escaping () -> Void){
    DispatchQueue.main.async {
        updates()
    }
}
