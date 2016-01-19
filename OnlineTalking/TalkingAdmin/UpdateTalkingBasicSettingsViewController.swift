//
//  UpdateTalkingBasicSettingsViewController.swift
//  OnlineTalking
//
//  Created by YeoHuang on 1/13/16.
//  Copyright © 2016 YeoHuang. All rights reserved.
//

import UIKit
import Alamofire

class UpdateTalkingBasicSettingsViewController: UIViewController {

  @IBOutlet weak var nameTextField: UITextField!
  @IBOutlet weak var shortNameTextField: UITextField!
  @IBOutlet weak var beginTextField: UITextField!
  @IBOutlet weak var endTextField: UITextField!
  @IBOutlet weak var domainUrlTextField: UITextField!
  @IBOutlet weak var applyUrlTextField: UITextField!
  @IBOutlet weak var mobileApplyUrlTextField: UITextField!
	
	@IBOutlet weak var datePickerView: UIView!
	
	@IBOutlet weak var datePicker: UIDatePicker!
	var talkingModel: TalkingModel!
  
    override func viewDidLoad() {
        super.viewDidLoad()
			self.talkingModel = TalkingManager.sharedInstance.talkingModel
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
  
  override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
    self.view.endEditing(true)
		if !self.datePickerView.hidden {
			UIView.animateWithDuration(0.5) {
				self.datePickerView.hidden = true
			}
		}
  }
  
  @IBAction func confirmAction(sender: AnyObject) {
    
    let result = self.generateParameters()
    if !result.isSuccess {
      return
    }
    
    let urlString = "http://api.careerfrog.cn/api/talking-admin/talking/\(TalkingManager.sharedInstance.currentTalkingID)/basic"
    request(.PUT, urlString, parameters: result.dic, encoding: .JSON, headers: nil).responseJSON() {
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
  
  @IBAction func currentTimeAction(sender: AnyObject) {
    let f = NSDateFormatter()
    f.dateFormat = "yyyy-MM-dd HH:mm:ss"
    let date = NSDate()
    self.beginTextField.text = f.stringFromDate(date)
    self.endTextField.text = f.stringFromDate(date)
  }
	
	@IBAction func datePickerViewConfirmAction(sender: AnyObject) {
		let f = NSDateFormatter()
		f.dateFormat = "yyyy-MM-dd HH:mm:ss"
		let date = f.stringFromDate(self.datePicker.date)
		if self.beginTextField.isFirstResponder() {
			self.beginTextField.text = date
		}
		if self.endTextField.isFirstResponder() {
			self.endTextField.text = date
		}
		UIView.animateWithDuration(0.5) {
			self.datePickerView.hidden = true
		}
	}
	
  func fillDataForUI() {
    self.nameTextField.text = self.talkingModel.name
		self.shortNameTextField.text = self.talkingModel.shortName
		self.beginTextField.text = self.talkingModel.beginTimeString
		self.endTextField.text = self.talkingModel.endTimeString
		self.domainUrlTextField.text = self.talkingModel.domainUrl
		self.applyUrlTextField.text = self.talkingModel.applyUrl
		self.mobileApplyUrlTextField.text = self.talkingModel.mobileApplyUrl
  }
  
  private func generateParameters() -> (dic: [String: AnyObject]?, isSuccess: Bool) {
    guard let name = nameTextField.text,
      let shortName = shortNameTextField.text,
      let begin = beginTextField.text,
      let end = endTextField.text,
      let domainUrl = domainUrlTextField.text,
      let applyUrl = applyUrlTextField.text,
      let mobileApplyUrl = mobileApplyUrlTextField.text else {
        return (nil, false)
    }
    
    let dic = [
      "name": name,
      "shortName": shortName,
      "begin": begin,
      "end": end,
      "domainUrl": domainUrl,
      "applyUrl": applyUrl,
      "mobileApplyUrl": mobileApplyUrl,
    ]
    return (dic, true)
  }
	
	func prepareData() {
		self.datePicker.minimumDate = NSDate()
		self.datePicker.maximumDate = NSDate(timeInterval: 365 * 24 * 60 * 60, sinceDate: NSDate())
	}
	
}

extension UpdateTalkingBasicSettingsViewController: UITextFieldDelegate {
	func textFieldDidBeginEditing(textField: UITextField) {
		if !self.datePickerView.hidden {
			return
		}
		UIView.animateWithDuration(0.5) {
			self.datePickerView.hidden = false
		}	}
}


















