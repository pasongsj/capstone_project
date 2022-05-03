//
//  ViewController.swift
//  week1_prac1
//
//  Created by Sujeong Lee on 2022/05/03.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var label: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func buttonOn(_ sender: Any) {
        label.text = "On"
        view.backgroundColor = UIColor.white
        label.textColor = UIColor.black
        imageView.image = UIImage(systemName: "flashlight.on.fill")
    }
    
    @IBAction func buttonOff(_ sender: Any) {
        label.text = "Off"
        view.backgroundColor = UIColor.black
        label.textColor = UIColor.white
        imageView.image = UIImage(systemName: "flashlight.off.fill")
        
    }
    
}

