//
//  TalkingTemplateViewController.swift
//  OnlineTalking
//
//  Created by Yue Huang on 1/18/16.
//  Copyright © 2016 YeoHuang. All rights reserved.
//

import UIKit

class TalkingTemplateViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
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
			if indexPath.section == 0 {
				guard let vc = segue.destinationViewController as? AddTalkingEmailViewController else { return }
				vc.name = segue.identifier!
				
			} else {
				guard let vc = segue.destinationViewController as? AddTalkingSmsViewController else { return }
				vc.name = segue.identifier!
			}
			
    }

}















