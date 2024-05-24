//
//  ViewController.swift
//  Counter
//
//  Created by Anna Shvets on 24.05.2024.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var counterLabel: UILabel!
    private var counter = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func incrementCount(_ sender: Any) {
//        counterLabel.text = "\(counter + 1)"
        counter += 1
        counterLabel.text = String(counter)
    }
    
}

