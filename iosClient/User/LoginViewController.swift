//
//  LoginViewController.swift
//  iosClient
//
//  Created by Tony Zhang on 12/26/15.
//  Copyright © 2015 Cameric. All rights reserved.
//

import UIKit
import Foundation
import AVOSCloud

class LoginViewController: UIViewController, UITextFieldDelegate, WeiboSDKDelegate {
    
    // MARK: Properties
    @IBOutlet weak var inputEmail: UITextField!
    @IBOutlet weak var inputPwd: UITextField!
    @IBOutlet weak var invalidLoginInfo: UILabel!
    @IBOutlet weak var loginButton: UIButton!
    
    var showLoginInfo = false
    var loggedInUser: User?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
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
        inputEmail.resignFirstResponder()
        inputPwd.resignFirstResponder()
    }
    
    // MARK: Navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "loggedInJumpToDetailedProfileSegue" {
            // Pass the logged in info to detailed profile view controller
            let targetViewController = segue.destinationViewController as! DetailedProfileViewController
            targetViewController.loggedInUser = self.loggedInUser!
        }
    }
    
    // MARK: Actions
    @IBAction func login(sender: UIButton) {
        if showLoginInfo {
            showLoginInfo = false;
            self.invalidLoginInfo.text = ""
        }
        
        // User input check
        guard let username = inputEmail!.text where username != "" else {
            self.showLoginInfo = true
            self.invalidLoginInfo.text = "用户名不能为空"
            return
        }
        guard let pwd = inputPwd!.text where pwd != "" else {
            self.showLoginInfo = true
            self.invalidLoginInfo.text = "密码不能为空"
            return
        }
        
        AVUser.logInWithUsernameInBackground(username, password: pwd, block: loginCallback)
    }
    
    func loginCallback(user: AVUser!, error: NSError!) {
        if error != nil {
            print("\(error)")
            self.showLoginInfo = true
            self.invalidLoginInfo.text = "用户名或密码错误"
        } else {
            // Perform segue after async call is resolved
            do {
                let tmpUser = try userFromQueryResult(user)
                self.loggedInUser = tmpUser
                self.performSegueWithIdentifier("loggedInJumpToDetailedProfileSegue",
                    sender: self)
            } catch {
                self.invalidLoginInfo.text = "登录过程中出现错误，请重试"
            }
        }
    }
    
    @IBAction func weiboLogin(sender: UIButton) {
        let request = WBAuthorizeRequest.request() as! WBAuthorizeRequest
        request.redirectURI = GlobalAPIKeys.Weibo_AppRedirectURI
        request.scope = "all"
        
        WeiboSDK.sendRequest(request)
    }
    
    func didReceiveWeiboRequest(request: WBBaseRequest!) {
        
    }
    
    func didReceiveWeiboResponse(response: WBBaseResponse!) {
        let authorizeResponse = response as! WBAuthorizeResponse
        switch authorizeResponse.statusCode {
        case .Success:
            //authorizeResponse.userID
            //authorizeResponse.accessToken
            self.performSegueWithIdentifier("loggedInJumpToDetailedProfileSegue",
                sender: self)
            
        case .UserCancel:
            self.showLoginInfo = true
            self.invalidLoginInfo.text = "用户取消微博登录"
        case .SentFail:
            self.showLoginInfo = true
            self.invalidLoginInfo.text = "微博登录请求发送失败"
        case .AuthDeny:
            self.showLoginInfo = true
            self.invalidLoginInfo.text = "微博登录验证失败"
        default:
            self.showLoginInfo = true
            self.invalidLoginInfo.text = "微博登录过程中出现错误"
        }
    }
}