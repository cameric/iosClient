//
//  LoginVC.swift
//  ProjectKarma
//
//  Created by Tony Zhang on 12/26/15.
//  Copyright © 2015 Cameric. All rights reserved.
//

import UIKit
import Foundation
import AVOSCloud

class LoginVC: UIViewController {
    
    @IBOutlet weak var inputEmail: UITextField!
    @IBOutlet weak var inputPwd: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func login(sender: UIButton) {
        if let username = inputEmail!.text {
            if let pwd = inputPwd!.text {
                AVUser.logInWithUsernameInBackground(username, password: pwd, block: { (user: AVUser!, error: NSError!) in
                    print("\(user.objectForKey("name"))")
                })
            }
        }
    }
    
    @IBAction func signup(sender: UIButton) {
        let newUser = AVUser()
        if let username = inputEmail!.text {
            if let pwd = inputPwd!.text {
                newUser.username = username
                newUser.email = pwd
                newUser.signUpInBackgroundWithBlock({ (succeeded: Bool, error: NSError!) -> () in
                    if (succeeded) {
                        print("Successfully logged in")
                    } else {
                        print("\(error)")
                    }
                })
            } else {
                print("Incomplete info!")
            }
        }
    }
    
}