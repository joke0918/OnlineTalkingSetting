//
//  ExamListViewController.swift
//  OnlineTalking
//
//  Created by YeoHuang on 1/13/16.
//  Copyright © 2016 YeoHuang. All rights reserved.
//

import UIKit
import Alamofire

class ExamListViewController: UITableViewController {

  var examListArray: [ExamModel] = []
  var committingExamCount: Int = 0 {
    didSet {
      if committingExamCount < oldValue {
        if committingExamCount == 0 {
          self.getExamList()
        }
      }
    }
  }
  
    override func viewDidLoad() {
        super.viewDidLoad()
      self.tableView.estimatedRowHeight = 150

			let removeAllButton = UIButton(type: .System)
			removeAllButton.frame = CGRectMake(0, 0, ScreenWidth, 40)
			removeAllButton.setTitle("一键清空", forState: .Normal)
			removeAllButton.addTarget(self, action: "deleteAllExamsAction:", forControlEvents: .TouchUpInside)
			self.tableView.tableHeaderView = removeAllButton
    }

  override func viewWillAppear(animated: Bool) {
    super.viewWillAppear(animated)
    self.getExamList()
  }
  
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

  



  

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */


    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
      guard let segueIdentifier = segue.identifier,
        let vc = segue.destinationViewController as? UpdateExamViewController
      else { return }
      if segueIdentifier == "Update" {
        guard let indexPath = self.tableView.indexPathForSelectedRow else { return }
        vc.examModel = self.examListArray[indexPath.row]
      } else {
        
      }
    }


	func deleteAllExamsAction(sender: AnyObject) {
		self.showAlertWithMessage("确定删除所有抢答题？") {
			[unowned self]
			action in
			self.deleteAllExams()
		}
	}
	
	@IBAction func cleanExam(sender: AnyObject) {
		let urlString = "http://api.careerfrog.cn/api/exam-admin/\(TalkingManager.sharedInstance.currentTalkingID)/clean"
		request(.DELETE, urlString, parameters: nil, encoding: .JSON, headers: nil).responseJSON() {
			response in
			guard response.result.isSuccess == true,
				let responseDic = response.result.value as? [String: AnyObject]
				else {
					debugPrint(response.result)
					return }
			
			guard responseDic["status"] as? String == "SUCCESS" else { return }
			dispatch_async(dispatch_get_main_queue()) {
				self.showAlertWithMessage("清除直通券获奖名单成功")
			}
		}
	}
	
  @IBAction func addLocalExams(sender: AnyObject) {
    guard let filePath = NSBundle.mainBundle().pathForResource("Exam.json", ofType: nil),
      let data = NSData(contentsOfFile: filePath)
      //      let array = NSArray(contentsOfFile: filePath)
      else { return }
    
    do {
      let array: [[String: AnyObject]] = try NSJSONSerialization.JSONObjectWithData(data, options: .MutableContainers) as! [[String : AnyObject]]
      self.createExams(examArray: array)
    } catch {
      debugPrint("本地Json读取失败")
    }
  }
  
  private func getExamList() {
    let urlString = "http://api.careerfrog.cn/api/exam/\(TalkingManager.sharedInstance.currentTalkingID)/exams"
    request(.GET, urlString, parameters: nil, encoding: .JSON, headers: nil).responseJSON() {
      response in
      guard response.result.isSuccess == true,
        let responseDic = response.result.value as? [String: AnyObject]
        else {
          debugPrint(response.result)
          return }
      
      guard responseDic["status"] as? String == "SUCCESS",
        let array = responseDic["result"] as? [[String: AnyObject]]
        else {
					debugPrint(responseDic)
					return
			}
      self.examListArray.removeAll()
      for examDic in array {
        let model = ExamModel(dic: examDic)
        self.examListArray.append(model)
      }
      dispatch_async(dispatch_get_main_queue()) {
        self.tableView.reloadData()
      }
    }
  }
  
  private func deleteEaxm(examId: String) {
    guard examId != "" else {
      debugPrint("exmaId 不能为空")
      return
    }
    let urlString = "http://api.careerfrog.cn/api/exam-admin/\(TalkingManager.sharedInstance.currentTalkingID)/\(examId)"
    request(.DELETE, urlString, parameters: nil, encoding: .JSON, headers: nil).responseJSON() {
      response in
      guard response.result.isSuccess == true,
        let responseDic = response.result.value as? [String: AnyObject]
        else {
          debugPrint(response.result)
          return }
      
      guard responseDic["status"] as? String == "SUCCESS" else { return }
      dispatch_async(dispatch_get_main_queue()) {
        self.getExamList()
      }
    }
  }
	
	func deleteAllExams() {
		dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)){
			[unowned self] in
			self.committingExamCount = self.examListArray.count
			for examModel in self.examListArray {
				NSThread.sleepForTimeInterval(0.1)
				let urlString = "http://api.careerfrog.cn/api/exam-admin/\(TalkingManager.sharedInstance.currentTalkingID)/\(examModel.examId)"
    
				request(.DELETE, urlString, parameters: nil, encoding: .JSON, headers: nil).responseJSON() {
					response in
					
					self.committingExamCount--
					
					
				}
			}
		}
	}
	
  private func createExams(examArray array: [[String: AnyObject]]) {
    self.committingExamCount = array.count
    for dic in array {
      NSThread.sleepForTimeInterval(0.1)
      let urlString = "http://api.careerfrog.cn/api/exam-admin/\(TalkingManager.sharedInstance.currentTalkingID)/add"
      request(.POST, urlString, parameters: dic, encoding: .JSON, headers: nil).responseJSON() {
        response in
        guard response.result.isSuccess == true,
          let responseDic = response.result.value as? [String: AnyObject]
          else {
            debugPrint(response.result)
            return
				}
        
        guard responseDic["status"] as? String == "SUCCESS" else { return }
        self.committingExamCount--
      }
    }
  }
  
  
}

extension ExamListViewController {
  
}

extension ExamListViewController {
  // MARK: - Table view data source
  
  override func tableView(tableView: UITableView, editingStyleForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCellEditingStyle {
    return .Delete
  }
  
  override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
    if editingStyle == .Delete {
      // Delete the row from the data source
      let examModel = self.examListArray[indexPath.row]
      self.deleteEaxm(examModel.examId)
    } else if editingStyle == .Insert {
      // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }
  }
  
  override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    // #warning Incomplete implementation, return the number of sections
    return 1
  }
  
  override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    // #warning Incomplete implementation, return the number of rows
    return self.examListArray.count
  }

  override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
  let cell = tableView.dequeueReusableCellWithIdentifier("ExamListCell", forIndexPath: indexPath) as! ExamListCell
    if self.examListArray.count != 0 {
      cell.examModel = self.examListArray[indexPath.row]
    }
  
  // Configure the cell...
  
  return cell
  }

}



