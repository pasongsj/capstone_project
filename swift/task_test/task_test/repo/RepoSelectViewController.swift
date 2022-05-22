//
//  RepoSelectViewController.swift
//  task_test
//
//  Created by Sujeong Lee on 2022/05/22.
//

import UIKit

class RepoSelectViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, CustomCellDelegate2{
    func didPressLink(for index: Int, like: Bool) {
        //
    }
    
    
    let repolist: [String] = ["1","2","3","4","5"]
    let repourllist: [String] = ["www.naver.com","www.daum.net","www.naver.com","www.naver.com","www.naver.com"]
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        repolist.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let Repocell: UITableViewCell = repotableview.dequeueReusableCell(withIdentifier: "Repocell", for: indexPath)
      //  Repocell.index = indexPath.row
        return Repocell
        
    }
    
    @IBOutlet weak var repotableview: UITableView!
    
    @IBAction func analyzeButton(_ sender: Any) {
    }
    
    override func viewDidLoad() {
        self.repotableview.dataSource = self
        self.repotableview.delegate = self
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
