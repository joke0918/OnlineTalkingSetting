//
//  ExamModel.swift
//  OnlineTalking
//
//  Created by YeoHuang on 1/13/16.
//  Copyright © 2016 YeoHuang. All rights reserved.
//

import UIKit

class ExamModel: NSObject {
  var examId: String = ""
  var question: String = ""
  var answer1: String = ""
  var answer2: String = ""
  var answer3: String = ""
  var answer4: String = ""
  var correctAnswer: String = ""
  var winnerQuantity: Int = 0
  var minutes: Int = 0
  var seconds: Int = 0
  var beginTime: NSTimeInterval = 0
  var beginTimeString: String = ""

  init(dic: [String: AnyObject]?) {
    super.init()
    
    guard let examDic = dic,
      let examId = examDic["examId"] as? String,
      let question = examDic["question"] as? String,
      let winnerQuantity = examDic["winnerQuantity"] as? Int,
      let beginTime = examDic["beginTime"] as? Double else { return }
    
    self.examId = examId
    self.question = question
    if let answer1 = examDic["answer1"] as? String {
      self.answer1 = answer1
    }
    if let answer2 = examDic["answer2"] as? String {
      self.answer2 = answer2
    }
    if let answer3 = examDic["answer3"] as? String {
      self.answer3 = answer3
    }
    if let answer4 = examDic["answer4"] as? String {
      self.answer4 = answer4
    }
    self.winnerQuantity = winnerQuantity
    self.beginTime = beginTime
    
    let f = NSDateFormatter()
    f.dateFormat = "yyyy-MM-dd HH:mm:ss"
    let date = NSDate(timeIntervalSince1970: beginTime / 1000)
    self.beginTimeString = f.stringFromDate(date)

  }

}







