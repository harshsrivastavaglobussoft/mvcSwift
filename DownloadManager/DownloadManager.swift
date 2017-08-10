//
//  DownloadManager.swift
//  DribbleInSwift
//
//  Created by Sumit Ghosh on 10/08/17.
//  Copyright © 2017 Sumit Ghosh. All rights reserved.
//

import UIKit
import Foundation
class DownloadManager: NSObject,URLSessionDelegate{
    
//    private override init() {
//        
//        class DownLoadSingleton {
//        }
//    }
    
    static let sharedInstance: DownloadManager = {
        let instance = DownloadManager()
        return instance
    }()
    private let accessQueue = DispatchQueue(label: "SynchronizedAccess", attributes: .concurrent)
    
    var session:URLSession!
    var activeUrlString:URL!
    var task:URLSessionDownloadTask!
    
    func startDownload(url:URL) -> Void {
        let queue:OperationQueue=OperationQueue.init()
        queue.maxConcurrentOperationCount=5
        self.accessQueue.sync() {
            self.activeUrlString = url
        }
        if self.session==nil {
            let configuration:URLSessionConfiguration = URLSessionConfiguration .background(withIdentifier: "image")
            
            self.accessQueue.sync() {
                
                self.session = URLSession.init(configuration: configuration, delegate: self as? URLSessionDelegate, delegateQueue: queue)
                
            }
            let request:URLRequest=URLRequest.init(url: url)
            self.accessQueue.sync() {
                
                self.task = self.session.downloadTask(with: request)
            }
            
            self.task.resume()
        }
    }
    
    //MARK-url session delegates
    
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didWriteData bytesWritten: Int64, totalBytesWritten: Int64, totalBytesExpectedToWrite: Int64){
        
        let percentDone:Float = Float(totalBytesWritten/totalBytesExpectedToWrite)
        
        print(percentDone)
    }
    
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL){
        
        
    }
}
