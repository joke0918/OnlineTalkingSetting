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

	@IBOutlet weak var tableView: UITableView!
	@IBOutlet weak var companyIDTextField: UITextField!
	private var talkingListArray: [TalkingListModel] = []
	
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
			guard let indexPath = self.tableView.indexPathForSelectedRow else { return }
			let talkingModel = self.talkingListArray[indexPath.row]
			TalkingManager.sharedInstance.currentTalkingID = talkingModel.talkingId
    }

	// MARK: - life cycle
	// MARK: - delegate
	// MARK: - response event
	
	
	func getTalkings() {

		request(.GET, "http://api.careerfrog.cn/api/talking-admin/talkings/" + "\(TalkingManager.sharedInstance.currentCompanyID)", parameters: nil, encoding: .JSON, headers: nil).responseJSON() {
			response in
			guard response.result.isSuccess == true else {
				debugPrint(response.result.error!)
				return
			}

			guard let responseDic = response.result.value as? [String: AnyObject] else {
				return
			}
			
			guard responseDic["status"] as? String == "SUCCESS",
			let resultDic = responseDic["result"] as? [[String: AnyObject]] else { return }
			self.talkingListArray.removeAll()
			for talkingListDic in resultDic {
				let model = TalkingListModel(dic: talkingListDic)
				self.talkingListArray.append(model)
			}
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
		return self.talkingListArray.count
	}
	
	func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCellWithIdentifier("TalkingListCell", forIndexPath: indexPath) as! TalkingListCell
		if self.talkingListArray.count != 0 {
			let talkingListModel = self.talkingListArray[indexPath.row]
			cell.talkingListModel = talkingListModel
		}
		
		
		return cell
		
	}
}














