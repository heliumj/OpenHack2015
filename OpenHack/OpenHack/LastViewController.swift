//
//  LastViewController.swift
//  OpenHack
//
//  Created by He Jiang on 1/31/15.
//  Copyright (c) 2015 ECHA. All rights reserved.
//

import UIKit

class LastViewController: UIViewController {
    
    @IBOutlet weak var resultLabel: UILabel!
    var toPass:String!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    self.resultLabel.text = "\(toPass)"

    }

}