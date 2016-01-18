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
		let backHomeButton = UIButton(type: .Custom)
		backHomeButton.frame = CGRectMake(0, 0, UIScreen.mainScreen().bounds.size.width, 45)
		backHomeButton.setTitle("返回主页", forState: .Normal)
		backHomeButton.setTitleColor(UIColor.blackColor(), forState: .Normal)
		backHomeButton.addTarget(self, action: "backHomeAction:", forControlEvents: .TouchUpInside)
		self.tableView.tableHeaderView = backHomeButton
	}
	
	override func viewWillAppear(animated: Bool) {
		super.viewWillAppear(animated)
		self.getTalkingDetails()

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
	
	func backHomeAction(sender: AnyObject) {
		self.navigationController!.popToRootViewControllerAnimated(true)
	}
	
	
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





