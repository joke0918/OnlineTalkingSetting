//
//  TalkingManager.swift
//  OnlineTalkSetting
//
//  Created by Yue Huang on 1/6/16.
//  Copyright © 2016 Yue Huang. All rights reserved.
//

import UIKit

class TalkingManager: NSObject {
	var currentCompanyID: String = ""
	var currentTalkingID: String = ""
	var talkingModel: TalkingModel!
	static let sharedInstance: TalkingManager = {
		return TalkingManager()
	}()
	
}
