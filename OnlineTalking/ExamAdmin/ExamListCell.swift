//
//  ExamListCell.swift
//  OnlineTalking
//
//  Created by YeoHuang on 1/13/16.
//  Copyright © 2016 YeoHuang. All rights reserved.
//

import UIKit

class ExamListCell: UITableViewCell {

  @IBOutlet weak var questionLabel: UILabel!
  @IBOutlet weak var winnerQuantityLabel: UILabel!
  @IBOutlet weak var beginTimeLabel: UILabel!

  var examModel: ExamModel! {
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
    self.questionLabel.text = self.examModel.question
    self.winnerQuantityLabel.text = "\(self.examModel.winnerQuantity)张"
    self.beginTimeLabel.text = self.examModel.beginTimeString
  }
  
}
