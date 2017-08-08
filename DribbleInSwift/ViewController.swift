//
//  ViewController.swift
//  DribbleInSwift
//
//  Created by Sumit Ghosh on 07/08/17.
//  Copyright © 2017 Sumit Ghosh. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var segmentController: UISegmentedControl!
    
    @IBOutlet var PopularView: UIView!
    
    @IBOutlet var TimeView: UIView!
    
    @IBOutlet var ReboundView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

