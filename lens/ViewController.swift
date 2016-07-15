//
//  ViewController.swift
//  lens
//
//  Created by 劉 家寯 on 7/8/16.
//  Copyright © 2016 劉 家寯. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    

    @IBAction func gotoblue(sender: AnyObject) {
        self.performSegueWithIdentifier("gotoblue", sender: nil)
    }
    
    @IBAction func gotogreen(sender: AnyObject) {
        self.performSegueWithIdentifier("gotogreen", sender: nil)
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

