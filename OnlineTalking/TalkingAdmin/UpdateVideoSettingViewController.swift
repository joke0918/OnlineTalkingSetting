//
//  UpdateVideoSettingViewController.swift
//  OnlineTalkSetting
//
//  Created by Yue Huang on 1/11/16.
//  Copyright © 2016 Yue Huang. All rights reserved.
//

import UIKit
import Alamofire

class UpdateVideoSettingViewController: UIViewController {

	var talkingModel: TalkingModel!
	
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

	
	@IBOutlet weak var urlTextField: UITextField!
	
	@IBOutlet weak var datePickerView: UIView!

	@IBOutlet weak var datePicker: UIDatePicker!
	
	
    override func viewDidLoad() {
        super.viewDidLoad()
			self.talkingModel = TalkingManager.sharedInstance.talkingModel
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

	override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
		self.view.endEditing(true)
		if !self.datePickerView.hidden {
			UIView.animateWithDuration(0.5) {
				self.datePickerView.hidden = true
			}
		}
	}
	
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
		self.updateVideoSetting()
	}
	
	@IBAction func datePickerViewConfirmAction(sender: AnyObject) {
		
		let f = NSDateFormatter()
		f.dateFormat = "yyyy-MM-dd HH:mm"
		let date = f.stringFromDate(self.datePicker.date) + ":00"
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
	
	@IBAction func changeToCurrentTime(sender: AnyObject) {
		let f = NSDateFormatter()
		f.dateFormat = "yyyy-MM-dd HH:mm:ss"
		var date = NSDate(timeInterval: 15, sinceDate: NSDate())
		self.beginButton.setTitle(f.stringFromDate(date), forState: .Normal)
		date = NSDate(timeInterval: 60 * 60, sinceDate: date)
		self.endButton.setTitle(f.stringFromDate(date), forState: .Normal)
		
	}
	
	func updateVideoSetting() {
		guard let begin = beginButton.titleForState(.Normal),
			let end = endButton.titleForState(.Normal),
			let url = self.urlTextField.text else {
				debugPrint("输入信息有误")
				return
		}
		let bodyDic = [
			"begin": begin,
			"end": end,
			"url": url
		]
		let urlString = "http://api.careerfrog.cn/api/talking-admin/talking/" + "\(TalkingManager.sharedInstance.currentTalkingID)" + "/video"
		request(.PUT, urlString, parameters: bodyDic, encoding: .JSON, headers: nil).responseJSON() {
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
		self.beginButton.setTitle(self.talkingModel.videoBeginString, forState: .Normal)
		self.endButton.setTitle(self.talkingModel.videoEndString, forState: .Normal)
		self.urlTextField.text = self.talkingModel.videoUrl
	}
	
	func prepareData() {
		let date = NSDate()
		self.datePicker.minimumDate = NSDate(timeInterval: -60 * 60, sinceDate: date)
		self.datePicker.maximumDate = NSDate(timeInterval: 365 * 24 * 60 * 60, sinceDate: date)
		
	}
	
	override func previewActionItems() -> [UIPreviewActionItem] {
		let currentTimeAction = UIPreviewAction(title: "现在播放", style: .Default) {
			(previewAction, viewcontroller) in
			let f = NSDateFormatter()
			f.dateFormat = "yyyy-MM-dd HH:mm:ss"
			var date = NSDate(timeInterval: 30, sinceDate: NSDate())
			self.beginButton.setTitle(f.stringFromDate(date), forState: .Normal)
			date = NSDate(timeInterval: 60 * 60, sinceDate: date)
			self.endButton.setTitle(f.stringFromDate(date), forState: .Normal)
			self.updateVideoSetting()
		}
		return [currentTimeAction]
	}
	
}

extension UpdateVideoSettingViewController: UITextFieldDelegate {
	func textFieldDidBeginEditing(textField: UITextField) {
		self.datePickerView.hidden = false
	}
}








