//
//  UpdateTalkingIndexSettingsViewController.swift
//  OnlineTalking
//
//  Created by YeoHuang on 1/14/16.
//  Copyright © 2016 YeoHuang. All rights reserved.
//

import UIKit
import Alamofire

class UpdateTalkingIndexSettingsViewController: UIViewController {

  @IBOutlet weak var bgImageUrlTextField: UITextField!
  @IBOutlet weak var videoBgImageUrlTextField: UITextField!
  @IBOutlet weak var introductionSwitch: UISwitch!
  @IBOutlet weak var introductionNameTextField: UITextField!
	var talkingModel: TalkingModel!
  
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
    let result = self.generateParameters()
    if !result.isSuccess {
      return
    }
    let urlString = "http://api.careerfrog.cn/api/talking-admin/talking/\(TalkingManager.sharedInstance.currentTalkingID)/index"
    request(.PUT, urlString, parameters: result.dic, encoding: .JSON, headers: nil).responseJSON() {
      response in
      guard response.result.isSuccess == true,
        let responseDic = response.result.value as? [String: AnyObject]
        else {
          debugPrint(response.result)
          return }
      
      guard responseDic["status"] as? String == "SUCCESS" else { return }
      dispatch_async(dispatch_get_main_queue()) {
        self.navigationController!.popViewControllerAnimated(true)
      }
    }
    
  }
  
  func generateParameters() -> (dic: [String: AnyObject], isSuccess: Bool) {
    let dic: [String: AnyObject] = [
      "bgImageUrl": self.bgImageUrlTextField.text!,
      "videoBgImageUrl": self.videoBgImageUrlTextField.text!,
      "introduction": self.introductionSwitch.on,
      "introductionName": self.introductionNameTextField.text!
    ]
    return (dic, true)
  }
  
  func fillDataForUI() {
    self.bgImageUrlTextField.text = self.talkingModel.indexBgImageUrl
		self.videoBgImageUrlTextField.text = self.talkingModel.indexVideoBgImageUrl
		self.introductionSwitch.on = self.talkingModel.indexIntroduction
		self.introductionNameTextField.text = self.talkingModel.indexIntroductionName
		
  }
  
}













