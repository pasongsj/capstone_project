//
//  StackViewController.swift
//  task_test
//
//  Created by Sujeong Lee on 2022/05/19.
//

import UIKit


class StackViewController: UIViewController {

    var tmp2:String = ""
    var numOfpage: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let testLabel = UILabel()
        testLabel.text = "\(numOfpage! + 1) page"
        view.addSubview(testLabel)
        
        updateUI()
        

        // Do any additional setup after loading the view.
    }
    func updateUI() {
            if let numOfpage = numOfpage {
                test2label.text = "\(numOfpage + 1) page"
            }
        print(tmp2)
        }
    

    @IBOutlet weak var test2label: UILabel!
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
