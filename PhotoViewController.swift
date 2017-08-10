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
    var imageUrl:URL!
    @IBOutlet var indicatorView: UIActivityIndicatorView!
    
    override func viewDidLoad() {


        super.viewDidLoad()
        self.title="Photo View"
        self.createImage()
        
    }
    //add image to image View
    func createImage() -> Void {
        self.indicatorView.isHidden=false
        self.indicatorView.startAnimating()
        DispatchQueue.global().async(execute: { () -> Void in
            
            let data = NSData (contentsOf: self.imageUrl)
            DispatchQueue.main.async{
                self.indicatorView.stopAnimating()
                self.indicatorView.isHidden=true
                self.photoImageView.image = UIImage(data:data! as Data)
            }
        })
    }
    
    //download button Action
    @IBAction func downloadButtonAction(_ sender: Any) {
        DownloadManager.sharedInstance.startDownload(url: self.imageUrl)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


}
