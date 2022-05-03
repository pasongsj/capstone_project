//
//  ViewController.swift
//  prac3
//
//  Created by Sujeong Lee on 2022/05/02.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var textFields: [UITextField]!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func btn(_ sender: Any) {
        for textField in textFields {
        textField.text = " change"
            
        }
    }
    
}

