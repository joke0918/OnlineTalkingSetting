//
//  CommonQuestionListViewController.swift
//  OnlineTalking
//
//  Created by YeoHuang on 1/12/16.
//  Copyright © 2016 YeoHuang. All rights reserved.
//

import UIKit
import Alamofire

class CommonQuestionListViewController: UITableViewController {

  var commonQuestionListArray: [CommonQuestionModel] = []
  var commitQuestionCount: Int = 0 {
    didSet {
      if commitQuestionCount < oldValue {
        if commitQuestionCount == 0 {
          self.getCommonQuestions()
        }
      }
    }
  }
  
    override func viewDidLoad() {
        super.viewDidLoad()
      self.tableView.estimatedRowHeight = 110
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

  override func viewWillAppear(animated: Bool) {
    super.viewWillAppear(animated)
    self.getCommonQuestions()
  }
  
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

  
  // MARK: - Navigation
  
  // In a storyboard-based application, you will often want to do a little preparation before navigation
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
    guard let destinationVC = segue.destinationViewController as? UpdateCommonQuestionViewController
      else { return }
    if segue.identifier! == "Update" {
      guard let indexPath = self.tableView.indexPathForSelectedRow else { return }
      destinationVC.commonQuestionModel = self.commonQuestionListArray[indexPath.row]
    } else {
      
    }

  }
  
  @IBAction func addLocalCommonQuestionsAction(sender: AnyObject) {
    guard let filePath = NSBundle.mainBundle().pathForResource("CommonQuestion.json", ofType: nil),
      let data = NSData(contentsOfFile: filePath)
//      let array = NSArray(contentsOfFile: filePath)
    else { return }
    
    do {
      let array: [[String: AnyObject]] = try NSJSONSerialization.JSONObjectWithData(data, options: .MutableContainers) as! [[String : AnyObject]]
      self.addLocalCommonQuestion(questionArray: array)
    } catch {
      debugPrint("本地Json读取失败")
    }
    
//    for dic in array {
//      debugPrint(dic)
//    }
    
  }
  
  // MARK: - Table view delegate
  
  override func tableView(tableView: UITableView, editingStyleForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCellEditingStyle {
    return .Delete
  }
  
  override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
    guard editingStyle == .Delete else { return }
    let model = self.commonQuestionListArray[indexPath.row]
    self.deleteCommonQuestion(model.questionId)
  }

  
    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.commonQuestionListArray.count
    }

  
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("CommonQuestionCell", forIndexPath: indexPath) as! CommonQuestionCell
      if self.commonQuestionListArray.count > indexPath.row {
        cell.commonQuestionModel = self.commonQuestionListArray[indexPath.row]
      }
        // Configure the cell...

        return cell
    }
  
  private func getCommonQuestions() {
    let urlString = "http://api.careerfrog.cn/api/qa/376D71EA-858A081C/com-questions"
    request(.GET, urlString, parameters: nil, encoding: .JSON, headers: nil).responseJSON() {
      response in
      guard response.result.isSuccess == true,
        let responseDic = response.result.value as? [String: AnyObject]
        else {
          debugPrint(response.result)
          return }
      
      guard responseDic["status"] as? String == "SUCCESS",
      let array = responseDic["result"] as? [[String: AnyObject]]
      else { return }
      
      self.commonQuestionListArray.removeAll()
      for questionDic in array {
        let questionModel = CommonQuestionModel(dic: questionDic)
        self.commonQuestionListArray.append(questionModel)
      }
      dispatch_async(dispatch_get_main_queue()) {
        self.tableView.reloadData()
      }
    }
  }

  func deleteCommonQuestion(questionId: String) {
    let urlString = "http://api.careerfrog.cn/api/comm-qa-admin/376D71EA-858A081C/\(questionId)"
    request(.DELETE, urlString, parameters: nil, encoding: .JSON, headers: nil).responseJSON() {
      response in
      guard response.result.isSuccess == true,
        let responseDic = response.result.value as? [String: AnyObject]
        else {
          debugPrint(response.result)
          return }
      
      guard responseDic["status"] as? String == "SUCCESS" else { return }
      dispatch_async(dispatch_get_main_queue()) {
        self.getCommonQuestions()
      }
    }
  }

  func addLocalCommonQuestion(questionArray array: [[String: AnyObject]]) {

    self.commitQuestionCount = array.count
    for dic in array {
      NSThread.sleepForTimeInterval(0.1)
      let urlString = "http://api.careerfrog.cn/api/comm-qa-admin/376D71EA-858A081C/add"
      request(.POST, urlString, parameters: dic, encoding: .JSON, headers: nil).responseJSON() {
        response in
        guard response.result.isSuccess == true,
          let responseDic = response.result.value as? [String: AnyObject]
          else {
            debugPrint(response.result)
            return }
        
        guard responseDic["status"] as? String == "SUCCESS" else { return }
        self.commitQuestionCount--
        

      }
      
    }
    
  }
  


}
