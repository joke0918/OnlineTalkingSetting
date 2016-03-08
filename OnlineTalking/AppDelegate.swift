//
//  AppDelegate.swift
//  OnlineTalking
//
//  Created by YeoHuang on 16/1/12.
//  Copyright © 2016年 YeoHuang. All rights reserved.
//

import UIKit
import Alamofire

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
			print("1111111")
        return true
    }

	// 3D-touch
	func application(application: UIApplication, performActionForShortcutItem shortcutItem: UIApplicationShortcutItem, completionHandler: (Bool) -> Void) {
		self.handleShortItem(shortcutItem)
		completionHandler(true)
	}
	
	// 3D-touch
	func handleShortItem(shortcutItem: UIApplicationShortcutItem) {
		switch shortcutItem.type {
		case "com.careerfrog.onlinetalking.login":
			let dic = [
				"username": "admin",
				"password": "sjtu2011"
			]
			request(.POST, "http://api.careerfrog.cn/api/user/authentication", parameters: dic, encoding: .JSON, headers: nil).responseJSON() {
				response in
				guard response.result.isSuccess == true else {
					debugPrint(response.result)
					return
				}
				dispatch_async(dispatch_get_main_queue()) {
					NSNotificationCenter.defaultCenter().postNotificationName("LoginSuccess", object: nil)
				}
			}
		default: break
		}
	}
	
    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

