//
//  ViewController.swift
//  YQShapedButtonDemo
//
//  Created by Yaqing Wang on 10/13/15.
//  Copyright © 2015 thoughtworks.com. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func clickButton(sender: AnyObject) {
        
        print("normal button clicked")
    }

    @IBAction func clickShapedButton(sender: AnyObject) {
        
        print("shaped button clicked")
        
    }

}

