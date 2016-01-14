//
//  TalkingModel.swift
//  OnlineTalkSetting
//
//  Created by Yue Huang on 1/5/16.
//  Copyright © 2016 Yue Huang. All rights reserved.
//

import UIKit

class TalkingModel: NSObject {
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
	var examContent: String = ""
	var indexBgImageUrl: String = ""
	var indexIntroduction: Bool = true
	var indexIntroductionName: String = ""
	var indexVideoBgImageUrl: String = ""
	var introContent: String = ""
	var introFooter: String = ""
	var introHeader: String = ""
	var logoUrl: String = ""
	var questionBegin: NSTimeInterval = 0
	var questionBeginString: String = ""
	var questionDesignated: Bool = true
	var questionEnableTag: Bool = false
	var questionEnd: NSTimeInterval = 0
	var questionEndString: String = ""
	var questionnaireMobileUrl: String = ""
	var questionnaireUrl: String = ""
	var registrationFields: [String] = []
	var videoBegin: NSTimeInterval = 0
	var videoBeginString: String = ""
	var videoEnd: NSTimeInterval = 0
	var videoEndString: String = ""
	var videoUrl: String = ""
	var websiteUrl: String = ""



	
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
		if let examContent = dic["examContent"] as? String {
			self.examContent = examContent
		}
		if let indexBgImageUrl = dic["indexBgImageUrl"] as? String {
			self.indexBgImageUrl = indexBgImageUrl
		}
		if let indexIntroduction = dic["indexIntroduction"] as? Bool {
			self.indexIntroduction = indexIntroduction
		}
		if let indexIntroductionName = dic["indexIntroductionName"] as? String {
			self.indexIntroductionName = indexIntroductionName
		}
		if let indexVideoBgImageUrl = dic["indexVideoBgImageUrl"] as? String {
			self.indexVideoBgImageUrl = indexVideoBgImageUrl
		}
		if let introContent = dic["introContent"] as? String {
			self.introContent = introContent
		}
		if let introFooter = dic["introFooter"] as? String {
			self.introFooter = introFooter
		}
		if let introHeader = dic["introHeader"] as? String {
			self.introHeader = introHeader
		}
		if let logoUrl = dic["logoUrl"] as? String {
			self.logoUrl = logoUrl
		}
		if let questionBegin = dic["questionBegin"] as? Double {
			self.questionBegin = questionBegin
		}
		if let questionDesignated = dic["questionDesignated"] as? Bool {
			self.questionDesignated = questionDesignated
		}
		if let questionEnableTag = dic["questionEnableTag"] as? Bool {
			self.questionEnableTag = questionEnableTag
		}
		if let questionEnd = dic["questionEnd"] as? Double {
			self.questionEnd = questionEnd
		}
		if let questionnaireMobileUrl = dic["questionnaireMobileUrl"] as? String {
			self.questionnaireMobileUrl = questionnaireMobileUrl
		}
		if let questionnaireUrl = dic["questionnaireUrl"] as? String {
			self.questionnaireUrl = questionnaireUrl
		}
		if let registrationFields = dic["registrationFields"] as? [String] {
			self.registrationFields = registrationFields
		}
		if let videoBegin = dic["videoBegin"] as? Double {
			self.videoBegin = videoBegin
		}
		if let videoEnd = dic["videoEnd"] as? Double {
			self.videoEnd = videoEnd
		}
		if let videoUrl = dic["videoUrl"] as? String {
			self.videoUrl = videoUrl
		}
		if let websiteUrl = dic["websiteUrl"] as? String {
			self.websiteUrl = websiteUrl
		}
		
		let f = NSDateFormatter()
		f.dateFormat = "yyyy-MM-dd hh:mm:ss"
		
		var beginDate = NSDate(timeIntervalSince1970: begin / 1000)
		self.beginTimeString = f.stringFromDate(beginDate)
		
		var endDate = NSDate(timeIntervalSince1970: end / 1000)
		self.endTimeString = f.stringFromDate(endDate)
		
		beginDate = NSDate(timeIntervalSince1970: questionBegin / 1000)
		endDate = NSDate(timeIntervalSince1970: questionEnd / 1000)
		self.questionBeginString = f.stringFromDate(beginDate)
		self.questionEndString = f.stringFromDate(endDate)
		
		beginDate = NSDate(timeIntervalSince1970: videoBegin / 1000)
		endDate = NSDate(timeIntervalSince1970: videoEnd / 1000)
		self.videoBeginString = f.stringFromDate(beginDate)
		self.videoEndString = f.stringFromDate(endDate)
	}
}
















