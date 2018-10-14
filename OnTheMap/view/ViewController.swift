//
//  ViewController.swift
//  OnTheMap
//
//  Created by Rajeev Ranganathan on 19/08/18.
//  Copyright © 2018 Rajeev Ranganathan. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var emailText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    @IBOutlet weak var logInBtn: UIButton!
    
    fileprivate func initLoginButton() {
        logInBtn.layer.cornerRadius = 10
        logInBtn.clipsToBounds = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initLoginButton()
    }
    
    fileprivate func displayErrorMessage(_ errorMessage:String?) {
        let alert = UIAlertController(title: nil, message: errorMessage, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func onLoginClicked(_ sender: UIButton) {
        let userName = emailText.text
        let password = passwordText.text
        let loadingIndicator = UIViewController.displayLoadingIndicator(view: self.view)
        if (!(userName?.isEmpty)! && !(password?.isEmpty)!){
            NetworkController.init().instance().login(userName: userName!, password: password!){ (isSuccess,sessionId,accoutKey,errorString) in
                if(isSuccess){
                    UserSession.instance.accountKey = accoutKey
                    UserSession.instance.sessionId = sessionId
                    performUIUpdatesOnMain {
                        UIViewController.removeLoader(view:loadingIndicator)
                        if let tabbar = (self.storyboard?.instantiateViewController(withIdentifier: "homepagetab") as? UITabBarController) {
                            self.present(tabbar, animated: true, completion: nil)
                        }
                    }
                } else {
                    performUIUpdatesOnMain {
                        self.displayErrorMessage(errorString)
                        UIViewController.removeLoader(view:loadingIndicator)
                    }
                }
            }
        } else {
            displayErrorMessage("Enter both Username & Password")
            UIViewController.removeLoader(view:loadingIndicator)
        }
    }
    
    @IBAction func onSignupClick(_ sender: Any) {
        let url = URL(string: "https://auth.udacity.com/sign-up")
        UIApplication.shared.open(url!, options: [:], completionHandler:nil)
    }
    
}

