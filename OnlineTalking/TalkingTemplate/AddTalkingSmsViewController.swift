//
//  AddTalkingSmsViewController.swift
//  OnlineTalking
//
//  Created by Yue Huang on 1/18/16.
//  Copyright © 2016 YeoHuang. All rights reserved.
//

import UIKit
import Alamofire

class AddTalkingSmsViewController: UIViewController {

	@IBOutlet weak var valuesTextField: UITextField!
	
	@IBOutlet weak var contentTextField: UITextField!
	
	var name: String = ""
	
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

	override func viewWillAppear(animated: Bool) {
		super.viewWillAppear(animated)
		if name == "template.notification.user" {
			self.valuesTextField.text = "online_talk_name,online_talk_time,online_talk_link"
			self.contentTextField.text = "【\(TalkingManager.sharedInstance.talkingModel.shortName)】你预约的{online_talk_name}将于北京时间{online_talk_time}开幕。为了保证最佳收看效果，建议通过PC端登录 {online_talk_link} 收看。"
		}
		if name == "template.notification.question.answered" {
			self.valuesTextField.text = "name,question_short,question_url"
			self.contentTextField.text = "【\(TalkingManager.sharedInstance.talkingModel.shortName)】你在{name}空中宣讲会提交的提问「{question_short}」已被解答！详见：{question_url}"
		}
		if name == "template.user.find.name" {
			self.valuesTextField.text = "username"
			self.contentTextField.text = "【\(TalkingManager.sharedInstance.talkingModel.shortName)】你的登录名为：{username}"
		}
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

	@IBAction func confirmAction(sender: AnyObject) {
		let dic = [
			"name": self.name,
			"values": self.valuesTextField.text!,
			"content": self.contentTextField.text!
		]
		let urlString = "http://api.careerfrog.cn/api/tpl-admin/\(TalkingManager.sharedInstance.talkingModel.talkingId)/sms/add"
		request(.POST, urlString, parameters: dic, encoding: .JSON, headers: nil).responseJSON() {
			response in
			guard response.result.isSuccess == true,
				let responseDic = response.result.value as? [String: AnyObject]
				else {
					debugPrint(response.result)
					return }
			
			guard responseDic["status"] as? String == "SUCCESS" else { return }
			dispatch_async(dispatch_get_main_queue(), { () -> Void in
				self.showAlertWithMessage("修改成功")
			})
			
		}
	}
}

















