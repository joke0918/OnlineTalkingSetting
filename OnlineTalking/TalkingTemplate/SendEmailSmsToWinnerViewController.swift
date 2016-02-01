//
//  SendEmailSmsToWinnerViewController.swift
//  OnlineTalking
//
//  Created by Yue Huang on 1/22/16.
//  Copyright © 2016 YeoHuang. All rights reserved.
//

import UIKit
import Alamofire

class SendEmailSmsToWinnerViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
	
	@IBAction func sendEmailAction(sender: AnyObject) {
		let urlString = "http://api.careerfrog.cn/api/exam-admin/\(TalkingManager.sharedInstance.currentTalkingID)/winners/send-email"
		request(.POST, urlString, parameters: nil, encoding: .JSON, headers: nil).responseJSON() {
			response in
			guard response.result.isSuccess == true,
				let responseDic = response.result.value as? [String: AnyObject]
				else {
					debugPrint(response.result)
					return }
			
			guard responseDic["status"] as? String == "SUCCESS" else { return }
			dispatch_async(dispatch_get_main_queue(), { () -> Void in
				self.showAlertWithMessage("发送Email成功")
			})
		}
	}
	
	@IBAction func sendSmsAction(sender: AnyObject) {
		let urlString = "http://api.careerfrog.cn/api/exam-admin/\(TalkingManager.sharedInstance.currentTalkingID)/winners/send-sms"
		request(.POST, urlString, parameters: nil, encoding: .JSON, headers: nil).responseJSON() {
			response in
			guard response.result.isSuccess == true,
				let responseDic = response.result.value as? [String: AnyObject]
				else {
					debugPrint(response.result)
					return }
			
			guard responseDic["status"] as? String == "SUCCESS" else { return }
			dispatch_async(dispatch_get_main_queue(), { () -> Void in
				self.showAlertWithMessage("发送Sms成功")
			})
		}
	}
	
}














