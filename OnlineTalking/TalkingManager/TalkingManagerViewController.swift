//
//  TalkingManagerViewController.swift
//  OnlineTalking
//
//  Created by Yue Huang on 1/19/16.
//  Copyright © 2016 YeoHuang. All rights reserved.
//

import UIKit
import Alamofire

class TalkingManagerViewController: UIViewController {

	
	
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

	override func viewWillAppear(animated: Bool) {
		super.viewWillAppear(animated)
		self.login()
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

	@IBAction func loginAction(sender: AnyObject) {
		self.login()
	}
	
	func login() {
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
			
			dispatch_async(dispatch_get_main_queue()) {
				self.tabBarController!.selectedIndex = 0
			}
			
		}
	}
	
}









