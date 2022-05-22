//
//  RepoSelectCell.swift
//  task_test
//
//  Created by Sujeong Lee on 2022/05/22.
//

import UIKit
protocol CustomCellDelegate2 {
    func didPressLink(for index: Int, like: Bool)
}

class RepoSelectCell: UITableViewCell {

    @IBOutlet weak var containView: UIView!
    
    @IBOutlet weak var repoCheckPin: UIImageView!
    
    @IBOutlet weak var repoURL: UIImageView!
    
    @IBOutlet weak var reponame: UILabel!
    
  //  weak var delegate: TableViewCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        containView.layer.cornerRadius = 5
        containView.layer.masksToBounds = true

        // Configure the view for the selected state
    }

}
