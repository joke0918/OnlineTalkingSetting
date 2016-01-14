//
//  TalkingModel.swift
//  OnlineTalkSetting
//
//  Created by Yue Huang on 1/5/16.
//  Copyright © 2016 Yue Huang. All rights reserved.
//

import UIKit

/*

applyUrl = "";
begin = 1456747200000;
companyId = 28CD7460;
created = 1450858392000;
domainUrl = "";
enable = 1;
end = 1425216600000;
logoUrl = "http://7xpsgc.com2.z0.glb.qiniucdn.com/images%2Fge_logo.png";
mobileApplyUrl = "";
name = "EEDP\U7a7a\U4e2d\U5ba3\U8bb2\U4f1a";
shortName = "GE\U6821\U62db";
talkingId = "28CD7460-2A2BA8D8";
talkingScreenId = "28CD7460-27FBDE7D";
test = 0;
theme = "<null>";
themeManage = "<null>";
themeMobile = "<null>";
themeRegister = "<null>";

*/

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
		
		guard let examContent = dic["examContent"] as? String else { return }
		guard let indexBgImageUrl = dic["indexBgImageUrl"] as? String else { return }
		guard let indexIntroduction = dic["indexIntroduction"] as? Bool else { return }
		guard let indexIntroductionName = dic["indexIntroductionName"] as? String else { return }
		guard let indexVideoBgImageUrl = dic["indexVideoBgImageUrl"] as? String else { return }
		guard let introContent = dic["introContent"] as? String else { return }
		guard let introFooter = dic["introFooter"] as? String else { return }
		guard let introHeader = dic["introHeader"] as? String else { return }
		guard let logoUrl = dic["logoUrl"] as? String else { return }
		guard let questionBegin = dic["questionBegin"] as? Double else { return }
		guard let questionDesignated = dic["questionDesignated"] as? Bool else { return }
		guard let questionEnableTag = dic["questionEnableTag"] as? Bool else { return }
		guard let questionEnd = dic["questionEnd"] as? Double else { return }
		guard let questionnaireMobileUrl = dic["questionnaireMobileUrl"] as? String else { return }
		guard let questionnaireUrl = dic["questionnaireUrl"] as? String else { return }
		guard let registrationFields = dic["registrationFields"] as? [String] else { return }
		guard let videoBegin = dic["videoBegin"] as? Double else { return }
		guard let videoEnd = dic["videoEnd"] as? Double else { return }
		guard let videoUrl = dic["videoUrl"] as? String else { return }
		guard let websiteUrl = dic["websiteUrl"] as? String else { return }


		
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
		self.examContent = examContent
		self.indexBgImageUrl = indexBgImageUrl
		self.indexVideoBgImageUrl = indexVideoBgImageUrl
		self.indexIntroduction = indexIntroduction
		self.indexIntroductionName = indexIntroductionName
		self.introContent = introContent
		self.introFooter = introFooter
		self.introHeader = introHeader
		self.logoUrl = logoUrl
		self.questionBegin = questionBegin
		self.questionDesignated = questionDesignated
		self.questionEnableTag = questionEnableTag
		self.questionEnd = questionEnd
		self.questionnaireMobileUrl = questionnaireMobileUrl
		self.questionnaireUrl = questionnaireUrl
		self.registrationFields = registrationFields
		self.videoBegin = videoBegin
		self.videoEnd = videoEnd
		self.videoUrl = videoUrl
		self.websiteUrl = websiteUrl
		
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
















