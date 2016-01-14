//
//  CompanyModel.swift
//  OnlineTalkSetting
//
//  Created by Yue Huang on 1/6/16.
//  Copyright © 2016 Yue Huang. All rights reserved.
//

import UIKit

class CompanyModel: NSObject {
	var companyId: String = ""
	var name: String = ""
	var enabled: Bool = true
	
	init(dic: [String: AnyObject]) {
		super.init()

		guard let companyId = dic["companyId"] as? String else { return }
		guard let name = dic["name"] as? String else { return }
		guard let enabled = dic["enabled"] as? Bool else { return }
		self.companyId = companyId
		self.enabled = enabled
		self.name = name
	}
}
