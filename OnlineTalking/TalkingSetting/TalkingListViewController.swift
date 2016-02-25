//
//  TalkingListViewController.swift
//  OnlineTalkSetting
//
//  Created by Yue Huang on 1/5/16.
//  Copyright © 2016 Yue Huang. All rights reserved.
//

import UIKit
import Alamofire

class TalkingListViewController: UIViewController {

	
	@IBOutlet weak var filterSegmentedControl: UISegmentedControl!
	
	@IBOutlet weak var tableView: UITableView!

	private var talkingListArray: [TalkingListModel] = []
	var filteredTalkingListArray: [TalkingListModel] = []
	
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
			self.automaticallyAdjustsScrollViewInsets = false
		}

	override func viewWillAppear(animated: Bool) {
		super.viewWillAppear(animated)
		self.getTalkings()

	}
	
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
			guard let indexPath = self.tableView.indexPathForSelectedRow,
				let vc = segue.destinationViewController as? TalkingSettingListViewController
			else { return }
			let talkingModel = self.filteredTalkingListArray[indexPath.row]
			TalkingManager.sharedInstance.currentTalkingID = talkingModel.talkingId
			
			vc.title = talkingModel.name.componentsSeparatedByString("——").last!
    }

	// MARK: - life cycle
	// MARK: - delegate
	// MARK: - response event
	
	@IBAction func swipGesture(swip: UISwipeGestureRecognizer) {
		switch swip.direction {
		case UISwipeGestureRecognizerDirection.Left:
			var index = self.filterSegmentedControl.selectedSegmentIndex
			if index < 2 {
				index++
				self.filterSegmentedControl.selectedSegmentIndex = index
				self.filterTalkingListArray()
			}
		case UISwipeGestureRecognizerDirection.Right:
			var index = self.filterSegmentedControl.selectedSegmentIndex
			if index > 0 {
				index--
				self.filterSegmentedControl.selectedSegmentIndex = index
				self.filterTalkingListArray()
			}
		default: break
		}
	}
	
	@IBAction func filterAction(sender: AnyObject) {
		self.filterTalkingListArray()
	}
	
	
	
	func filterTalkingListArray() {
		switch self.filterSegmentedControl.selectedSegmentIndex {
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
				if $0.test{
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
			var array: [TalkingListModel] = []
			for talkingListDic in resultDic {
				let model = TalkingListModel(dic: talkingListDic)
				array.append(model)
			}
			self.talkingListArray = array.sort {
				(t1, t2) in
				return t1.begin < t2.begin
			}
			self.filterTalkingListArray()
			dispatch_async(dispatch_get_main_queue(), { () -> Void in
				self.tableView.reloadData()
			})
		}
	}
	
	
	
	// MARK: - prive method
	// MARK: - setter and getter
	
}

extension TalkingListViewController: UITableViewDelegate {
	func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
		return 130
	}
}

extension TalkingListViewController: UITableViewDataSource {
	func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return self.filteredTalkingListArray.count
	}
	
	func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCellWithIdentifier("TalkingListCell", forIndexPath: indexPath) as! TalkingListCell
		if self.filteredTalkingListArray.count != 0 {
			let talkingListModel = self.filteredTalkingListArray[indexPath.row]
			cell.talkingListModel = talkingListModel
		}
		
		
		return cell
		
	}
}














