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

class ProfileViewController: UIViewController {
    
    // MARK: Properties
    @IBOutlet weak var notLoggedInView: UIView!
    @IBOutlet weak var loggedInView: UIView!
    @IBOutlet weak var loggedInNameLabel: UILabel!
    
    @IBOutlet weak var logoutButton: UIButton!
    
    var loggedInUser: User?
    
    func toggleLogInButton() {
        if self.loggedInUser != nil {
            notLoggedInView.hidden = true
            loggedInNameLabel.text = self.loggedInUser!.name
            loggedInView.hidden = false
            logoutButton.hidden = false
        } else {
            notLoggedInView.hidden = false
            loggedInView.hidden = true
            logoutButton.hidden = true
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        if let curUser = UserQueryServices.getCurrentUserIfLoggedIn() {
            self.loggedInUser = curUser
        }
        toggleLogInButton()
    }
    
    // MARK: Navigation
    // TODO: Pass useinfo to detailed profile page
//    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
//        if let id = segue.identifier where id == "ShowDetailedProfileSegue" {
//            
//        }
//    }
    
    // MARK: Actions
    @IBAction func didTapLoginButton(sender: UITapGestureRecognizer) {
        notLoggedInView.backgroundColor = UIColor.lightGrayColor()
    }
    @IBAction func didTapShowDetailedProfileButton(sender: UITapGestureRecognizer) {
        loggedInView.backgroundColor = UIColor.lightGrayColor()
    }
    
    @IBAction func finishedLoggedIn(sender: UIStoryboardSegue) {
        toggleLogInButton()
    }
    
    @IBAction func logout(sender: UIButton) {
        self.loggedInUser = nil
        toggleLogInButton()
        // Clear local storage
        AVUser.logOut()
    }
    
}