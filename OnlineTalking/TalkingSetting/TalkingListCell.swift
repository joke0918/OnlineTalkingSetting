//
//  TalkingListCell.swift
//  OnlineTalkSetting
//
//  Created by Yue Huang on 1/4/16.
//  Copyright © 2016 Yue Huang. All rights reserved.
//

import UIKit

class TalkingListCell: UITableViewCell {


	@IBOutlet weak var nameLabel: UILabel!
	
	@IBOutlet weak var beginTimeLabel: UILabel!
	
	@IBOutlet weak var domainUrlLabel: UILabel!

	var talkingListModel: TalkingListModel! {
		didSet {
			self.fillDataForUI()
		}
	}
	
	
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
			self.nameLabel.adjustsFontSizeToFitWidth = true
			self.beginTimeLabel.adjustsFontSizeToFitWidth = true
			self.domainUrlLabel.adjustsFontSizeToFitWidth = true
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

	func fillDataForUI() {
		self.nameLabel.text = self.talkingListModel.name
		self.beginTimeLabel.text = self.talkingListModel.beginTimeString
		self.domainUrlLabel.text = self.talkingListModel.domainUrl
	}
}







