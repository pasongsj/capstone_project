//
//  DetailStackTableViewCell.swift
//  task_test
//
//  Created by Sujeong Lee on 2022/05/19.
//

import UIKit

class DetailStackTableViewCell: UITableViewCell {
    @IBOutlet weak var circle: UIImageView!
    
    @IBOutlet weak var detailMainTask: UILabel!
    
    @IBOutlet weak var detailS1: UILabel!
    
    @IBOutlet weak var detailS2: UILabel!
    
    @IBOutlet weak var detailS3: UILabel!
    
    @IBOutlet weak var detailSView: UIView!
    
    let customedcolor = UIColor(displayP3Red: 102/255, green: 103/255, blue: 171/255, alpha: 0.3)
    
    override func awakeFromNib() {
        super.awakeFromNib()
        detailSView.backgroundColor = customedcolor
        detailSView.layer.cornerRadius = 8
        detailSView.layer.masksToBounds = true
//        detailS1.backgroundColor = customedcolor
//        detailS2.backgroundColor = customedcolor
//        detailS3.backgroundColor = customedcolor
        // Initialization code
    }


    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
