//
//  UpdateExamSettingViewController.swift
//  OnlineTalking
//
//  Created by Yue Huang on 1/15/16.
//  Copyright © 2016 YeoHuang. All rights reserved.
//

import UIKit
import Alamofire

class UpdateExamSettingViewController: UIViewController {

	@IBOutlet weak var contentTextView: UITextView!
	
	
	var talkingModel = TalkingManager.sharedInstance.talkingModel {
		didSet {
			self.fillDataForUI()
		}
	}
	
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
	
	@IBAction func confirmAction(sender: AnyObject) {
		let dic = [
			"content": self.contentTextView.text!
		]
		let urlString = "http://api.careerfrog.cn/api/talking-admin/talking/\(TalkingManager.sharedInstance.currentTalkingID)/exam"
		request(.PUT, urlString, parameters: dic, encoding: .JSON, headers: nil).responseJSON() {
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
	
	func fillDataForUI() {
		self.contentTextView.text = self.talkingModel.examContent
	}
}









