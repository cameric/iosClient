//
//  ProfileVC.swift
//  iosClient
//
//  Created by Cam on 11/20/15.
//  Copyright © 2015 Cameric. All rights reserved.
//

import UIKit
import Foundation
import AVOSCloud

class ProfileVC: UIViewController {
    
    // MARK: Properties
    @IBOutlet weak var notLoggedInView: UIView!
    @IBOutlet weak var loggedInView: UIView!
    @IBOutlet weak var loggedInNameLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        if let curUser = getCurrentUserIfLoggedIn() {
            notLoggedInView.hidden = true
            loggedInNameLabel.text = curUser.name
            loggedInView.hidden = false
        }
    }
    
    // MARK: Navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let id = segue.identifier where id == "ShowDetailedProfileSegue" {
            
        }
    }
    
    // MARK: Actions
    @IBAction func showLoggedInWindow(sender: UITapGestureRecognizer) {
        notLoggedInView.backgroundColor = UIColor.lightGrayColor()
    }
    
//    @IBAction func showDetailedProfile(sender: UITapGestureRecognizer) {
//        loggedInView.backgroundColor = UIColor.lightGrayColor()
//    }
    
    
}