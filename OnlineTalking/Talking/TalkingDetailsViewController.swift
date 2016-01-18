//
//  TalkingDetailsViewController.swift
//  OnlineTalking
//
//  Created by Yue Huang on 1/18/16.
//  Copyright © 2016 YeoHuang. All rights reserved.
//

import UIKit

class TalkingDetailsViewController: UIViewController {

	@IBOutlet weak var nameLabel: UILabel!
	@IBOutlet weak var shortNameLabel: UILabel!
	@IBOutlet weak var beginLabel: UILabel!
	@IBOutlet weak var endLabel: UILabel!
	@IBOutlet weak var domainUrlLabel: UILabel!
	@IBOutlet weak var applyUrlLabel: UILabel!
	@IBOutlet weak var mobileApplyUrlLabel: UILabel!
	@IBOutlet weak var questionBeginLabel: UILabel!
	@IBOutlet weak var questionEndLabel: UILabel!
	@IBOutlet weak var videoBeginLabel: UILabel!
	@IBOutlet weak var videoEndLabel: UILabel!
	@IBOutlet weak var videoUrlLabel: UILabel!
	@IBOutlet weak var websiteUrlLabel: UILabel!

	var talkingModel = TalkingManager.sharedInstance.talkingModel
	
	
    override func viewDidLoad() {
        super.viewDidLoad()
			self.automaticallyAdjustsScrollViewInsets = false
			self.fillDataForUI()
        // Do any additional setup after loading the view.
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

	func fillDataForUI() {
		self.nameLabel.text = self.talkingModel.name
		self.shortNameLabel.text = self.talkingModel.shortName
		self.beginLabel.text = self.talkingModel.beginTimeString
		self.endLabel.text = self.talkingModel.endTimeString
		self.domainUrlLabel.text = self.talkingModel.domainUrl
		self.applyUrlLabel.text = self.talkingModel.applyUrl
		self.mobileApplyUrlLabel.text = self.talkingModel.mobileApplyUrl
		self.questionBeginLabel.text = self.talkingModel.questionBeginString
		self.questionEndLabel.text = self.talkingModel.questionEndString
		self.videoBeginLabel.text = self.talkingModel.videoBeginString
		self.videoEndLabel.text = self.talkingModel.videoEndString
		self.videoUrlLabel.text = self.talkingModel.videoUrl
		self.websiteUrlLabel.text = self.talkingModel.websiteUrl
	}
}












