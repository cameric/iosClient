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
import MBProgressHUD

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
        return UserInterfaceServices.textFieldResignResponder(textField)
    }
    
    @IBAction func dismissKeyboardDidTapOutsideTextField(sender: UITapGestureRecognizer) {
        inputEmail.resignFirstResponder()
        inputPwd.resignFirstResponder()
    }
    
    // MARK: Navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "loggedInJumpToProfileSegue" {
            // Pass the logged in info to detailed profile view controller
            let targetViewController = segue.destinationViewController as! ProfileViewController
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
        guard let username = inputEmail!.text where !username.isEmpty else {
            self.showLoginInfo = true
            self.invalidLoginInfo.text = "邮箱不能为空"
            return
        }
        guard let pwd = inputPwd!.text where !pwd.isEmpty else {
            self.showLoginInfo = true
            self.invalidLoginInfo.text = "密码不能为空"
            return
        }
        
        // Set up loading view
        let loginNotification = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
        loginNotification.mode = MBProgressHUDMode.Indeterminate
        loginNotification.labelText = "登录中..."
        
        AVUser.logInWithUsernameInBackground(username, password: pwd, block: loginCallback)
    }
    
    func loginCallback(user: AVUser!, error: NSError!) {
        // First hide notification
        MBProgressHUD.hideAllHUDsForView(self.view, animated: true)
        
        if error != nil {
            print("\(error)")
            self.showLoginInfo = true
            self.invalidLoginInfo.text = "登陆错误：\(error.localizedDescription) (\(error.code))"
        } else {
            // Perform segue after async call is resolved
            do {
                let tmpUser = try UserQueryServices.userFromQueryResult(user)
                self.loggedInUser = tmpUser
                self.performSegueWithIdentifier("loggedInJumpToProfileSegue",
                    sender: self)
            } catch {
                self.invalidLoginInfo.text = "登录过程中出现错误，请重试"
            }
        }
    }
    
    @IBAction func weiboLogin(sender: UIButton) {
        self.showLoginInfo = true
        self.invalidLoginInfo.text = "现在跳转至微博登录..."
        
        let request = WBAuthorizeRequest.request() as! WBAuthorizeRequest
        request.redirectURI = GlobalAPIKeys.Weibo_AppRedirectURI
        request.scope = "all"
        
        WeiboSDK.sendRequest(request)
    }
    
    func didReceiveWeiboRequest(request: WBBaseRequest!) {
        // Nothing to listen here
    }
    
    func didReceiveWeiboResponse(response: WBBaseResponse!) {
        let authorizeResponse = response as! WBAuthorizeResponse
        // Perform action based on Weibo App feedback
        switch authorizeResponse.statusCode {
        case .Success:
            // Call LeanEngine cloud function to signup using Weibo API
            UserQueryServices.signUpWithWeibo(authorizeResponse.userID,
                accessToken: authorizeResponse.accessToken,
                onCompletion: { (curUser: User!, error: ErrorType!) -> Void in
                    if error != nil {
                        self.showLoginInfo = true
                        self.invalidLoginInfo.text = "微博登录过程中出现错误"
                    } else {
                        self.loggedInUser = curUser
                        self.performSegueWithIdentifier("loggedInJumpToDetailedProfileSegue",
                            sender: self)
                    }
            })
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
    
    @IBAction func cancelLogin(sender: UIBarButtonItem) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
}