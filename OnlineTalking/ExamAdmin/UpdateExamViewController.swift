//
//  UpdateExamViewController.swift
//  OnlineTalking
//
//  Created by YeoHuang on 1/13/16.
//  Copyright © 2016 YeoHuang. All rights reserved.
//

import UIKit
import Alamofire

class UpdateExamViewController: UIViewController {

  @IBOutlet weak var questionTextField: UITextField!
  @IBOutlet weak var answer1TextField: UITextField!
  @IBOutlet weak var answer2TextField: UITextField!
  @IBOutlet weak var answer3TextField: UITextField!
  @IBOutlet weak var answer4TextField: UITextField!
  @IBOutlet weak var correctAnswerTextField: UITextField!
  @IBOutlet weak var winnerQuantityTextField: UITextField!
  @IBOutlet weak var minutesTextField: UITextField!
  @IBOutlet weak var secondsTextField: UITextField!

  var examModel: ExamModel = {
    let model = ExamModel(dic: nil)
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
    guard let question = self.questionTextField.text,
      let winnerQuantity = self.winnerQuantityTextField.text,
      let correctAnswer = self.correctAnswerTextField.text,
      let minutes = self.minutesTextField.text,
      let seconds = self.secondsTextField.text else { return }
    var dic: [String: AnyObject] = [
      "question": question,
      "winnerQuantity": Int(winnerQuantity)!,
      "correctAnswer": correctAnswer,
      "minutes": Int(minutes)!,
      "seconds": Int(seconds)!
    ]
    if self.answer1TextField.text != "" {
      dic["answer1"] = self.answer1TextField.text!
    }
    if self.answer2TextField.text != "" {
      dic["answer2"] = self.answer2TextField.text!
    }
    if self.answer3TextField.text != "" {
      dic["answer3"] = self.answer3TextField.text!
    }
    if self.answer4TextField.text != "" {
      dic["answer4"] = self.answer4TextField.text!
    } 
    
    if self.examModel.examId == "" {
      self.createEaxm(dic)
    } else {
      self.updateEaxm(dic)
    }
  }
  
  private func createEaxm(dic: [String: AnyObject]) {
    let urlString = "http://api.careerfrog.cn/api/exam-admin/376D71EA-858A081C/add"
    request(.POST, urlString, parameters: dic, encoding: .JSON, headers: nil).responseJSON() {
      response in
			guard response.result.isSuccess == true,
				let responseDic = response.result.value as? [String: AnyObject]
				else {
					debugPrint(response.result)
					return
			}
			guard responseDic["status"] as? String == "SUCCESS" else {
				debugPrint(responseDic)
				return
			}
      dispatch_async(dispatch_get_main_queue()) {
        self.navigationController!.popViewControllerAnimated(true)
      }
    }
  }
  
  private func updateEaxm(dic: [String: AnyObject]) {
    let urlString = "http://api.careerfrog.cn/api/exam-admin/376D71EA-858A081C/\(self.examModel.examId)"
    request(.PUT, urlString, parameters: dic, encoding: .JSON, headers: nil).responseJSON() {
      response in
			guard response.result.isSuccess == true,
				let responseDic = response.result.value as? [String: AnyObject]
				else {
					debugPrint(response.result)
					return
			}
			guard responseDic["status"] as? String == "SUCCESS" else {
				debugPrint(responseDic)
				return
			}
      dispatch_async(dispatch_get_main_queue()) {
        self.navigationController!.popViewControllerAnimated(true)
      }
    }
  }
  
  func fillDataForUI() {
    guard self.examModel.examId != "" else { return }
    self.questionTextField.text = self.examModel.question
    self.answer1TextField.text = self.examModel.answer1
    self.answer2TextField.text = self.examModel.answer2
    self.answer3TextField.text = self.examModel.answer3
    self.answer4TextField.text = self.examModel.answer4
    self.correctAnswerTextField.text = self.examModel.correctAnswer
    self.winnerQuantityTextField.text = "\(self.examModel.winnerQuantity)"
    self.minutesTextField.text = "\(self.examModel.minutes)"
    self.secondsTextField.text = "\(self.examModel.seconds)"
  }
  
}








