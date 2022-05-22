//
//  stackTableViewCell2.swift
//  task_test
//
//  Created by Sujeong Lee on 2022/05/20.
//

import UIKit

class stackTableViewCell2: UITableViewCell {

    @IBOutlet weak var moveicon2: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        moveicon2.tintColor = UIColor(displayP3Red: 102/255, green: 103/255, blue: 171/255, alpha: 1)
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
