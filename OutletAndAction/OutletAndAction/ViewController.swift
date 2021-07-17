//
//  ViewController.swift
//  OutletAndAction
//
//  Created by Артем Соловьев on 26.01.2021.
//

import UIKit

class ViewController: UIViewController {
    @IBAction func ChageTextInLabel(_ sender: UIButton) {
        Label.text = "Hello, World"
    }
    @IBOutlet weak var Label: UILabel!
    
}

