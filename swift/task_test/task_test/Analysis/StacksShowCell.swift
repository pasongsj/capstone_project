//
//  StacksShowCell.swift
//  task_test
//
//  Created by Sujeong Lee on 2022/05/24.
//

import UIKit

class StacksShowCell: UITableViewCell {

    @IBOutlet weak var explainStackLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        explainStackLabel.numberOfLines = 4
        // Configure the view for the selected state
    }
    

}
