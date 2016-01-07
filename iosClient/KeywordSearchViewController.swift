//
//  KeywordSearchViewController.swift
//  iosClient
//
//  Created by Spencer Michaels on 1/6/16.
//  Copyright © 2016 Cameric. All rights reserved.
//

import AVOSCloud
import UIKit

class KeywordSearchViewController: UITableViewController {
    
    var usersFound: [AVUser] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        fetchData("smichaels")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1;
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10;
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellIdentifier = "CellIdentifier"
        
        guard let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier) else {
            return UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: cellIdentifier)
        }
    
        cell.textLabel!.text = String(format:"Row %d", indexPath.row)
        return cell
    }
    
    // MARK: Fetching
    
    func fetchData(keyword: String) {
        UserQueryServices.getUsersShortByKeyword(keyword,
            success: { (users: [AVUser]) -> Void in
                self.usersFound = users
                self.tableView.reloadData()
            },
            failure: { (error: ErrorType) -> Void in
                print(error)
            })
    }
}
