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
		if self.traitCollection.forceTouchCapability == .Available {
			self.registerForPreviewingWithDelegate(self, sourceView: view)
		}
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
	
	@IBAction func openInSafariAction(sender: AnyObject) {
		UIApplication.sharedApplication().openURL(NSURL(string: TalkingManager.sharedInstance.talkingModel.domainUrl)!)
	}
	
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

extension TalkingSettingListViewController: UIViewControllerPreviewingDelegate {
	func previewingContext(previewingContext: UIViewControllerPreviewing, viewControllerForLocation location: CGPoint) -> UIViewController? {
		guard let indexPath = self.tableView.indexPathForRowAtPoint(location),
			let cell = self.tableView.cellForRowAtIndexPath(indexPath)
		else { return nil }
		
		if indexPath.section == 0 && indexPath.row == 6 {
			
			let identifer = "UpdateVideoSettingViewController"
			let talkingStoryboard = UIStoryboard(name: "TalkingSetting", bundle: nil)
			guard let vc = talkingStoryboard.instantiateViewControllerWithIdentifier(identifer) as? UpdateVideoSettingViewController else { return nil }
			let frame = cell.frame
			previewingContext.sourceRect = frame
			return vc
		}
		
		if indexPath.section == 1 && indexPath.row == 0 {
			let identifer = "TalkingDetailsViewController"
			let talkingStoryboard = UIStoryboard(name: "Talking", bundle: nil)
			guard let vc = talkingStoryboard.instantiateViewControllerWithIdentifier(identifer) as? TalkingDetailsViewController else { return nil }
			let frame = cell.frame
			previewingContext.sourceRect = frame
			return vc
		}
		
		if indexPath.section == 2 && indexPath.row == 0 {
			let identifer = "GuestListViewController"
			let talkingStoryboard = UIStoryboard(name: "TalkingGuestAdmin", bundle: nil)
			guard let vc = talkingStoryboard.instantiateViewControllerWithIdentifier(identifer) as? GuestListViewController else { return nil }
			let frame = cell.frame
			previewingContext.sourceRect = frame
			return vc
		}
		return nil

	}
	
	func previewingContext(previewingContext: UIViewControllerPreviewing, commitViewController viewControllerToCommit: UIViewController) {
		self.showViewController(viewControllerToCommit, sender: self)
	}
	
}







