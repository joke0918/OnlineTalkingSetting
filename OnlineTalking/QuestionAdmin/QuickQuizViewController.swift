//
//  QuickQuizViewController.swift
//  OnlineTalking
//
//  Created by Yue Huang on 3/2/16.
//  Copyright © 2016 YeoHuang. All rights reserved.
//

import UIKit
import Alamofire

class QuickQuizViewController: UITableViewController {

	var guestListArray: [GuestModel] = []

    override func viewDidLoad() {
        super.viewDidLoad()
			tableView.estimatedRowHeight = 90
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

	override func viewWillAppear(animated: Bool) {
		super.viewWillAppear(animated)
		self.getGuests()
	}
	
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


	override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
		guard let identifier = segue.identifier,
		let vc = segue.destinationViewController as? QuizGuestViewController
		else { return }
		if identifier == "QuizAllGuests" {
			vc.guestListArray = guestListArray
			
		} else {
			guard let indexPath = tableView.indexPathForSelectedRow else { return }
			let guest = guestListArray[indexPath.row]
			vc.guestListArray = [guest]
		}
	}
	
	func getGuests() {
		let urlString = "http://api.careerfrog.cn/api/guest-admin/\(TalkingManager.sharedInstance.currentTalkingID)/guests"
		request(.GET, urlString, parameters: nil, encoding: .JSON, headers: nil).responseJSON() {
			response in
			guard response.result.isSuccess == true,
				let responseDic = response.result.value as? [String: AnyObject]
				else {
					debugPrint(response.result)
					return }
			
			guard responseDic["status"] as? String == "SUCCESS",
				let resultArray = responseDic["result"] as? [[String: AnyObject]] else { return }
			self.guestListArray.removeAll()
			for guestDic in resultArray {
				let guestModel = GuestModel(dic: guestDic)
				self.guestListArray.append(guestModel)
			}
			dispatch_async(dispatch_get_main_queue(), { () -> Void in
				self.tableView.reloadData()
			})
		}
	}
	
}


extension QuickQuizViewController {
	// MARK: - Table view data source
	
	override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
		// #warning Incomplete implementation, return the number of sections
		return 1
	}
	
	override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		// #warning Incomplete implementation, return the number of rows
		return self.guestListArray.count
	}
	
	
	override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCellWithIdentifier("GuestListCell", forIndexPath: indexPath) as! GuestListCell
		if self.guestListArray.count != 0 {
			cell.guestModel = self.guestListArray[indexPath.row]
		}
		// Configure the cell...
		
		return cell
	}
	
}

