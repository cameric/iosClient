//
//  DetailedProfileViewController.swift
//  iosClient
//
//  Created by Tony Zhang on 1/2/16.
//  Copyright © 2016 Cameric. All rights reserved.
//

import UIKit
import AVOSCloud

class DetailedProfileViewController: UIViewController {
    
    // MARK: Properties
    var loggedInUser: AVUser?
    @IBOutlet weak var nameLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
//        do {
//            let tmpUser = try userFromQueryResult(AVUser.currentUser())
//            self.loggedInUser = tmpUser
//            print(self.loggedInUser!.name)
//        } catch {
//            self.nameLabel.text = "您还没有登陆！"
//        }
//        if self.loggedInUser != nil {
//            print(loggedInUser!.name)
//        }
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

}
