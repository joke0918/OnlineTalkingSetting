//
//  CloneAllTalkingSettingViewController.swift
//  OnlineTalking
//
//  Created by Yue Huang on 1/15/16.
//  Copyright © 2016 YeoHuang. All rights reserved.
//

import UIKit
import Alamofire

class CloneAllTalkingSettingViewController: UITableViewController {

	
	@IBOutlet weak var filterSegmentControl: UISegmentedControl!
	var talkingListArray: [TalkingListModel] = []
	var filteredTalkingListArray: [TalkingListModel] = []
	var selectedTalkingListModel: TalkingListModel?
	
    override func viewDidLoad() {
        super.viewDidLoad()
			self.title = ""
//			self.title = TalkingManager.sharedInstance.talkingModel.name
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

	override func viewWillAppear(animated: Bool) {
		super.viewWillAppear(animated)
		self.getTalkings()
	}
	
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

	@IBAction func filterAction(sender: AnyObject) {
		self.filterTalkingListArray()
	}
	
	func filterTalkingListArray() {
		switch self.filterSegmentControl.selectedSegmentIndex {
		case 0:
			self.filteredTalkingListArray = self.talkingListArray.filter() {
				if $0.test {
					return true
				} else {
					return false
				}
			}
			
		case 1:
			self.filteredTalkingListArray = self.talkingListArray.filter() {
				if $0.test {
					return false
				} else {
					return true
				}
			}
		case 2:
			self.filteredTalkingListArray = self.talkingListArray

			
		default:
			return
		}
		self.tableView.reloadData()
	}
	
	func getTalkings() {
		
		request(.GET, "http://api.careerfrog.cn/api/talking-admin/talkings/" + "\(TalkingManager.sharedInstance.currentCompanyID)", parameters: nil, encoding: .JSON, headers: nil).responseJSON() {
			response in
			guard response.result.isSuccess == true,
				let responseDic = response.result.value as? [String: AnyObject]
				else {
					debugPrint(response.result)
					return }
			
			guard responseDic["status"] as? String == "SUCCESS",
				let resultDic = responseDic["result"] as? [[String: AnyObject]] else { return }
			self.talkingListArray.removeAll()
			for talkingListDic in resultDic {
				let model = TalkingListModel(dic: talkingListDic)
				if model.talkingId != TalkingManager.sharedInstance.currentTalkingID {
					self.talkingListArray.append(model)
				}
				self.filterTalkingListArray()
			}
			dispatch_async(dispatch_get_main_queue(), { () -> Void in
				self.tableView.reloadData()
			})
		}
	}
	
}

extension CloneAllTalkingSettingViewController {
	// MARK: - Table view delegate
	override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
		self.selectedTalkingListModel = self.filteredTalkingListArray[indexPath.row]
		self.showAlertWithMessage("确认克隆\(self.selectedTalkingListModel!.name)所有信息吗?") {
			[unowned self]
			action in
			self.cloneAllTalkingSetting()
		}
	}
	
	override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
		return 130.0
	}
	
}

extension CloneAllTalkingSettingViewController {
	// MARK: - Table view data source
	
	override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
		// #warning Incomplete implementation, return the number of sections
		return 1
	}
	
	override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		// #warning Incomplete implementation, return the number of rows
		return self.filteredTalkingListArray.count
	}
	
	
	override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCellWithIdentifier("TalkingListCell", forIndexPath: indexPath) as! TalkingListCell
		if self.filteredTalkingListArray.count != 0 {
			cell.talkingListModel = self.filteredTalkingListArray[indexPath.row]
		}
		
		// Configure the cell...
		
		return cell
	}

	func cloneAllTalkingSetting() {
		guard let model = self.selectedTalkingListModel else { return }
		let dic = [
			"sourceId": model.talkingId,
			"targetId": TalkingManager.sharedInstance.currentTalkingID
		]
		let urlString = "http://api.careerfrog.cn/api/talking-admin/clone"
		request(.POST, urlString, parameters: dic, encoding: .JSON, headers: nil).responseJSON() {
			response in
			guard response.result.isSuccess == true,
				let responseDic = response.result.value as? [String: AnyObject]
				else {
					debugPrint(response.result)
					return }
			
			guard responseDic["status"] as? String == "SUCCESS" else { return }
			self.showAlertWithMessage("Clone成功,点击确定返回") {
				[unowned self]
				action in
				self.navigationController!.popViewControllerAnimated(true)
			}
		}
	}
	
}





