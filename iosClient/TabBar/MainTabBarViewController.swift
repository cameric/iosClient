//
//  MainTabBarViewController.swift
//  iosClient
//
//  Created by Tony Zhang on 1/3/16.
//  Copyright © 2016 Cameric. All rights reserved.
//

import UIKit

class MainTabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tabBar.backgroundColor = ColorScheme.backgroundColor()

        // Do any additional setup after loading the view.
        
        // TODO: Not sure why the tab bar icons still don't show up
        // even if I have manually set up the images
        /*for var i = 0; i < tabBar.items?.count; i++ {
            if let tabBarItem = tabBar.items?[i] as UITabBarItem! {
                // Adjust tab images (Like mstysf says, these values will vary)
                tabBarItem.imageInsets = UIEdgeInsetsMake(5, 0, -6, 0);
                tabBarItem.title = ""
                
                var imageName = ""
                switch (i) {
                    case 0: imageName = "Search"
                    case 1: imageName = "Rating"
                    case 2: imageName = "Clock"
                    case 3: imageName = "Contacts"
                    default: break
                }
                tabBarItem.image = UIImage(named:imageName)!.imageWithRenderingMode(.AlwaysOriginal)
                tabBarItem.selectedImage = UIImage(named:imageName)!.imageWithRenderingMode(.AlwaysOriginal)
            }
        }*/
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
