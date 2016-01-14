//
//  CompanyListCell.swift
//  OnlineTalkSetting
//
//  Created by Yue Huang on 1/10/16.
//  Copyright © 2016 Yue Huang. All rights reserved.
//

import UIKit

class CompanyListCell: UITableViewCell {

	@IBOutlet weak var companyNameLabel: UILabel!
	
	@IBOutlet weak var enableLabel: UILabel!
	
	var companyModel: CompanyModel! {
		didSet {
			self.fillDataForUI()
		}
	}
	
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

	func fillDataForUI() {
		self.companyNameLabel.text = self.companyModel.name
		self.enableLabel.text = (self.companyModel.enabled == true) ? "启用" : "禁用"
	}
}









