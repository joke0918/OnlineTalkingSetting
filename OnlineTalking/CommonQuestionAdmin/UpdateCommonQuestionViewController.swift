//
//  UpdateCommonQuestionViewController.swift
//  OnlineTalking
//
//  Created by YeoHuang on 1/12/16.
//  Copyright © 2016 YeoHuang. All rights reserved.
//

import UIKit
import Alamofire

class UpdateCommonQuestionViewController: UIViewController {

  @IBOutlet weak var titleTextField: UITextField!
  @IBOutlet weak var contentTextField: UITextField!
  @IBOutlet weak var orderTextField: UITextField!
  @IBOutlet weak var tagsTextField: UITextField!

  var commonQuestionModel: CommonQuestionModel = {
    let model = CommonQuestionModel(dic: nil)
    return model
  }()
  
    override func viewDidLoad() {
        super.viewDidLoad()
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
    
    guard let title = self.titleTextField.text,
      let content = self.contentTextField.text,
      let order = self.orderTextField.text
      else {
        debugPrint("输入信息有误")
        return
    }
    
    var dic: [String: AnyObject] = [
      "title": title,
      "content": content,
      "order": Int(order)!
    ]
    
    if let tags = self.tagsTextField.text {
      if tags != "" {
        dic["tags"] = tags.componentsSeparatedByString(",")
      }
    }
    
    
    if self.commonQuestionModel.questionId == "" {
      self.createCommonQuestion(dic)
    } else {
      self.updateCommonQuestion(dic)
    }
  }
  
  func createCommonQuestion(dic: [String: AnyObject]) {
    let urlString = "http://api.careerfrog.cn/api/comm-qa-admin/\(TalkingManager.sharedInstance.currentTalkingID)/add"
    request(.POST, urlString, parameters: dic, encoding: .JSON, headers: nil).responseJSON() {
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
  
  func updateCommonQuestion(dic: [String: AnyObject]) {
    let urlString = "http://api.careerfrog.cn/api/comm-qa-admin/\(TalkingManager.sharedInstance.currentTalkingID)/\(self.commonQuestionModel.questionId)"
    request(.PUT, urlString, parameters: dic, encoding: .JSON, headers: nil).responseJSON() {
      response in
      guard response.result.isSuccess == true,
        let responseDic = response.result.value as? [String: AnyObject]
        else {
          debugPrint(response.result)
          return }
      debugPrint(responseDic)
      guard responseDic["status"] as? String == "SUCCESS" else { return }
      dispatch_async(dispatch_get_main_queue()) {
        self.navigationController!.popViewControllerAnimated(true)
      }
    }
  }
  
  func fillDataForUI() {
    guard self.commonQuestionModel.questionId != "" else { return }
    self.titleTextField.text = self.commonQuestionModel.title
    self.contentTextField.text = self.commonQuestionModel.answerContent
    self.orderTextField.text = "\(self.commonQuestionModel.order)"
    self.tagsTextField.text = self.commonQuestionModel.tagsString
  }
  
}






