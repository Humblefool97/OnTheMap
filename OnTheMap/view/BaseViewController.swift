//
//  BaseViewController.swift
//  OnTheMap
//
//  Created by Rajeev Ranganathan on 09/09/18.
//  Copyright © 2018 Rajeev Ranganathan. All rights reserved.
//

import Foundation
import UIKit

class BaseViewController:UIViewController{
    private var onDataCompletionListener:DataCompletionListener?=nil
    
    func setDataCompletionListener(dataCompletionListener:DataCompletionListener?){
        self.onDataCompletionListener = dataCompletionListener
    }
    
    override func viewDidLoad() {
        getStudents()
    }
    
    func displayErrorMessage(_ errorMessage:String?) {
        let alert = UIAlertController(title: nil, message: errorMessage, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    
    func getStudents(){
        let loadingIndicator = UIViewController.displayLoadingIndicator(view: self.view)
        NetworkController.init().instance().getStudents { (isSuccess, studentTags, errorString) in
            if(isSuccess){
                if let dataCompletionListener = self.onDataCompletionListener{
                    dataCompletionListener.onDataLoadSuccess(studentList: studentTags)
                    performUIUpdatesOnMain {
                        let delegate = UIApplication.shared.delegate
                        let appDelegate = delegate as? AppDelegate
                        if(studentTags != nil && !((studentTags?.isEmpty)!)){
                            appDelegate?.studentTagsList = studentTags!
                        }
                    }
                }
            }else{
                if let dataCompletionListener = self.onDataCompletionListener{
                    dataCompletionListener.onDataLoadFailure(errorString: errorString)
                }
            }
            performUIUpdatesOnMain {
                UIViewController.removeLoader(view: loadingIndicator)
            }
           self.checkStudentLocation()
        }
    }
    
    func checkStudentLocation(){
        let loadingIndicator = UIViewController.displayLoadingIndicator(view: self.view)
        NetworkController.init().instance().getStudent(uniqueKey:  UserSession.instance.accountKey!){
            (isSuccess,isStudentLocationExists,errorString) in
            if(isSuccess){
                //Display dialog
                performUIUpdatesOnMain {
                    if(isStudentLocationExists){
                        print("Student Record already exists")
                        UserSession.instance.doesUserExist = true
                    }else{
                        print("Student Record doesn't exists")
                    }
                }
            }else{
                //Display VC to add location
            }
            performUIUpdatesOnMain {
                UIViewController.removeLoader(view:loadingIndicator)
            }
        }
    }
    
    func addLocation(){
        if(UserSession.instance.doesUserExist){
            let alert = UIAlertController(title: "Overwrite?", message: "User location already exists.Do you want to overwrite it?", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.default, handler: nil))
            alert.addAction(UIAlertAction(title: "Overwrite", style: UIAlertActionStyle.default){ action in
            })
            self.present(alert, animated: true, completion: nil)
        }
    }
    
}
