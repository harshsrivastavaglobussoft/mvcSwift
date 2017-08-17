//
//  DownloadManager.swift
//  DribbleInSwift
//
//  Created by Sumit Ghosh on 10/08/17.
//  Copyright © 2017 Sumit Ghosh. All rights reserved.
//

import UIKit
import Foundation
class DownloadManager: NSObject,URLSessionDelegate,URLSessionDownloadDelegate{
    
    
    static let sharedInstance: DownloadManager = {
        let instance = DownloadManager()
        return instance
    }()
    private let accessQueue = DispatchQueue(label: "SynchronizedAccess", attributes: .concurrent)
    
    var session:URLSession!
    var activeUrlString:URL!
    var task:URLSessionDownloadTask!
    
    func startDownload(url:URL) -> Void {
        let queue:OperationQueue=OperationQueue()
        queue.maxConcurrentOperationCount=5
        self.accessQueue.sync() {
            self.activeUrlString = url
        }
        if self.session==nil {
            let configuration:URLSessionConfiguration = URLSessionConfiguration .background(withIdentifier: "image")
            
            self.accessQueue.sync() {
                
                self.session = URLSession.init(configuration: configuration as URLSessionConfiguration!, delegate: self, delegateQueue: OperationQueue.main)
                
            }
            let request:URLRequest=URLRequest.init(url: url as URL!)
            self.accessQueue.sync() {
                self.task = self.session.downloadTask(with: request as URLRequest!)
                self.task!.resume()
            }
            
         
        }
    }
    
    //MARK-url session delegates
    
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didWriteData bytesWritten: Int64, totalBytesWritten: Int64, totalBytesExpectedToWrite: Int64){
        
        let bytesWritten:Double=Double(totalBytesWritten)
        
        let bytesExpected:Double = Double(totalBytesExpectedToWrite)
        
        let percentDone:Float = Float(bytesWritten/bytesExpected)
        
        print(percentDone)
        DispatchQueue.main.async{
            let notificationDictionary:NSMutableDictionary=NSMutableDictionary.init()
            notificationDictionary.setValue(percentDone, forKey:"percentDone" )
            notificationDictionary.setValue(downloadTask, forKey: "downloadTask")
            
            NotificationCenter .default.post(name: NSNotification.Name(rawValue: "updateProgress"), object: notificationDictionary, userInfo: nil)
        }
        
        
    }
    
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL){
        let Url:URL = (downloadTask.currentRequest?.url)!
        
        let mediaData=NSData.init(contentsOf: location)
        var paths = NSSearchPathForDirectoriesInDomains(.documentDirectory,.userDomainMask , true)
        let documentDirectory = paths[0]
        print("-----\(paths)")
        
        let timeStamp:String=String(describing: NSDate())
        let mediaName="image\(timeStamp)"
        
        let mediaExtension=Url .pathExtension
        
        let filePath="\(documentDirectory)\(mediaName)\(mediaExtension)"
        
        mediaData? .write(toFile: filePath, atomically: true)
        
        UIImageWriteToSavedPhotosAlbum(UIImage(data:mediaData! as Data)!, nil, nil, nil)
        
        DispatchQueue.main.async{
            self.activeUrlString=nil
            self.session=nil
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "removeProgress"), object: nil, userInfo: nil)
        }
    }
}
