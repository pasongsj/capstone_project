//
//  ViewController.swift
//  prac2
//
//  Created by Sujeong Lee on 2022/05/02.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    var isBackSide = true
    
    @IBAction func buttonDidClick(_ sender: Any) {
        if isBackSide {
                    imageView.image = UIImage(named: "ace")
                } else {
                    imageView.image = UIImage(named: "poker")
                }
                isBackSide = !isBackSide // true | false
    }
}

