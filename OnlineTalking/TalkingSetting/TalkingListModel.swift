//
//  TalkingListModel.swift
//  OnlineTalkSetting
//
//  Created by Yue Huang on 1/11/16.
//  Copyright © 2016 Yue Huang. All rights reserved.
//

import UIKit

class TalkingListModel: NSObject {
	var applyUrl: String = ""
	var mobileApplyUrl: String = ""
	var companyId: String = ""
	var domainUrl: String = ""
	var name: String = ""
	var shortName: String = ""
	var talkingId: String = ""
	var talkingScreenId: String = ""
	var begin: NSTimeInterval = 0
	var end: NSTimeInterval = 0
	var beginTimeString: String = ""
	var endTimeString: String = ""
	var test: Bool = true
	
	init(dic: [String: AnyObject]) {
		super.init()
		guard let applyUrl = dic["applyUrl"] as? String else { return }
		guard let mobileApplyUrl = dic["mobileApplyUrl"] as? String else { return }
		guard let companyId = dic["companyId"] as? String else { return }
		guard let domainUrl = dic["domainUrl"] as? String else { return }
		guard let name = dic["name"] as? String else { return }
		guard let shortName = dic["shortName"] as? String else { return }
		guard let talkingId = dic["talkingId"] as? String else { return }
		guard let talkingScreenId = dic["talkingScreenId"] as? String else { return }
		guard let begin = dic["begin"]?.doubleValue else { return }
		guard let end = dic["end"]?.doubleValue else { return }
		guard let test = dic["test"]?.boolValue else { return }
		self.applyUrl = applyUrl
		self.mobileApplyUrl = mobileApplyUrl
		self.companyId = companyId
		self.domainUrl = domainUrl
		self.name = name
		self.shortName = shortName
		self.talkingId = talkingId
		self.talkingScreenId = talkingScreenId
		self.begin = begin
		self.end = end
		self.test = test
		
		let f = NSDateFormatter()
		f.dateFormat = "yyyy-MM-dd HH:mm:ss"
		
		let beginDate = NSDate(timeIntervalSince1970: begin / 1000)
		self.beginTimeString = f.stringFromDate(beginDate)
		
		let endDate = NSDate(timeIntervalSince1970: end / 1000)
		self.endTimeString = f.stringFromDate(endDate)
	}
}


