//
//  KeywordSearchViewController.swift
//  iosClient
//
//  Created by Spencer Michaels on 1/6/16.
//  Copyright © 2016 Cameric. All rights reserved.
//

import AVOSCloud
import UIKit

class KeywordSearchViewController: UITableViewController, UISearchResultsUpdating, UISearchBarDelegate {
    let kLoadingCellTag = 1337
    
    var currentSearchText = ""
    var usersFound: [AVUser] = []
    var currentPage = 0
    var loadedAllPages = false
    let resultsPerPage = 10
    
    var searchController: UISearchController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.dimsBackgroundDuringPresentation = false
        searchController.searchBar.delegate = self
        searchController.searchBar.sizeToFit()
        
        navigationController?.setNavigationBarHidden(false, animated: true)
        
        tableView.delegate = self
        tableView.dataSource = self
        navigationItem.titleView = self.searchController.searchBar
        
        definesPresentationContext = true
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

    // MARK: Table view
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if !loadedAllPages {
            return usersFound.count + 1
        }
        return usersFound.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if indexPath.row < self.usersFound.count {
            return userCellForIndexPath(indexPath)
        } else {
            return loadingCell()
        }
    }
    
    func userCellForIndexPath(indexPath: NSIndexPath) -> UITableViewCell {
        let cellIdentifier = "cell"
        
        // Retrieve a cell, or make one if the retrieved cell is nil (??)
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier)
            ?? UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: cellIdentifier)
        
        let user = usersFound[indexPath.row]
        
        cell.textLabel!.text = user.username
        cell.detailTextLabel!.text = user.email
        
        return cell
    }
    
    func loadingCell() -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: nil)
        let loadingIndicator = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.Gray)
        
        // TODO: The center is a bit off
        loadingIndicator.center = cell.center
        cell.addSubview(loadingIndicator)
        loadingIndicator.startAnimating()
        
        cell.tag = kLoadingCellTag
        
        return cell
    }
    
    override func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        if (cell.tag == kLoadingCellTag) {
            currentPage++
            fetchData()
        }
    }
    
    // MARK: Fetching
    
    func fetchData() {
        UserQueryServices.getUsersShortByKeyword(
            currentSearchText,
            skip: (currentPage-1)*resultsPerPage,
            numResults: resultsPerPage,
            success: { (users: [AVUser]) -> Void in
                // TODO: Does this work in the case that the total number of users found is equal to n*resultsPerPage? NO.
                if users.count < self.resultsPerPage {
                    self.loadedAllPages = true
                }
                for user in users {
                    // Checking for duplicates avoids changing data on the server from interfering with the list rendering
                    if (!self.usersFound.contains(user)) {
                        self.usersFound.append(user)
                    }
                }
                
                self.tableView.reloadData()
            },
            failure: { (error: ErrorType) -> Void in
                print(error)
            })
    }
    
    // MARK: UISearchResultsUpdating
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        if let searchString = searchController.searchBar.text {
            currentSearchText = searchString
            currentPage = 0
            loadedAllPages = false
            usersFound = []
            tableView.reloadData()
        }
    }
}
