//
//  TagListViewController.swift
//  OnTheMap
//
//  Created by Rajeev Ranganathan on 03/09/18.
//  Copyright © 2018 Rajeev Ranganathan. All rights reserved.
//

import UIKit

class TagListViewController:BaseViewController,UITableViewDelegate,UITableViewDataSource,DataCompletionListener{
    
    let appDelegate:AppDelegate = (UIApplication.shared.delegate as! AppDelegate)
    
    @IBOutlet var studentListTableView: UITableView!
    @IBAction func onAddLocation(_ sender: Any) {
        addLocation()
    }
    
    //MARK:- System Callbacks
    override func viewWillAppear(_ animated: Bool) {
        print("viewWillAppear")
        setDataCompletionListener(dataCompletionListener: self)
    }
    override func viewWillDisappear(_ animated: Bool) {
        print("viewWillDisappear")
        setDataCompletionListener(dataCompletionListener: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        studentListTableView.delegate = self 
        studentListTableView.dataSource = self
    }
    @IBAction func onLogOutClick(_ sender: Any) {
        logOut()
    }
    //MARK:- Tableview delegates
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return appDelegate.studentTagsList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let tableViewCell = tableView.dequeueReusableCell(withIdentifier: "TagViewCell") as! TagListViewCell?
        let studentTags = (appDelegate.studentTagsList[indexPath.row])
        tableViewCell?.tagMainText.text = "\(studentTags.firstName) \(studentTags.lastName)"
        tableViewCell?.tagSubtext.text = "\(studentTags.mediaUrl)"
        return tableViewCell!
    }
    
    //MARK:- Dataload callbacks
    func onDataLoadSuccess(studentList: [StudentTags]?) {
        if let studentList = studentList{
            performUIUpdatesOnMain {
                self.appDelegate.studentTagsList = studentList
                self.studentListTableView.reloadData()
            }
        }
    }
    
    func onDataLoadFailure(errorString: String?) {
        displayErrorMessage(errorString)
    }
    
    @IBAction func onRefreshClick(_ sender: Any) {
        refresh()
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
