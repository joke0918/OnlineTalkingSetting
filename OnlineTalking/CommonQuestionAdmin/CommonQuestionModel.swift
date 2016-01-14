//
//  CommonQuestionModel.swift
//  OnlineTalking
//
//  Created by YeoHuang on 1/12/16.
//  Copyright © 2016 YeoHuang. All rights reserved.
//

import UIKit

class CommonQuestionModel: NSObject {
  var questionId: String = ""
  var title: String = ""
  var answerContent: String = ""
  var order: Int = 0
  var tags: [String] = []
  var tagsString: String = ""
  
  init(dic: [String: AnyObject]?) {
    super.init()
    guard let tempDic = dic,
      let questionId = tempDic["questionId"] as? String,
      let title = tempDic["title"] as? String,
      let answerContent = tempDic["answerContent"] as? String,
      let order = tempDic["order"] as? Int,
      let tags = tempDic["tags"] as? [String]
      else { return  }
    
    self.questionId = questionId
    self.title = title
    self.answerContent = answerContent
    self.order = order
    self.tags = tags
    
    if tags.count > 0 {
      self.tagsString = tags.joinWithSeparator(",")
    }
  }
  
  
  
}
