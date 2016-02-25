//
//  GuestListViewController.swift
//  OnlineTalkSetting
//
//  Created by Yue Huang on 1/11/16.
//  Copyright © 2016 Yue Huang. All rights reserved.
//

import UIKit
import Alamofire

class GuestListViewController: UITableViewController {

	var guestListArray: [GuestModel] = []
	var committingGuestCount: Int = 0 {
		didSet {
			if committingGuestCount < oldValue {
				if committingGuestCount == 0 {
					self.getGuests()
				}
			}
		}
	}
	
    override func viewDidLoad() {
        super.viewDidLoad()
			self.tableView.estimatedRowHeight = 90
			
			let removeAllButton = UIButton(type: .System)
			removeAllButton.frame = CGRectMake(0, 0, ScreenWidth, 40)
			removeAllButton.setTitle("一键清空", forState: .Normal)
			removeAllButton.addTarget(self, action: "deleteAllGuestsAction:", forControlEvents: .TouchUpInside)
			self.tableView.tableHeaderView = removeAllButton
    }

	override func viewWillAppear(animated: Bool) {
		super.viewWillAppear(animated)
		self.getGuests()
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
		guard let segueIdentifier = segue.identifier else { return }
		if segueIdentifier == "Update" {
			guard let indexPath = self.tableView.indexPathForSelectedRow,
				let destinationVC = segue.destinationViewController as? UpdateGuestViewController else { return }
			destinationVC.guestModel = self.guestListArray[indexPath.row]
		} else {
			
		}
		
	}
	
	func deleteAllGuestsAction(render: AnyObject) {
		self.showAlertWithMessage("是否清空全部嘉宾") {
			[unowned self]
			action in
			self.deleteAllGuests()
		}
	}
	
	@IBAction func addLocalGuestsAction(sender: AnyObject) {

		do {
			guard let filePath = NSBundle.mainBundle().pathForResource("Guests.json", ofType: nil),
				let data = NSData(contentsOfFile: filePath),
			let array = try NSJSONSerialization.JSONObjectWithData(data, options: .MutableContainers) as? [[String: AnyObject]] else {
					self.showAlertWithMessage("读取本地数据失败")
					return
			}
			self.addLocalGuests(guestArray: array)
		} catch {
			self.showAlertWithMessage("读取本地数据失败")
		}
	}
	
	override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
		self.view.endEditing(true)
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
	
	func deleteAllGuests() {
		dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)){
			[unowned self] in
			self.committingGuestCount = self.guestListArray.count - 1
			for guestModel in self.guestListArray {
				NSThread.sleepForTimeInterval(0.1)
				if guestModel.username != "admin" {
					let urlString = "http://api.careerfrog.cn/api/guest-admin/\(TalkingManager.sharedInstance.currentTalkingID)/\(guestModel.guestId)"
					request(.DELETE, urlString, parameters: nil, encoding: .JSON, headers: nil).responseJSON() {
						response in
						self.committingGuestCount--
					}
				}
			}
		}
	}
	
	func deleteGuest(guestId: String) {
		let urlString = "http://api.careerfrog.cn/api/guest-admin/\(TalkingManager.sharedInstance.currentTalkingID)/\(guestId)"
		request(.DELETE, urlString, parameters: nil, encoding: .JSON, headers: nil).responseJSON() {
			response in
			guard response.result.isSuccess == true,
				let responseDic = response.result.value as? [String: AnyObject]
				else {
					debugPrint(response.result)
					return }
			
			guard responseDic["status"] as? String == "SUCCESS" else { return }
			dispatch_async(dispatch_get_main_queue()) {
				self.getGuests()
			}
		}
	}
	
	func addLocalGuests(guestArray array: [[String: AnyObject]]) {
		self.committingGuestCount = array.count
		let urlString = "http://api.careerfrog.cn/api/guest-admin/\(TalkingManager.sharedInstance.currentTalkingID)/add"
		for dic in array {
			NSThread.sleepForTimeInterval(0.1)
			request(.POST, urlString, parameters: dic, encoding: .JSON, headers: nil).responseJSON() {
				response in
				guard response.result.isSuccess == true,
					let responseDic = response.result.value as? [String: AnyObject]
					else {
						debugPrint(response.result)
						return }
				
				guard responseDic["status"] as? String == "SUCCESS" else { return }
				self.committingGuestCount--
			}
		}
	}
	
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

	

}

extension GuestListViewController {
	// MARK: - Table view data source
	
	override func tableView(tableView: UITableView, editingStyleForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCellEditingStyle {
		return .Delete
	}
	
	override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
		if editingStyle == .Delete {
			let model = self.guestListArray[indexPath.row]
			self.deleteGuest(model.guestId)
		} else {
			
		}
	}
	
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









