//
//  UpdateQuestionnaireSettingViewController.swift
//  OnlineTalking
//
//  Created by Yue Huang on 1/15/16.
//  Copyright © 2016 YeoHuang. All rights reserved.
//

import UIKit
import Alamofire

class UpdateQuestionnaireSettingViewController: UIViewController {

	@IBOutlet weak var urlTextField: UITextField!
	
	@IBOutlet weak var mobileUrlTextField: UITextField!
	
	var talkingModel = TalkingManager.sharedInstance.talkingModel
	
	let defaultUrl = "https://jinshuju.net/f/2CM1hX"
	
    override func viewDidLoad() {
        super.viewDidLoad()
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

	@IBAction func confirmAction(sender: AnyObject) {
		let dic = [
			"url": self.urlTextField.text!,
			"mobileUrl": self.mobileUrlTextField.text!
		]
		let urlString = "http://api.careerfrog.cn/api/talking-admin/talking/\(TalkingManager.sharedInstance.currentTalkingID)/questionnaire"
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
					[unowned self]
					action in
					self.navigationController!.popViewControllerAnimated(true)
				}
			}
		}
	}
	
	func fillDataForUI() {
		
		if talkingModel.questionnaireUrl != "" {
			self.urlTextField.text = self.talkingModel.questionnaireUrl
			self.mobileUrlTextField.text = self.talkingModel.questionnaireMobileUrl
			
		} else {
			self.urlTextField.text = defaultUrl
			self.mobileUrlTextField.text = defaultUrl
		}
	}
	
}





