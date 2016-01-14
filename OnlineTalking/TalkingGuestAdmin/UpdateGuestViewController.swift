//
//  UpdateGuestViewController.swift
//  OnlineTalkSetting
//
//  Created by Yue Huang on 1/11/16.
//  Copyright © 2016 Yue Huang. All rights reserved.
//

import UIKit
import Alamofire


class UpdateGuestViewController: UIViewController {

	@IBOutlet weak var usernameTextField: UITextField!
	@IBOutlet weak var nicknameTextField: UITextField!
	@IBOutlet weak var positionTextField: UITextField!
	@IBOutlet weak var avatarUrlTextField: UITextField!
	@IBOutlet weak var userTextField: UITextField!
	@IBOutlet weak var passTextField: UITextField!
	@IBOutlet weak var adminSwitch: UISwitch!
	@IBOutlet weak var orderTextField: UITextField!
	@IBOutlet weak var displaySwitch: UISwitch!

	var guestModel: GuestModel = {
		let model = GuestModel(dic: nil)
		return model
	}()
	
    override func viewDidLoad() {
        super.viewDidLoad()
			self.fillDataForUI()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
	
	override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
		self.view.endEditing(true)
	}

	@IBAction func confirmAction(sender: AnyObject) {
		guard let username = self.usernameTextField.text,
			let nickname = self.nicknameTextField.text,
			let user = self.userTextField.text,
			let pass = self.passTextField.text,
			let position = self.positionTextField.text,
			let avatarUrl = self.avatarUrlTextField.text,
			let order = self.orderTextField.text else {
				self.showAlertWithMessage("信息输入有误")
				return
		}
		
		let dic: [String: AnyObject] = [
			"username": username,
			"nickname": nickname,
			"position": position,
			"avatarUrl": avatarUrl,
			"user": user,
			"pass": pass,
			"admin": self.adminSwitch.on,
			"order": order,
			"display": self.displaySwitch.on
		]
		

		if self.guestModel.guestId == "" {
			self.createGuestWithDic(dic)
		} else {
			self.updateGuestWithDic(dic)
		}
		
	}
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
	
	func createGuestWithDic(dic: [String: AnyObject]) {
		let urlString = "http://api.careerfrog.cn/api/guest-admin/\(TalkingManager.sharedInstance.currentTalkingID)/add"
		request(.POST, urlString, parameters: dic, encoding: .JSON, headers: nil).responseJSON() {
			response in
			guard response.result.isSuccess == true else {
				debugPrint(response.result.error!)
				return
			}
			
			dispatch_async(dispatch_get_main_queue(), { () -> Void in
				self.showAlertWithMessage("创建成功")

			})
		}
	}
	
	func updateGuestWithDic(dic: [String: AnyObject]) {
		if self.guestModel.guestId == "" {
			self.showAlertWithMessage("GuestId 不能为空")
			return
		}
		let urlString = "http://api.careerfrog.cn/api/guest-admin/\(TalkingManager.sharedInstance.currentTalkingID)" + "/\(self.guestModel.guestId)"
		request(.PUT, urlString, parameters: dic, encoding: .JSON, headers: nil).responseJSON() {
			response in
			guard response.result.isSuccess == true else {
				debugPrint(response.result.error!)
				return
			}
			dispatch_async(dispatch_get_main_queue(), { () -> Void in
				self.showAlertWithMessage("修改成功")
				
			})
		}
	}
	
	func fillDataForUI() {
		guard self.guestModel.guestId != "" else { return }
		
		self.usernameTextField.text = self.guestModel.username
		self.nicknameTextField.text = self.guestModel.nickname
		self.positionTextField.text = self.guestModel.position
		self.avatarUrlTextField.text = self.guestModel.avatarUrl
		self.adminSwitch.on = self.guestModel.admin
		self.displaySwitch.on = self.guestModel.display
		self.orderTextField.text = "\(self.guestModel.order)"
	}
}








