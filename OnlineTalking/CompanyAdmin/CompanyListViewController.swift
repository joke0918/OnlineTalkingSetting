//
//  CompanyListViewController.swift
//  OnlineTalkSetting
//
//  Created by Yue Huang on 1/6/16.
//  Copyright © 2016 Yue Huang. All rights reserved.
//

import UIKit
import Alamofire

class CompanyListViewController: UIViewController {

	
	@IBOutlet weak var tableView: UITableView!
	var companyListArray: [CompanyModel] = []
	
    override func viewDidLoad() {
        super.viewDidLoad()
			self.automaticallyAdjustsScrollViewInsets = false
//			self.getCompanies()

//			self.tableView.registerClass(CompanyListCell.classForCoder(), forCellReuseIdentifier: "CompanyListCell")
        // Do any additional setup after loading the view.
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
			guard let indexPath = self.tableView.indexPathForSelectedRow else { return }
			let companyModel = self.companyListArray[indexPath.row]
			TalkingManager.sharedInstance.currentCompanyID = companyModel.companyId
			
    }

	@IBAction func loginAction(sender: AnyObject) {
		let dic = [
			"username": "admin",
			"password": "sjtu2011"
		]
		request(.POST, "http://api.careerfrog.cn/api/user/authentication", parameters: dic, encoding: .JSON, headers: nil).responseJSON() {
			response in
		 guard response.result.isSuccess == true else {
			debugPrint(response.result)
			return
			}
//			let alert = UIAlertController(title: "提示", message: "登录成功", preferredStyle: .Alert)
//			let confirmAction = UIAlertAction(title: "确定", style: .Default) {
//				action in
//				
//			}
//			alert.addAction(confirmAction)
//			self.presentViewController(alert, animated: true, completion: nil)
			debugPrint(response.result)
			self.getCompanies()
		}
	}
	
	func getCompanies() {
		request(.GET, "http://api.careerfrog.cn/api/company-admin/companies", parameters: nil, encoding: .JSON, headers: nil).responseJSON() {
			response in
			guard response.result.isSuccess == true else {
				debugPrint(response.result)
				return
			}
			guard let responseDic = response.result.value as? [String: AnyObject] else {
				return
			}
			
			guard responseDic["status"] as? String == "SUCCESS",
			let resultArray = responseDic["result"] as? [[String: AnyObject]] else { return }
			self.companyListArray.removeAll()
			for companyDic in resultArray {
				let companyModel = CompanyModel(dic: companyDic)
				self.companyListArray.append(companyModel)
			}
			dispatch_async(dispatch_get_main_queue(), { () -> Void in
				self.tableView.reloadData()

			})
		}
	}
	
	
}

extension CompanyListViewController: UITableViewDelegate {
	func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
		return 70
	}
}

extension CompanyListViewController: UITableViewDataSource {
	func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return self.companyListArray.count
	}
	
	func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCellWithIdentifier("CompanyListCell", forIndexPath: indexPath) as! CompanyListCell
		if self.companyListArray.count != 0 {
			cell.companyModel = self.companyListArray[indexPath.row]
		}

	
		return cell
	}
	
}






