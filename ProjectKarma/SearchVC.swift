//
//  SearchVC.swift
//  ProjectKarma
//
//  Created by Cam on 11/20/15.
//  Copyright © 2015 Cameric. All rights reserved.
//

import UIKit
import Foundation
import AVOSCloud

class SearchVC: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchResultsUpdating, UISearchBarDelegate, CustomSearchControllerDelegate {

    @IBOutlet weak var tableView_: UITableView!

    var dataArray = [String]()
    
    var filteredArray = [String]()
    
    var shouldShowSearchResults = false
    
    var searchController: UISearchController!
    
    var customSearchController: CustomSearchController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        tableView_.delegate = self
        tableView_.dataSource = self
        
        loadListOfUsers()
        
        // Uncomment the following line to enable the default search controller.
        // configureSearchController()
        
        // Comment out the next line to disable the customized search controller and search bar and use the default ones. Also, uncomment the above line.
        configureCustomSearchController()

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    // MARK: UITableView Delegate and Datasource functions
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if shouldShowSearchResults {
            return filteredArray.count
        }
        else {
            return dataArray.count
        }
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("searchCell", forIndexPath: indexPath)
        
        if shouldShowSearchResults {
            cell.textLabel?.text = filteredArray[indexPath.row]
        }
        else {
            cell.textLabel?.text = dataArray[indexPath.row]
        }
        
        return cell
    }
    
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 60.0
    }
    
    
    // MARK: Custom functions
    
    func loadListOfUsers() {
        let userstring = "Cam Fernando Tony"
        dataArray = userstring.componentsSeparatedByString(" ")
        
        // Reload the tableview.
        tableView_.reloadData()
    }
    
    func configureSearchController() {
        // Initialize and perform a minimum configuration to the search controller.
        searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search here"
        searchController.searchBar.delegate = self
        searchController.searchBar.sizeToFit()
        
        // Place the search bar view to the tableview headerview.
        tableView_.tableHeaderView = searchController.searchBar
    }
    
    
    func configureCustomSearchController() {
        customSearchController = CustomSearchController(searchResultsController: self, searchBarFrame: CGRectMake(0.0, 0.0, tableView_.frame.size.width, 50.0), searchBarFont: UIFont(name: "Futura", size: 16.0)!, searchBarTextColor: UIColor.orangeColor(), searchBarTintColor: UIColor.blackColor())
        
        customSearchController.customSearchBar.placeholder = "Doctor"
        tableView_.tableHeaderView = customSearchController.customSearchBar
        
        customSearchController.customDelegate = self
    }
    
    
    // MARK: UISearchBarDelegate functions
    
    func searchBarTextDidBeginEditing(searchBar: UISearchBar) {
        shouldShowSearchResults = true
        tableView_.reloadData()
    }
    
    
    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        shouldShowSearchResults = false
        tableView_.reloadData()
    }
    
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        if !shouldShowSearchResults {
            shouldShowSearchResults = true
            tableView_.reloadData()
        }
        
        searchController.searchBar.resignFirstResponder()
    }
    
    
    // MARK: UISearchResultsUpdating delegate function
    
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        guard let searchString = searchController.searchBar.text else {
            return
        }
        
        // Filter the data array and get only those countries that match the search text.
        filteredArray = dataArray.filter({ (country) -> Bool in
            let countryText:NSString = country
            
            return (countryText.rangeOfString(searchString, options: NSStringCompareOptions.CaseInsensitiveSearch).location) != NSNotFound
        })
        
        // Reload the tableview.
        tableView_.reloadData()
    }
    
    
    // MARK: CustomSearchControllerDelegate functions
    
    func didStartSearching() {
        shouldShowSearchResults = true
        tableView_.reloadData()
    }
    
    
    func didTapOnSearchButton() {
        if !shouldShowSearchResults {
            shouldShowSearchResults = true
            tableView_.reloadData()
        }
    }
    
    
    func didTapOnCancelButton() {
        shouldShowSearchResults = false
        tableView_.reloadData()
    }
    
    
    func didChangeSearchText(searchText: String) {
        // Filter the data array and get only those countries that match the search text.
        filteredArray = dataArray.filter({ (country) -> Bool in
            let countryText: NSString = country
            
            return (countryText.rangeOfString(searchText, options: NSStringCompareOptions.CaseInsensitiveSearch).location) != NSNotFound
        })
        
        // Reload the tableview.
        tableView_.reloadData()
    }
}