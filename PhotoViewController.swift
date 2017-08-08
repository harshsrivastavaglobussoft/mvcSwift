//
//  PhotoViewController.swift
//  DribbleInSwift
//
//  Created by Sumit Ghosh on 07/08/17.
//  Copyright © 2017 Sumit Ghosh. All rights reserved.
//

import UIKit

class PhotoViewController: UIViewController {

    @IBOutlet var photoImageView: UIImageView!
    @IBOutlet var downloadButton: UIButton!
    override func viewDidLoad() {


        super.viewDidLoad()

        // Do any additional setup after loading the view.

    }
    //download button Action
    @IBAction func downloadButtonAction(_ sender: Any) {
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


}
