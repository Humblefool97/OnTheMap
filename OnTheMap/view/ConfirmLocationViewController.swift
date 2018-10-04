//
//  ConfirmLocationViewController.swift
//  OnTheMap
//
//  Created by Rajeev Ranganathan on 04/10/18.
//  Copyright © 2018 Rajeev Ranganathan. All rights reserved.
//

import UIKit
import Foundation
import MapKit

class ConfirmLocationViewController: UIViewController {

    @IBOutlet weak var confirmButton: UIButton!
    var selectedLocation:String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    fileprivate func initButton(){
        confirmButton.layer.cornerRadius = 10
        confirmButton.clipsToBounds = true
    }
    
    
    @IBAction func onConfirmClicked(_ sender: UIButton) {
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
