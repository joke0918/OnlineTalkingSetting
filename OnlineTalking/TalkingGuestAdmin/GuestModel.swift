//
//  GuestModel.swift
//  OnlineTalkSetting
//
//  Created by Yue Huang on 1/11/16.
//  Copyright © 2016 Yue Huang. All rights reserved.
//

import UIKit


class GuestModel: NSObject {
	var guestId: String = ""
	var username: String = ""
	var nickname: String = ""
	var position: String = ""
	var avatarUrl: String = ""
	var user: String = ""
	var pass: String = ""
	var admin: Bool = false
	var order: Int = 0
	var display: Bool = true
	
	init(dic: [String: AnyObject]?) {
		super.init()
		guard let guestDic = dic,
			let guestId = guestDic["guestId"] as? String,
			let username = guestDic["username"] as? String,
			let nickname = guestDic["nickname"] as? String,
			let position = guestDic["position"] as? String,
			let avatarUrl = guestDic["avatarUrl"] as? String else { return }
		
		self.guestId = guestId
		self.username = username
		self.nickname = nickname
		self.avatarUrl = avatarUrl
		self.position = position
	}

}
