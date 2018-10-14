//
//  AddLocationViewController.swift
//  OnTheMap
//
//  Created by Rajeev Ranganathan on 04/10/18.
//  Copyright © 2018 Rajeev Ranganathan. All rights reserved.
//

import UIKit

class AddLocationViewController: UIViewController {
    
    @IBOutlet weak var locationTextField: UITextField!
    
    @IBOutlet weak var mediaTextField: UITextField!
    @IBOutlet weak var submitButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initButton()
    }
    
    @IBAction func onSubmitClickef(_ sender: UIButton) {
        if((locationTextField.text?.isEmpty)! && (mediaTextField.text?.isEmpty)!){
            displayErrorMessage("Please enter location & media url")
        }else if (locationTextField.text?.isEmpty)!{
            displayErrorMessage("Please enter location")
        }else if (mediaTextField.text?.isEmpty)!{
            displayErrorMessage("Enter media url")
        }else{
            if(!(mediaTextField?.text)!.starts(with: "http://")){
                displayErrorMessage("url should start with http://")
            }else{
                presentConfirmLocationVc((mediaTextField?.text)!,(locationTextField?.text)!)
            }
        }
    }
    
    private func presentConfirmLocationVc(_ mediaUrl:String ,
                                          _ location:String){
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        if let confirmLocationViewController:ConfirmLocationViewController = storyBoard.instantiateViewController(withIdentifier: "ConfirmLocationVc") as? ConfirmLocationViewController{
            confirmLocationViewController.selectedLocation = location
            confirmLocationViewController.mediaUrl = mediaUrl
            navigationController?.pushViewController(confirmLocationViewController, animated: true)
        }
    }
    
    @IBAction func onCancelClicked(_ sender: Any) {
        self.dismiss(animated: true, completion:nil)
    }
    
    func displayErrorMessage(_ errorMessage:String?) {
        let alert = UIAlertController(title: "Add location", message: errorMessage, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    fileprivate func initButton(){
        submitButton.layer.cornerRadius = 10
        submitButton.clipsToBounds = true
    }
    
}
