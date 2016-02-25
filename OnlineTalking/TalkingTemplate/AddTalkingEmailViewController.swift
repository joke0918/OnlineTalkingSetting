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
	
	@IBOutlet weak var contentTextView: UITextView!
	
	var name: String = ""
	
	
    override func viewDidLoad() {
        super.viewDidLoad()
			self.fillDataForUI()
        // Do any additional setup after loading the view.
    }
	
	override func viewWillAppear(animated: Bool) {
		super.viewWillAppear(animated)


		if name == "template.register.user" {
			self.title = "预报名邮件"
		}
		if name == "template.notification.user" {
			self.title = "开始前一天邮件"
		}
		if name == "template.notification.question.answered" {
			self.title = "问题回答邮件"

		}
		
		if name == "template.exam.winner.user" {
			self.title = "直通券邮件"

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
			"content": self.contentTextView.text!
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
	
	func fillDataForUI() {
		do {
			guard let filePath = NSBundle.mainBundle().pathForResource("Template.json", ofType: nil),
				let data = NSData(contentsOfFile: filePath),
				let dic = try NSJSONSerialization.JSONObjectWithData(data, options: .MutableContainers) as? [String: AnyObject] else {
					self.showAlertWithMessage("读取本地数据失败")
					return
		}
			if let templateDic = dic[self.name] as? [String: AnyObject] {
				self.titleTextField.text = templateDic["title"] as? String
				self.contentTextView.text = templateDic["content"] as? String
			}
			if self.name == "template.exam.winner.user" {
				self.titleTextField.text = "【\(TalkingManager.sharedInstance.talkingModel.shortName)】若你获得了「\(TalkingManager.sharedInstance.talkingModel.name)」直通券，请务必在24小时内完成网申！"
				self.contentTextView.text = "【\(TalkingManager.sharedInstance.talkingModel.shortName)】若你获得了「\(TalkingManager.sharedInstance.talkingModel.name)」直通券，请务必在24小时内完成网申！"
			}
		} catch {
			
		}
		
		
	}
	
}


















