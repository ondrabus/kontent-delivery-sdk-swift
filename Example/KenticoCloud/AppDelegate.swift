//
//  AppDelegate.swift
//  KenticoCloud
//
//  Created by martinmakarsky@gmail.com on 08/16/2017.
//  Copyright © 2017 Kentico Software. All rights reserved.
//

import UIKit
import KenticoCloud

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

	private var kGaPropertyId = "UA-XXXXXXXXX-1";

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        guard let gai = GAI.sharedInstance() else {
            assert(false, "Google analytics not configured correctly")
        }
        
        gai.tracker(withTrackingId: self.kGaPropertyId)
        gai.trackUncaughtExceptions = true
        
        gai.logger.logLevel = .verbose
        
        // Customize appearance
        UINavigationBar.appearance().isHidden = true
        UITableView.appearance().backgroundColor = AppConstants.globalBackgroundColor
        UITableViewCell.appearance().backgroundColor = AppConstants.globalBackgroundColor
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
    }

    func applicationWillTerminate(_ application: UIApplication) {
    }
}

