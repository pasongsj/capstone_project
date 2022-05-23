//
//  RepoSelectCell.swift
//  task_test
//
//  Created by Sujeong Lee on 2022/05/22.
//

import UIKit

/*
protocol RepoCellDelegate{
    func didPressRepo(for index: Int, check: Bool)
}*/

protocol RepoCellDelegate{
    func didPressCheck(for index: Int, check: Bool)
    func didPressLink(url: String)
}

class RepoSelectCell: UITableViewCell {
    //var delegate: RepoCellDelegate?
    @IBOutlet weak var containView: UIView!
    @IBOutlet weak var repoSeletBtn: UIButton!
    
    @IBOutlet weak var repoName: UILabel!
    @IBOutlet weak var repoURL: UIButton!
    var delegate: RepoCellDelegate?
    var index: Int?
    var getUrl: String = ""
    
    @IBAction func didPressCheck(_ sender: UIButton) {
        guard let idx = index else {return}
                if sender.isSelected {
                    isTouched = true
                    delegate?.didPressCheck(for: idx, check: true)
                }else {
                    isTouched = false
                    delegate?.didPressCheck(for: idx, check: false)
                }
                sender.isSelected = !sender.isSelected
    }
    
    @IBAction func didPressLink(_ sender: UIButton) {
        delegate?.didPressLink(url: getUrl)
        //print(getUrl)

    }
    var isTouched: Bool? {
        didSet {
            if isTouched == true{
                repoSeletBtn.setImage(UIImage(systemName: "circle.inset.filled", withConfiguration:
                                                UIImage.SymbolConfiguration(scale: .large)), for: .normal)
            }
            else{
                repoSeletBtn.setImage(UIImage(systemName: "circle", withConfiguration:
                                                UIImage.SymbolConfiguration(scale: .large)), for: .normal)
            }
        }
    }
    
    
    

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
    
    //@IBAction func didPressHeart(_ sender: UIButton) {

}
