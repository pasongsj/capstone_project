//
//  AnalyzedTableViewController.swift
//  task_test
//
//  Created by Sujeong Lee on 2022/05/23.
//

import UIKit

class AnalyzedTableViewController: UITableViewController {
    var monthlyCommit:[Int] = [0,10,3,7]
    var Changed: Int = 0//커밋 변화 연산용 변수
    
    var getStar: Int = 71
    var getStarRepo: String = "dev-in"
    
    var getLang:[String] = ["R","JS","Python"]
    var getLangCount:[Int] = [43,20,7]
    
    var getUser: String = "pasongsj"
    var getUserLang: String = "Python"
    var getTask: String = "서버개발자"
    var getStack: String = "Flask"
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 5
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0{//Commit Cell
            let cell = tableView.dequeueReusableCell(withIdentifier: "CommitChart", for: indexPath) as! CommitChartCell
            cell.monthlyCommitCount = monthlyCommit
            //이번달 커밋
            cell.currCommitLabel.text = String(monthlyCommit[monthlyCommit.count-1])
            //지난 달 대비 커밋 변화
            Changed = monthlyCommit[monthlyCommit.count-1] - monthlyCommit[monthlyCommit.count-2]
            if Changed > 0{
                cell.chagnedCommitLabel.text = "+"+String(Changed)
            }
            else{
                cell.chagnedCommitLabel.text = "-"+String(Changed)
            }
            return cell
        }
        else if indexPath.section == 1{//Star Cell
            let cell = tableView.dequeueReusableCell(withIdentifier: "StarCell", for: indexPath) as! StarShowCell
            cell.starsLabel.text = String(getStar) + "stars"
            cell.starRepoLabel.text = getStarRepo + "레포에서 가장 많은 star를 받았어요!"
            return cell
        }
        else if indexPath.section == 2{
            let cell = tableView.dequeueReusableCell(withIdentifier: "LanguageCell", for: indexPath) as! LanguageChartCell
            cell.lang = getLang
            cell.langCount = getLangCount
            
            return cell
            
        }
        else if indexPath.section == 3{
            let cell = tableView.dequeueReusableCell(withIdentifier: "StacksCell", for: indexPath) as! StacksShowCell
            cell.explainStackLabel.text = getUser+"님은"+getUserLang+"(으)로 잘 활용해 왔고, 관심직무인"+getTask+"(으)로 분석결과"+getStack+"(으)로 개발할 것으로 예상됩니다!"
            return cell
            
        }
        else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "MemoirCell", for: indexPath) as! MemoirShowCell
            cell.contentView.layer.borderColor = UIColor.lightGray.cgColor
            cell.contentView.layer.borderWidth = 0.3
            cell.contentView.layer.cornerRadius = 10
            cell.contentView.clipsToBounds = true
            cell.contentView.backgroundColor = UIColor(red: 0.94, green: 0.94, blue: 0.97, alpha: 1.00)
            
            return cell
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 17.0
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0{
            return 400
        }
        else if indexPath.section == 1{
            return 72
            
        }
        else if indexPath.section == 2{
            return 220
        }
        else if indexPath.section == 3{
            return 80
        }
        else{
            return 120
        }
    }
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "Commit"
        case 1:
            return "Stars"
        case 2:
            return "Languages"
        case 3:
            return "Stacks"
        case 4:
            return "월간회고록"
        default:
            return ""
        }

    }
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        .leastNormalMagnitude
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let titleLabel = UILabel()
        titleLabel.frame = CGRect(x: 15, y: 0, width: tableView.frame.size.width, height: 17)
        titleLabel.font = UIFont.boldSystemFont(ofSize: 17)
        titleLabel.text = self.tableView(tableView, titleForHeaderInSection: section)
//        titleLabel.backgroundColor = UIColor.yellow


        let headerView = UIView()
//        headerView.frame = CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 20)
        headerView.addSubview(titleLabel)
//        headerView.backgroundColor = UIColor.red

        return headerView

    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
