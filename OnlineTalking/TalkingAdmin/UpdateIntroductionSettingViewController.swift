//
//  UpdateIntroductionSettingViewController.swift
//  OnlineTalking
//
//  Created by Yue Huang on 1/15/16.
//  Copyright © 2016 YeoHuang. All rights reserved.
//

import UIKit
import Alamofire

class UpdateIntroductionSettingViewController: UIViewController {

	@IBOutlet weak var headerTextView: UITextView!
	@IBOutlet weak var contentTextView: UITextView!
	@IBOutlet weak var footerTextView: UITextView!

	var talkingModel: TalkingModel! {
		didSet {
			self.fillDataForUI()
		}
	}
    override func viewDidLoad() {
        super.viewDidLoad()
			self.talkingModel = TalkingManager.sharedInstance.talkingModel
			
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
		let urlString = "http://api.careerfrog.cn/api/talking-admin/talking/\(TalkingManager.sharedInstance.currentTalkingID)/intro"
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
					[unowned self]
					action in
					self.navigationController!.popViewControllerAnimated(true)
				}
			}
		}
	}
	
	func fillDataForUI() {
		self.headerTextView.text = self.talkingModel.introHeader
		self.contentTextView.text = self.talkingModel.introContent
		self.footerTextView.text = self.talkingModel.introFooter
	}
	
	func generateParameters() -> (parameters: [String: AnyObject]?, isSuccess: Bool) {
		guard let header = self.headerTextView.text,
			let content = self.contentTextView.text,
			let footer = self.footerTextView.text else {
				return (nil, false)
		}
		let dic = [
			"header": header,
			"content": content,
			"footer": footer
		]
		return (dic, true)
	}
	
}









