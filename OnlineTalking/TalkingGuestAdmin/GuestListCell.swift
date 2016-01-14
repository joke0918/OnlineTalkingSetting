//
//  GuestListCell.swift
//  OnlineTalkSetting
//
//  Created by Yue Huang on 1/11/16.
//  Copyright © 2016 Yue Huang. All rights reserved.
//

import UIKit
import Kingfisher

class GuestListCell: UITableViewCell {

	@IBOutlet weak var headImageView: UIImageView!
	
	@IBOutlet weak var usernameLabel: UILabel!
	
	@IBOutlet weak var nicknameLabel: UILabel!
	
	@IBOutlet weak var positionLabel: UILabel!
	
	var guestModel: GuestModel! {
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
		self.usernameLabel.text = self.guestModel.username
		self.nicknameLabel.text = self.guestModel.nickname
		self.positionLabel.text = self.guestModel.position
		self.headImageView.kf_setImageWithURL(NSURL(string: self.guestModel.avatarUrl)!)
	}

	override func layoutSubviews() {
		super.layoutSubviews()
		self.headImageView.layer.cornerRadius = CGRectGetWidth(self.headImageView.frame) * 0.5
		self.headImageView.layer.masksToBounds = true
	}
	
}






