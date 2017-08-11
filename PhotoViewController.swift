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
    
    @IBOutlet var progressView: UIProgressView!
    override func viewDidLoad() {


        super.viewDidLoad()
        self.title="Photo View"
        self.createImage()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(self.updateProgressBar(sender:)),
            name: NSNotification.Name(rawValue: "updateProgress"),
            object: nil)
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(self.removerProgressBar(sender:)),
            name: NSNotification.Name(rawValue: "removeProgress"),
            object: nil)
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
        DownloadManager.sharedInstance.startDownload(url: self.imageUrl!)
    }
    
    func updateProgressBar(sender:NSNotification) -> Void {
        let data:NSDictionary = sender.object as! NSDictionary
        let task:URLSessionDownloadTask = data["downloadTask"] as! URLSessionDownloadTask
        let percentDone=data["percentDone"]
        
        let activeUrl=task.currentRequest?.url
        
        if activeUrl==self.imageUrl {
            self.progressView.isHidden=false
            self.progressView.setProgress(percentDone as! Float, animated: true)
        }
    }
    
    func removerProgressBar(sender:NSNotification) -> Void {
        self.progressView.isHidden=true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue: "upadteProgress"), object: nil)
        
        NotificationCenter.default.removeObserver(self, name:NSNotification.Name(rawValue: "removeProgress") , object: nil)
    }

}
