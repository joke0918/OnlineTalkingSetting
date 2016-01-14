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
	
	@IBOutlet weak var beginTextField: UITextField!
	
	@IBOutlet weak var endTextField: UITextField!
	
	@IBOutlet weak var urlTextField: UITextField!
	
    override func viewDidLoad() {
        super.viewDidLoad()
			self.talkingModel = TalkingManager.sharedInstance.talkingModel
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
		guard let begin = self.beginTextField.text,
		let end = self.endTextField.text,
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
	
	@IBAction func changeToCurrentTime(sender: AnyObject) {
		let f = NSDateFormatter()
		f.dateFormat = "yyyy-MM-dd HH:mm:ss"
		let beginDate = NSDate(timeInterval: 60, sinceDate: NSDate())
		let endDate = NSDate(timeInterval: 3600, sinceDate: beginDate)
		self.beginTextField.text = f.stringFromDate(beginDate)
		self.endTextField.text = f.stringFromDate(endDate)
		
	}
	
	func fillDataForUI() {
		self.beginTextField.text = self.talkingModel.videoBeginString
		self.endTextField.text = self.talkingModel.videoEndString
		self.urlTextField.text = self.talkingModel.videoUrl
	}

	
}










