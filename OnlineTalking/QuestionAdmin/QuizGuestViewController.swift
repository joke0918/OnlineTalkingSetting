//
//  QuizGuestViewController.swift
//  OnlineTalking
//
//  Created by Yue Huang on 3/2/16.
//  Copyright © 2016 YeoHuang. All rights reserved.
//

import UIKit
import Alamofire

class QuizGuestViewController: UIViewController {

	@IBOutlet weak var titleTextField: UITextField!
	
	@IBOutlet weak var assginerTextField: UITextField!
	
	@IBOutlet weak var countTextField: UITextField!
	
	var guestListArray: [GuestModel] = []
	
	var committingQuestions: Int = 0 {
		didSet {
			if committingQuestions < oldValue {
				if committingQuestions == 0 {
					showAlertWithMessage("提问成功！") {
						[unowned self]
						action in
						self.navigationController!.popViewControllerAnimated(true)
					}
				}
			}
		}
	}
	
    override func viewDidLoad() {
        super.viewDidLoad()
			fillDataForUI()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
	
	@IBAction func confirmAction(sender: AnyObject) {
		askQuestions()
	}
	
	func askQuestions() {
		let count = Int(countTextField.text!)!
		committingQuestions = guestListArray.count * count
		for guestModel in guestListArray {
			let dic: [String: AnyObject] = [
				"talkingId": TalkingManager.sharedInstance.currentTalkingID,
				"title": titleTextField.text!,
				"assginerId": guestModel.guestId,
				"tags": []
			]
			
			for _ in 0 ..< count {
				request(.POST, "http://api.careerfrog.cn/api/qa/\(TalkingManager.sharedInstance.currentTalkingID)/question/ask", parameters: dic, encoding: .JSON, headers: nil).responseJSON() {
					response in
					guard response.result.isSuccess == true,
						let responseDic = response.result.value as? [String: AnyObject]
						else {
							debugPrint(response.result)
							return }
					
					guard responseDic["status"] as? String == "SUCCESS" else { return }
					self.committingQuestions--
				}
			}
		}
	}
	
	func fillDataForUI() {
		if guestListArray.count == 1 {
			assginerTextField.text = guestListArray[0].username
		} else {
			assginerTextField.text = "all"
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

}
