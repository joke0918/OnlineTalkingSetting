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
		
		if let applyUrl = dic["applyUrl"] as? String {
			self.applyUrl = applyUrl

		}
		
		if let mobileApplyUrl = dic["mobileApplyUrl"] as? String {
			self.mobileApplyUrl = mobileApplyUrl

		}
		
		if let companyId = dic["companyId"] as? String {
			self.companyId = companyId

		}

		if let domainUrl = dic["domainUrl"] as? String {
			self.domainUrl = domainUrl

		}
		
		if let name = dic["name"] as? String {
			self.name = name

		}
		
		if let shortName = dic["shortName"] as? String {
			self.shortName = shortName

		}
		
		if let talkingId = dic["talkingId"] as? String {
			self.talkingId = talkingId

		}
		
		if let talkingScreenId = dic["talkingScreenId"] as? String {
			self.talkingScreenId = talkingScreenId

		}
		if let begin = dic["begin"]?.doubleValue {
			self.begin = begin

		}
		if let end = dic["end"]?.doubleValue {
			self.end = end

		}
		if let test = dic["test"]?.boolValue {
			self.test = test

		}

		
		let f = NSDateFormatter()
		f.dateFormat = "yyyy-MM-dd HH:mm:ss"
		
		let beginDate = NSDate(timeIntervalSince1970: begin / 1000)
		self.beginTimeString = f.stringFromDate(beginDate)
		
		let endDate = NSDate(timeIntervalSince1970: end / 1000)
		self.endTimeString = f.stringFromDate(endDate)
	}
}


