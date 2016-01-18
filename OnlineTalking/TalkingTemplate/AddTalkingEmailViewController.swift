//
//  AddTalkingEmailViewController.swift
//  OnlineTalking
//
//  Created by Yue Huang on 1/18/16.
//  Copyright © 2016 YeoHuang. All rights reserved.
//

import UIKit
import Alamofire

class AddTalkingEmailViewController: UIViewController {

	@IBOutlet weak var titleTextField: UITextField!
	
	@IBOutlet weak var contentTextField: UITextField!
	
	var name: String = ""
	
	
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
	
	override func viewWillAppear(animated: Bool) {
		super.viewWillAppear(animated)
		if name == "template.register.user" {
			self.titleTextField.text = "你已成功报名「{online_talk_name}」，请于{online_talk_time}登录 {online_talk_link}收看宣讲会"
			self.contentTextField.text = "<p>你已成功报名「{online_talk_name}」，请于{online_talk_time}登录 {online_talk_link}收看宣讲会</p><p>{online_talk_short}</p>"
		}
		if name == "template.notification.user" {
			self.titleTextField.text = "【{online_talk_short}】你预约的{online_talk_name}将于{online_talk_time}开幕，期待你的参与"
			self.contentTextField.text = "<p>你预约的{online_talk_name}将于{online_talk_time}开幕，请登录 {online_talk_link} 收看</p><p>祝应聘成功<br>{online_talk_short}</p>"
		}
		if name == "template.notification.question.answered" {
			self.titleTextField.text = "【{online_talk_short}】你在{name}空中宣讲会提交的提问「{question_short}」已被解答！"
			self.contentTextField.text = "<p>你在{name}空中宣讲会提交的提问已被解答！</p><p>问题描述<br>{question}</p><p>解答如下<br>{answer}</p><p>祝应聘成功<br>{online_talk_short}</p>"
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
			"title": self.titleTextField.text!,
			"content": self.contentTextField.text!
		]
		let urlString = "http://api.careerfrog.cn/api/tpl-admin/\(TalkingManager.sharedInstance.talkingModel.talkingId)/email/add"
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


















