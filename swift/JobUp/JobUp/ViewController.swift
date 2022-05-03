//
//  ViewController.swift
//  JobUp
//
//  Created by Sujeong Lee on 2022/05/02.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var btn: UIButton!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var label: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    @IBAction func on(_ sender: Any) {
        view.backgroundColor = UIColor.white
        label.textColor = UIColor.black
        imageView.image = UIImage(systemName: "flashlight.on.fill")
    }
    
    @IBAction func btn3(_ sender: Any) {
        print("hello")
        label.text = "test!"
    }
    @IBAction func off(_ sender: Any) {
        view.backgroundColor = UIColor.black
        label.textColor = UIColor.white
        imageView.image = UIImage(systemName: "flashlight.off.fill")
    }
    @IBAction func button(_ sender: UIButton) {
        print("hello")
        label.text = "test!"
    }
}


