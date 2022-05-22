//
//  TableViewCell.swift
//  scrollchartview
//
//  Created by Sujeong Lee on 2022/05/18.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var button: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        //configure()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

            // Configure the view for the selected state
    //func configure() {

    //}
        
    @IBAction func button(_ sender: UIButton) {
        print("잘 눌렸다.")
    }

    


}
