//
//  CommonQuestionCell.swift
//  OnlineTalking
//
//  Created by YeoHuang on 1/12/16.
//  Copyright © 2016 YeoHuang. All rights reserved.
//

import UIKit

class CommonQuestionCell: UITableViewCell {

  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var answerContentLabel: UILabel!
  
  var commonQuestionModel: CommonQuestionModel! {
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
    self.titleLabel.text = self.commonQuestionModel.title
    self.answerContentLabel.text = self.commonQuestionModel.answerContent
  }
  
}
