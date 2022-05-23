//
//  RepoSelectViewController.swift
//  task_test
//
//  Created by Sujeong Lee on 2022/05/22.
//

import UIKit
import SafariServices
class RepoSelectViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, RepoCellDelegate {
    
    
    let repolist: [String] = ["1","2","3","4","5"]
    let repoUrls: [String] = ["https://www.naver.com","https://www.daum.net","https://www.naver.com","https://www.naver.com","https://www.naver.com"]
    
    lazy var checks: [Int:Int] = [:]
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        repolist.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = repotableview.dequeueReusableCell(withIdentifier: "Repocell", for: indexPath) as! RepoSelectCell
        cell.delegate = self
        cell.index = indexPath.row
        //레포 선택할 때 동작
        if checks[indexPath.row] == 1{
            cell.isTouched = true
        }
        else{
            cell.isTouched = false
        }
        // 링크 클릭할 때 동작 url보내기
        cell.getUrl = repoUrls[indexPath.row]
        cell.repoName.text = repolist[indexPath.row]
//
//
        
        
        return cell
    }
    // press한 링크 받아와서 safari 로 접속하기
    func didPressLink(url: String){
        let githubUrl = NSURL(string: url)
        let githubSafariView: SFSafariViewController = SFSafariViewController(url: githubUrl! as URL)
        self.present(githubSafariView, animated: true, completion: nil)
    }
    // 레포 선택시 동작 보내기
    func didPressCheck(for index: Int, check: Bool) {
            if check == true{
                checks[index] = 1
            }else{
                checks[index] = 0
            }
        }

    
    //tableview연결
    @IBOutlet weak var repotableview: UITableView!
    
    //분석하기 버튼 커스텀용
    @IBOutlet weak var analyBtn: UIButton!
    
    //최종 선택한 result 보내기
    @IBAction func analyzeButton(_ sender: Any) {
        for i in 0..<repolist.count{
            //체크한 repository index post Todo
            if((checks[i] != nil)==true){
                print(i)
            }
                    
        }
    }
    
    
    override func viewDidLoad() {
        self.repotableview.dataSource = self
        self.repotableview.delegate = self
        super.viewDidLoad()
        analyBtn.layer.cornerRadius = 15
        analyBtn.layer.masksToBounds = true
        //analyBtn
        //checks = Array<Int>(repeating: 0, count: repolist.count)

        // Do any additional setup after loading the view.
    }
    
    

}
