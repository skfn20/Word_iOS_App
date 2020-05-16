//
//  QuestionGroupCell.swift
//  EnglishWords
//
//  Created by USER on 2020/05/16.
//  Copyright © 2020 Sangmin. All rights reserved.
//

import UIKit

final class QuestionGroupCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var percentageLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
