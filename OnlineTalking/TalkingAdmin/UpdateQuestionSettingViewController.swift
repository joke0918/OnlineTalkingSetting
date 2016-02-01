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

	@IBOutlet weak var beginButton: UIButton! {
		didSet {
			self.beginButton.addDefaultCornerRadius()
		}
	}
	
	
	@IBOutlet weak var endButton: UIButton! {
		didSet {
			self.endButton.addDefaultCornerRadius()
		}
	}
	
	
	@IBOutlet weak var enableTagSwitch: UISwitch!
	
	@IBOutlet weak var designatedSwitch: UISwitch!
	
	@IBOutlet weak var datePickerView: UIView!
	
	@IBOutlet weak var datePicker: UIDatePicker!
	
	var talkingModel: TalkingModel = TalkingManager.sharedInstance.talkingModel
	
    override func viewDidLoad() {
        super.viewDidLoad()
			self.prepareData()
			self.fillDataForUI()
			self.setBackToMainViewControllerBarButton()
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
	
	
	@IBAction func beginAction(sender: AnyObject) {
		self.datePickerView.hidden = false
		self.beginButton.selected = true
		self.endButton.selected = false
	}
	
	@IBAction func endAction(sender: AnyObject) {
		self.datePickerView.hidden = false
		self.endButton.selected = true
		self.beginButton.selected = false
	}
	
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
					return
			}
			
			guard responseDic["status"] as? String == "SUCCESS" else { return }
			dispatch_async(dispatch_get_main_queue()) {
				self.showAlertWithMessage("修改成功") {
					[unowned self]
					action in
					self.navigationController!.popViewControllerAnimated(true)
				}
			}
		}
	}
	
	@IBAction func datePickerViewConfirmAction(sender: AnyObject) {
		let f = NSDateFormatter()
		f.dateFormat = "yyyy-MM-dd HH:mm:ss"
		let date = f.stringFromDate(self.datePicker.date)
		if self.beginButton.selected {
			self.beginButton.setTitle(date, forState: .Normal)
		}
		if self.endButton.selected {
			self.endButton.setTitle(date, forState: .Normal)
		}
		UIView.animateWithDuration(0.5) {
			self.datePickerView.hidden = true
		}
	}
	
	func generateParameters() -> (parameters: [String: AnyObject]?, isSuccess: Bool) {
		guard let begin = beginButton.titleForState(.Normal),
			let end = endButton.titleForState(.Normal) else {
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
		self.beginButton.setTitle(self.talkingModel.questionBeginString, forState: .Normal)
		self.endButton.setTitle(self.talkingModel.questionEndString, forState: .Normal)
		self.enableTagSwitch.on = self.talkingModel.questionEnableTag
		self.designatedSwitch.on = self.talkingModel.questionDesignated
	}
	
	func prepareData() {
		self.datePicker.minimumDate = NSDate()
		self.datePicker.maximumDate = NSDate(timeInterval: 365 * 24 * 60 * 60, sinceDate: NSDate())
		
	}
	
}







