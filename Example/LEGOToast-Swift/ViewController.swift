//
//  ViewController.swift
//  LEGOToast-Swift
//
//  Created by 564008993@qq.com on 07/31/2020.
//  Copyright (c) 2020 564008993@qq.com. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        legoToastGlobalManager.font = UIFont.systemFont(ofSize: 10, weight: UIFont.Weight.bold)
        legoToastGlobalManager.textColor = UIColor.red
        legoToastGlobalManager.backgroundColor = UIColor.yellow
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            LEGOToastView .showByMessage(text: "123123123123123123123123123123123")
        }
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

