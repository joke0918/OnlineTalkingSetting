//
//  CommonHelper.swift
//  OnlineTalkSetting
//
//  Created by Yue Huang on 1/11/16.
//  Copyright © 2016 Yue Huang. All rights reserved.
//

import UIKit

class CommonHelper: NSObject {
	
}

extension UINavigationController {
	
	
	
	
}

extension UIViewController {
	
	func popToTalkingListViewController() {
		let childViewControllers = self.navigationController!.childViewControllers
		for viewController in childViewControllers {
			if let vc = viewController as? TalkingListViewController {
				self.navigationController!.popToViewController(vc, animated: true)
			}
		}
	}
	
	func setBackToMainViewControllerBarButton() {
		guard self.navigationController != nil else { return }
		let button = UIButton(type: .System)
		button.frame = CGRectMake(0, 0, 60, 44)
		button.setTitle("回到主页", forState: .Normal)
		button.addTarget(self, action: "popToTalkingListViewController", forControlEvents: .TouchUpInside)
		let barButton = UIBarButtonItem(customView: button)
		if let items = self.navigationItem.rightBarButtonItems {
			var tempItems = items
			tempItems.append(barButton)
			self.navigationItem.rightBarButtonItems = tempItems
		} else {
			self.navigationItem.rightBarButtonItem = barButton
		}
	}
	
	func showAlertWithMessage(message: String, confirmClosure: (UIAlertAction) -> Void) {
		let alertController = UIAlertController(title: "提示", message: message, preferredStyle: .Alert)
		let cancelAction = UIAlertAction(title: "取消", style: .Default, handler: nil)
		alertController.addAction(cancelAction)
		let confirmAction = UIAlertAction(title: "确定", style: .Default, handler: confirmClosure)
		alertController.addAction(confirmAction)
		
		self.presentViewController(alertController, animated: true, completion: nil)
	}
	
	func showAlertWithMessage(message: String) {
	let alertController = UIAlertController(title: "提示", message: message, preferredStyle: .Alert)
	let confirmAction = UIAlertAction(title: "确定", style: .Default, handler: nil)
	alertController.addAction(confirmAction)
	self.presentViewController(alertController, animated: true, completion: nil)
	}
	
}

extension UIButton {
	func addDefaultCornerRadius() {
		self.layer.cornerRadius = 4
		self.layer.masksToBounds = true
		self.layer.borderWidth = 1
	}
}