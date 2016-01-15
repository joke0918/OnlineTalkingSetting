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

extension UIViewController {
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