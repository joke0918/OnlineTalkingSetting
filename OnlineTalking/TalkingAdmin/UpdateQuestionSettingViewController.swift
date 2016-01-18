//
//  UpdateQuestionSettingViewController.swift
//  OnlineTalking
//
//  Created by Yue Huang on 1/15/16.
//  Copyright © 2016 YeoHuang. All rights reserved.
//

import UIKit
import Alamofire

class UpdateQuestionSettingViewController: UIViewController {

	@IBOutlet weak var beginTextField: UITextField!
	
	@IBOutlet weak var endTextField: UITextField!
	
	@IBOutlet weak var enableTagSwitch: UISwitch!
	
	@IBOutlet weak var designatedSwitch: UISwitch!
	
	@IBOutlet weak var datePickerView: UIView!
	
	@IBOutlet weak var datePicker: UIDatePicker!
	
	var talkingModel: TalkingModel = TalkingManager.sharedInstance.talkingModel
	
    override func viewDidLoad() {
        super.viewDidLoad()
			self.prepareData()
			self.fillDataForUI()
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
	
	@IBAction func confirmAction(sender: AnyObject) {
		let result = self.generateParameters()
		if !result.isSuccess {
			self.showAlertWithMessage("参数错误")
			return
		}
		let urlString = "http://api.careerfrog.cn/api/talking-admin/talking/\(TalkingManager.sharedInstance.currentTalkingID)/question"
		request(.PUT, urlString, parameters: result.parameters!, encoding: .JSON, headers: nil).responseJSON() {
			response in
			guard response.result.isSuccess == true,
				let responseDic = response.result.value as? [String: AnyObject]
				else {
					debugPrint(response.result)
					return }
			
			guard responseDic["status"] as? String == "SUCCESS" else { return }
			dispatch_async(dispatch_get_main_queue()) {
				self.showAlertWithMessage("修改成功") {
					action in
					self.navigationController!.popViewControllerAnimated(true)
				}
			}
		}
	}
	
	@IBAction func datePickerViewConfirmAction(sender: AnyObject) {
		self.datePickerView.hidden = !self.datePickerView.hidden
		let f = NSDateFormatter()
		f.dateFormat = "yyyy-MM-dd HH:mm:ss"
		if self.beginTextField.isFirstResponder() {
			self.beginTextField.text = f.stringFromDate(self.datePicker.date)
		}
		
		if self.endTextField.isFirstResponder() {
			self.endTextField.text = f.stringFromDate(self.datePicker.date)
		}
	}
	
	func generateParameters() -> (parameters: [String: AnyObject]?, isSuccess: Bool) {
		guard let begin = self.beginTextField.text,
			let end = self.endTextField.text else {
				return(nil, false)
		}
		let dic: [String: AnyObject] = [
			"begin": begin,
			"end": end,
			"enableTag": self.enableTagSwitch.on,
			"designated": self.designatedSwitch.on
		]
		return (dic, true)
	}
	
	func fillDataForUI() {
		self.beginTextField.text = self.talkingModel.questionBeginString
		self.endTextField.text = self.talkingModel.questionEndString
		self.enableTagSwitch.on = self.talkingModel.questionEnableTag
		self.designatedSwitch.on = self.talkingModel.questionDesignated
	}
	
	func prepareData() {
		self.datePicker.minimumDate = NSDate()
		self.datePicker.maximumDate = NSDate(timeInterval: 365 * 24 * 60 * 60, sinceDate: NSDate())
		
	}
	
}

extension UpdateQuestionSettingViewController: UITextFieldDelegate {
	func textFieldDidBeginEditing(textField: UITextField) {
		self.datePickerView.hidden = false
	}
}





