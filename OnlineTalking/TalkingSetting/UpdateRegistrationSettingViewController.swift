//
//  UpdateRegistrationSettingViewController.swift
//  OnlineTalking
//
//  Created by Yue Huang on 1/14/16.
//  Copyright © 2016 YeoHuang. All rights reserved.
//

import UIKit
import Alamofire

class UpdateRegistrationSettingViewController: UIViewController {

	@IBOutlet weak var professionSwitch: UISwitch!
	@IBOutlet weak var applyNumberSwitch: UISwitch!
	@IBOutlet weak var abroadSwitch: UISwitch!

	
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
		let result = self.generateParameters()
		if !result.isSuccess {
			return
		}
		let urlString = "http://api.careerfrog.cn/api/talking-admin/talking/\(TalkingManager.sharedInstance.currentTalkingID)/registration"
		request(.PUT, urlString, parameters: result.parameters, encoding: .JSON, headers: nil).responseJSON() {
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
	
	func generateParameters() -> (parameters: [String: AnyObject], isSuccess: Bool) {
		var fieldsArray: [String] = []
		if self.professionSwitch.on {
			fieldsArray.append("profession")
		}
		if self.applyNumberSwitch.on {
			fieldsArray.append("applyNumber")
		}
		if self.abroadSwitch.on {
			fieldsArray.append("abroad")
		}
		
		if fieldsArray.count == 0 {
			fieldsArray.append("")
		}
		
		let parameters = [
			"fields": fieldsArray
		]
		debugPrint(parameters)
		return (parameters, true)
	}
	
}






