//
//  AppDelegate.swift
//  iosClient
//
//  Created by Cam on 11/20/15.
//  Copyright © 2015 Cameric. All rights reserved.
//

import UIKit
import AVOSCloud
import AVOSCloudIM
import MMDrawerController

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, WeiboSDKDelegate {

    var window: UIWindow?

    // MARK: UIApplicationDelegate
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool
    {
        window = UIWindow(frame: UIScreen.mainScreen().bounds)
        
        // Bootstrap AVOSCloud library
        AVOSCloud.setApplicationId(GlobalAPIKeys.LeanEngine_AppId, clientKey: GlobalAPIKeys.LeanEngine_AppKey)
        AVAnalytics.trackAppOpenedWithLaunchOptions(launchOptions)
        
        // DEV: Use the test server
        AVCloud.setProductionMode(false)
        
        // Bootstrap Weibo SDK
        WeiboSDK.enableDebugMode(true)
        WeiboSDK.registerApp(GlobalAPIKeys.Weibo_AppKey)
        
        // Set up the statusbar
        let drawerController: MMDrawerController = MMDrawerController(
            centerViewController: UIStoryboard.getInitialViewController(),
            leftDrawerViewController: UIStoryboard.getSidebarViewController())
        
        drawerController.showsShadow = false
        drawerController.shouldStretchDrawer = false
        drawerController.restorationIdentifier = "StatusbarDrawer"
        drawerController.maximumLeftDrawerWidth = 160.0
        drawerController.openDrawerGestureModeMask = MMOpenDrawerGestureMode.BezelPanningCenterView
        drawerController.closeDrawerGestureModeMask = MMCloseDrawerGestureMode.All
        drawerController.setDrawerVisualStateBlock(MMDrawerVisualState.parallaxVisualStateBlockWithParallaxFactor(2.0))
        
        window?.rootViewController = drawerController
        window?.makeKeyAndVisible()
        
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
    }

    func applicationDidEnterBackground(application: UIApplication) {
    }

    func applicationWillEnterForeground(application: UIApplication) {
    }

    func applicationDidBecomeActive(application: UIApplication) {
    }

    func applicationWillTerminate(application: UIApplication) {
    }

    // MARK: Weibo integration
    
    // Enable the app to call Weibo app and push Weibo to foreground for further actions
    func application(application: UIApplication, openURL url: NSURL, sourceApplication: String?, annotation: AnyObject) -> Bool {
        return WeiboSDK.handleOpenURL(url, delegate: self as WeiboSDKDelegate)
    }
    
    func application(application: UIApplication, handleOpenURL url: NSURL) -> Bool {
        return WeiboSDK.handleOpenURL(url, delegate: self as WeiboSDKDelegate)
    }
    
    // MARK: WeiboSDKDelegate
    
    func didReceiveWeiboRequest(request: WBBaseRequest!) {
        // Received a request from the Weibo client
    }
    
    func didReceiveWeiboResponse(response: WBBaseResponse!) {
        // Received a response from the Weibo client
    }

}

// MARK: Storyboard
private extension UIStoryboard {
    /**
     Gets the view controller expected to appear upon first opening the app. I set this to the login screen as an example, but anything works.
    */
    class func getInitialViewController() -> UIViewController? {
        return UIStoryboard(name: "User", bundle: NSBundle.mainBundle())
            .instantiateViewControllerWithIdentifier("LoginViewController")
    }
    
    /**
     Gets the view controller for the statusbar, which can be pulled in from the right while on any other page.
    */
    class func getSidebarViewController() -> SidebarViewController? {
        return UIStoryboard(name: "Sidebar", bundle: NSBundle.mainBundle())
            .instantiateViewControllerWithIdentifier("SidebarViewController") as? SidebarViewController
    }
}