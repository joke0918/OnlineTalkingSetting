//
//  TalkingSettingListViewController.swift
//  OnlineTalkSetting
//
//  Created by Yue Huang on 1/11/16.
//  Copyright © 2016 Yue Huang. All rights reserved.
//

import UIKit
import Alamofire

class TalkingSettingListViewController: UITableViewController {
	
	override func viewDidLoad() {
		super.viewDidLoad()
		// Uncomment the following line to preserve selection between presentations
		// self.clearsSelectionOnViewWillAppear = false
		
		// Uncomment the following line to display an Edit button in the navigation bar for this view controller.
		// self.navigationItem.rightBarButtonItem = self.editButtonItem()
	}
	
	override func viewWillAppear(animated: Bool) {
		super.viewWillAppear(animated)
		self.getTalkingDetails()

	}
	
	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}
	
	// MARK: - Table view delegate
//	override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//		var title = ""
//		switch section {
//		case 0:
//			// TalkingAdmin
//			title = "TalkingAdmin"
//		case 1:
//			// Talking
//			title = "Talking"
//		case 2:
//			// TalkingGuestAdmin
//			title = "TalkingGuestAdmin"
//		case 3:
//			// ExamAdmin
//			title = "ExamAdmin"
//		case 4:
//			// CommonQuestionAdmin
//			title = "CommonQuestionAdmin"
//		case 5:
//			// TalkingTemplate
//			title = "TalkingTemplate"
//		default:
//			title = ""
//		}
//		return title
//	}
	
//	override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//		return 20.0
//	}
	
	// MARK: - Table view data source
	
//	override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
//		// #warning Incomplete implementation, return the number of sections
//		return 5
//	}
	
//	override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//		// #warning Incomplete implementation, return the number of rows
//		var rows = 1
//		switch section {
//		case 0:
//			// TalkingAdmin
//			rows = 1
//		case 1:
//			// Talking
//			rows = 1
//		case 2:
//			// TalkingGuestAdmin
//			rows = 1
//		case 3:
//			// ExamAdmin
//			rows = 1
//		case 4:
//			// CommonQuestionAdmin
//			rows = 1
	
//		case 5:
//			// TalkingTemplate
//			rows = 1
//		default:
//			rows = 0
//		}
//		return rows
//	}
	
	
//	override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
//		let cell = tableView.dequeueReusableCellWithIdentifier("TalkingSettingListCell", forIndexPath: indexPath)
//		
//		// Configure the cell...
//		
//		return cell
//	}
	
	
	/*
	// Override to support conditional editing of the table view.
	override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
	// Return false if you do not want the specified item to be editable.
	return true
	}
	*/
	
	/*
	// Override to support editing the table view.
	override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
	if editingStyle == .Delete {
	// Delete the row from the data source
	tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
	} else if editingStyle == .Insert {
	// Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
	}
	}
	*/
	
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
	
	/*
	// MARK: - Navigation
	
	// In a storyboard-based application, you will often want to do a little preparation before navigation
	override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
	// Get the new view controller using segue.destinationViewController.
	// Pass the selected object to the new view controller.
	}
	*/
	
	func getTalkingDetails() {
		let urlString = "http://api.careerfrog.cn/api/talking/\(TalkingManager.sharedInstance.currentTalkingID)/details"
		request(.GET, urlString, parameters: nil, encoding: .JSON, headers: nil).responseJSON() {
			response in
			guard response.result.isSuccess == true else {
				debugPrint(response.result)
				return
			}
			
			guard let responseDic = response.result.value as? [String: AnyObject] else {
				return
			}
			
			guard responseDic["status"] as? String == "SUCCESS",
				let resultDic = responseDic["result"] as? [String: AnyObject] else { return }
			let talkingModel = TalkingModel(dic: resultDic)
			TalkingManager.sharedInstance.talkingModel = talkingModel
		}
	}
	
}







