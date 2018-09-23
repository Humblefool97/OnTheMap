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
    
    func onDataLoadSuccess(studentList: [StudentTags]?) {
        if let studentList = studentList{
            appDelegate.studentTagsList = studentList
            studentListTableView.reloadData()
        }
    }
    
    func onDataLoadFailure(errorString: String?) {
        displayErrorMessage(errorString)
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
