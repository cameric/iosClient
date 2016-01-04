//
//  SignupViewController.swift
//  iosClient
//
//  Created by Tony Zhang on 1/1/16.
//  Copyright © 2016 Cameric. All rights reserved.
//

import Foundation
import AVOSCloud
import UIKit

class SignupViewController: UIViewController, UITextFieldDelegate {
    
    // Properties
    @IBOutlet weak var inputName: UITextField!
    @IBOutlet weak var inputEmail: UITextField!
    @IBOutlet weak var inputPwd: UITextField!
    @IBOutlet weak var acceptLicense: UISwitch!
    @IBOutlet weak var invalidInputLabel: UILabel!
    
    var showSignupInfo: Bool = false
    
    // MARK: Default actions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        inputName.delegate = self
        inputEmail.delegate = self
        inputPwd.delegate = self
    }
    
    // MARK: UITextFieldDelegate
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        let nextTag=textField.tag + 1;
        // Try to find next responder
        let nextResponder=textField.superview?.viewWithTag(nextTag) as UIResponder!
        
        if (nextResponder != nil) {
            // Found next responder, so set it.
            nextResponder?.becomeFirstResponder()
        } else {
            // Not found, so remove keyboard
            textField.resignFirstResponder()
        }
        return false // We do not want UITextField to insert line-breaks.
    }
    
    @IBAction func dismissKeyboardDidTapOutsideTextField(sender: UITapGestureRecognizer) {
        inputName.resignFirstResponder()
        inputEmail.resignFirstResponder()
        inputPwd.resignFirstResponder()
    }
    
    // MARK: Navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "signedupJumpToProfileSegue" {
            // Pass the logged in info to detailed profile view controller
            let targetViewController = segue.destinationViewController as! ProfileViewController
            targetViewController.loggedInUser = UserQueryServices.getCurrentUserIfLoggedIn()
        }
    }
    
    // MARK: Custom actions
    @IBAction func signup(sender: UIButton) {
        if showSignupInfo {
            showSignupInfo = false;
            self.invalidInputLabel.text = ""
        }
        
        // User input check
        guard let name = inputName!.text where name != "" else {
            self.showSignupInfo = true
            self.invalidInputLabel.text = "昵称不能为空"
            return
        }
        guard let username = inputEmail!.text where username != "" else {
            self.showSignupInfo = true
            self.invalidInputLabel.text = "邮箱不能为空"
            return
        }
        guard let pwd = inputPwd!.text where pwd != "" else {
            self.showSignupInfo = true
            self.invalidInputLabel.text = "密码不能为空"
            return
        }
        guard acceptLicense!.on else {
            self.showSignupInfo = true
            self.invalidInputLabel.text = "请同意平台协议"
            return
        }
        
        let newUser = AVUser()
        newUser.setObject(name, forKey: "name")
        newUser.username = username
        newUser.email = username
        newUser.password = pwd
        newUser.signUpInBackgroundWithBlock(signupCallback)
    }
    
    func signupCallback(succeeded: Bool, error: NSError!) {
        if succeeded {
            self.performSegueWithIdentifier("signedupJumpToProfileSegue", sender: self)
        } else {
            self.showSignupInfo = true
            self.invalidInputLabel.text = "\(error.localizedDescription) (\(error.code))"
        }
    }
    
    
}