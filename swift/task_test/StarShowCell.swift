//
//  StarShowCell.swift
//  task_test
//
//  Created by Sujeong Lee on 2022/05/24.
//

import UIKit

class StarShowCell: UITableViewCell {

    @IBOutlet weak var starsLabel: UILabel!
    @IBOutlet weak var starRepoLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
