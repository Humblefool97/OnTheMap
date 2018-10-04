//
//  AddLocationViewController.swift
//  OnTheMap
//
//  Created by Rajeev Ranganathan on 04/10/18.
//  Copyright © 2018 Rajeev Ranganathan. All rights reserved.
//

import UIKit

class AddLocationViewController: UIViewController {
    
    
    @IBOutlet weak var submitButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        initButton()
    }
    
    @IBAction func onSubmitClickef(_ sender: UIButton) {
    }
    @IBAction func onCancelClicked(_ sender: Any) {
        self.dismiss(animated: true, completion:nil)
        //  self.navigationController?.popViewController(animated: true)
    }
    fileprivate func initButton(){
        submitButton.layer.cornerRadius = 10
        submitButton.clipsToBounds = true
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
