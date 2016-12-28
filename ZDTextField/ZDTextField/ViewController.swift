//
//  ViewController.swift
//  ZDTextField
//
//  Created by rajeshkumar.l on 27/12/16.
//  Copyright © 2016 rajesh-2098. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let textField = RLTextField(frame: CGRect(x: 10, y: 30, width: self.view.bounds.width - 20, height: 60))
        textField.keyboardType = .WebSearch
        textField.maximumLength = NSNotFound
        textField.autoresizingMask = .FlexibleWidth
        view.addSubview(textField)
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}


