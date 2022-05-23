//
//  MemoirShowCell.swift
//  task_test
//
//  Created by Sujeong Lee on 2022/05/24.
//

import UIKit

class MemoirShowCell: UITableViewCell {

    @IBOutlet weak var memoirDate: UILabel!
    
    @IBOutlet weak var MemoirText: UITextView!
    
    @IBOutlet weak var enterTextBtn: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    override func layoutSubviews() {
        super.layoutSubviews()

        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 10, left: 15, bottom: 10, right: 15))
    }

}
