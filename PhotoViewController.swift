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
    
    @IBOutlet var progressView: UIProgressView!
    var fiieExtension:String!
    
    override func viewDidLoad() {


        super.viewDidLoad()
        self.title="Photo View"
        self.fiieExtension=self.imageUrl.pathExtension
        self.createImage()

        
    }
    //adding the notifications
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
    self.photoImageView.sd_setShowActivityIndicatorView(true)
        
    self.photoImageView.sd_setIndicatorStyle(.gray)
        
    self.photoImageView .sd_setImage(with: self.imageUrl)
}
    
    //download button Action
    @IBAction func downloadButtonAction(_ sender: Any) {
        DownloadManager.sharedInstance.startDownload(url: self.imageUrl!)
    }
    
    //updating the UI progress bar
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
    
    //removing the progress on download completion
    func removerProgressBar(sender:NSNotification) -> Void {
        self.progressView.isHidden=true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //removing the observer
    override func viewWillDisappear(_ animated: Bool) {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue: "upadteProgress"), object: nil)
        
        NotificationCenter.default.removeObserver(self, name:NSNotification.Name(rawValue: "removeProgress") , object: nil)
    }

}
