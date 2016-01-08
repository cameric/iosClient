//
//  ProfileViewController.swift
//  iosClient
//
//  Created by Cam on 11/20/15.
//  Copyright © 2015 Cameric. All rights reserved.
//

import UIKit
import Foundation
import AVOSCloud

class ProfileViewController: UITableViewController {
    
    // MARK: Properties
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet var profileTableView: UITableView!
    @IBOutlet weak var defaultAccountImage: UIImageView!
    
    var loggedInUser: AVUser?
    
    func toggleLogInButton() {
        if let curUser = self.loggedInUser {
            nameLabel.text = curUser.objectForKey("name") as? String
            if let joinedCategory = curUser.objectForKey("category") as? [String] {
                categoryLabel.text = joinedCategory.joinWithSeparator(", ")
            } else {
                categoryLabel.text = ""
            }
            if let avatar = curUser.objectForKey("avatar") as? AVFile {
                avatar.getThumbnail(true, width: 80, height: 80, withBlock: {
                    (image: UIImage!, error: NSError!) -> Void in
                    if error != nil {
                        print("Loading avatar error: \(error)")
                        return
                    }
                    self.defaultAccountImage.image = image
                    UserInterfaceServices.cropToCircle(self.defaultAccountImage)
                    self.defaultAccountImage.alpha = 1
                })
            }
        } else {
            nameLabel.text = "点击登录"
            categoryLabel.text = "或注册开始助力他人"
            self.defaultAccountImage.image = UIImage(named: "md_ic_account_circle_48pt")
            self.defaultAccountImage.alpha = 0.3
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        if let curUser = AVUser.currentUser() {
            self.loggedInUser = curUser
        }
        self.profileTableView.contentInset = UIEdgeInsetsMake(-36, 0, 0, 0);
        self.profileTableView.reloadData()

        toggleLogInButton()
    }
    
    // Override delegate functions to hide and show logout section properly
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 4 && self.loggedInUser == nil {
            return 0
        } else {
            return super.tableView(tableView, heightForHeaderInSection: section)
        }
    }
    override func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if section == 4 && self.loggedInUser == nil {
            return 0
        } else {
            return super.tableView(tableView, heightForFooterInSection: section)
        }
    }
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 4 && self.loggedInUser == nil {
            return 0
        } else {
            return super.tableView(tableView, numberOfRowsInSection: section)
        }
    }

    // MARK: Navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let id = segue.identifier where id == "ToDetailedProfileSegue" {
            let targetViewController = segue.destinationViewController as! DetailedProfileViewController
            targetViewController.loggedInUser = self.loggedInUser
        }
    }
    
    // MARK: Actions
    @IBAction func didTapLoginButton(sender: UITapGestureRecognizer) {
        if self.loggedInUser != nil {
            self.performSegueWithIdentifier("ToDetailedProfileSegue", sender: self)
        } else {
            self.performSegueWithIdentifier("ToUserModuleSegue", sender: self)
        }
    }
    
    @IBAction func finishedLoggedIn(sender: UIStoryboardSegue) {
        self.profileTableView.reloadData()
        toggleLogInButton()
    }
    
    @IBAction func logout(sender: UITapGestureRecognizer) {
        self.loggedInUser = nil
        self.profileTableView.reloadData()
        toggleLogInButton()
        // Clear local storage
        AVUser.logOut()
    }
}