//
//  TagListViewController.swift
//  OnTheMap
//
//  Created by Rajeev Ranganathan on 03/09/18.
//  Copyright © 2018 Rajeev Ranganathan. All rights reserved.
//

import UIKit

class TagListViewController: UITableViewController {
    let appDelegate:AppDelegate = (UIApplication.shared.delegate as! AppDelegate)
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return appDelegate.studentTagsList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let tableViewCell = tableView.dequeueReusableCell(withIdentifier: "TagViewCell") as! TagListViewCell?
        let studentTags = (appDelegate.studentTagsList[indexPath.row])
        tableViewCell?.tagMainText.text = "\(studentTags.firstName) \(studentTags.lastName)"
        tableViewCell?.tagSubtext.text = "\(studentTags.mediaUrl)"
        return tableViewCell!
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
