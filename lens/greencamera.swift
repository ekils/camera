//
//  greencamera.swift
//  lens
//
//  Created by 劉 家寯 on 7/8/16.
//  Copyright © 2016 劉 家寯. All rights reserved.
//

import UIKit

class greencamera: UIViewController {
    

    @IBOutlet weak var test: UIButton!
    
    @IBAction func goback2(sender: AnyObject) {
        self.performSegueWithIdentifier("goback2", sender: nil)
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
