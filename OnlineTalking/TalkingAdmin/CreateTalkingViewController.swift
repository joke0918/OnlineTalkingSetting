//
//  CreateTalkingViewController.swift
//  OnlineTalking
//
//  Created by YeoHuang on 1/13/16.
//  Copyright © 2016 YeoHuang. All rights reserved.
//

import UIKit
import Alamofire

class CreateTalkingViewController: UIViewController {

  @IBOutlet weak var companyIdTextField: UITextField!
  @IBOutlet weak var nameTextField: UITextField!
  @IBOutlet weak var shortNameTextField: UITextField!
  @IBOutlet weak var beginTextField: UITextField!
  @IBOutlet weak var endTextField: UITextField!

  
    override func viewDidLoad() {
        super.viewDidLoad()
			guard TalkingManager.sharedInstance.currentCompanyID != "" else {
				self.showAlertWithMessage("CompanyId不能为空")
				return
			}
      self.companyIdTextField.text = TalkingManager.sharedInstance.currentCompanyID
      
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
  
  @IBAction func confirmAction(sender: AnyObject) {
    guard let companyId = companyIdTextField.text,
      let name = nameTextField.text,
      let shortName = shortNameTextField.text,
      let begin = beginTextField.text,
      let end = endTextField.text else { return }
    
    let dic = [
      "companyId": companyId,
      "name": name,
      "shortName": shortName,
      "begin": begin,
      "end": end
    ]
    let urlString = "http://api.careerfrog.cn/api/talking-admin/create-talking"
    request(.POST, urlString, parameters: dic, encoding: .JSON, headers: nil).responseJSON() {
      response in
      guard response.result.isSuccess == true,
        let responseDic = response.result.value as? [String: AnyObject]
        else {
          debugPrint(response.result)
          return }
      
      guard responseDic["status"] as? String == "SUCCESS" else { return }
      dispatch_async(dispatch_get_main_queue()) {
				self.dismissViewControllerAnimated(true, completion: nil)
      }
    }
    
  }

	@IBAction func backAction(sender: AnyObject) {
		self.dismissViewControllerAnimated(true, completion: nil)
	}
  
  @IBAction func currentTimeAction(sender: AnyObject) {
    let f = NSDateFormatter()
    f.dateFormat = "yyyy-MM-dd HH:mm:ss"
    let date = NSDate()
    self.beginTextField.text = f.stringFromDate(date)
    self.endTextField.text = f.stringFromDate(date)
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















