//
//  TaskViewController.swift
//  task_test
//
//  Created by Sujeong Lee on 2022/05/18.
//

import UIKit

class TaskViewController: UIViewController {

    @IBOutlet weak var previousView: UIView!
    
    @IBOutlet weak var nextView: UIView!
    
    @IBOutlet weak var segmentControl: UISegmentedControl!
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.barTintColor = .white
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        previousView.alpha = 1
        nextView.alpha = 0

        // Do any additional setup after loading the view.
    }
    @IBAction func segmentValueChanged(_ sender: Any) {
        if segmentControl.selectedSegmentIndex == 0{
            previousView.alpha = 1
            nextView.alpha = 0
        } else {
            previousView.alpha = 0
            nextView.alpha = 1
        }
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
