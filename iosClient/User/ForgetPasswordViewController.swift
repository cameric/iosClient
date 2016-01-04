//
//  ForgetPasswordViewController.swift
//  iosClient
//
//  Created by Tony Zhang on 1/4/16.
//  Copyright © 2016 Cameric. All rights reserved.
//

import UIKit
import AVOSCloud
import MBProgressHUD

class ForgetPasswordViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var inputEmail: UITextField!
    @IBOutlet weak var invalidInputLabel: UILabel!
    
    var showInfo: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        inputEmail.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: UITextFieldDelegate
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        return UserInterfaceServices.textFieldResignResponder(textField)
    }
    
    @IBAction func dismissKeyboardDidTapOutsideTextField(sender: UITapGestureRecognizer) {
        inputEmail.resignFirstResponder()
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    // MARK: Action
    @IBAction func sendForgetPasswordEmail(sender: UIButton) {
        guard let email = inputEmail!.text where email != "" else {
            self.showInfo = true
            self.invalidInputLabel.text = "邮箱不能为空"
            return
        }
        
        // Set up loading view
        let loginNotification = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
        loginNotification.mode = MBProgressHUDMode.Indeterminate
        loginNotification.labelText = "正在发送验证邮件..."
        
        AVUser.requestPasswordResetForEmailInBackground(email, block:
            { (succeeded: Bool, error: NSError!) -> Void in
                // First hide notification
                MBProgressHUD.hideAllHUDsForView(self.view, animated: true)
                
                if succeeded {
                    self.showInfo = true
                    self.invalidInputLabel.text = "邮件已发送！"
                } else {
                    self.showInfo = true
                    self.invalidInputLabel.text = "\(error.localizedDescription) (\(error.code))"
                }
        })
    }
}
