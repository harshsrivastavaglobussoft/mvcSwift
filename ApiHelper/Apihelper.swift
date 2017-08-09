//
//  Apihelper.swift
//  DribbleInSwift
//
//  Created by Sumit Ghosh on 09/08/17.
//  Copyright © 2017 Sumit Ghosh. All rights reserved.
//

import UIKit

class Apihelper: NSObject {
    func getDataForRebound(callback: @escaping (NSArray) -> Void) -> Void {
        Configuration.Singleton.sharedInstance.setData()
        let  URL = "\(Configuration.Singleton.sharedInstance.basicUrl!)\(Configuration.Singleton.sharedInstance.reboundToken!)"
        
        print(URL)
        
      HTTPRequest.init().getRequestWithUrlString(urlString: URL) { (response) in
        
             if response is NSArray {
                print(response)
                callback(response as! NSArray)
            }
        }
        
    }
    
    
    
    func dataForTimeTable(callback: @escaping (NSArray) -> Void) -> Void {
        
        Configuration.Singleton.sharedInstance.setData()
        let url = "\(Configuration.Singleton.sharedInstance.basicUrl!)\(Configuration.Singleton.sharedInstance.timeToken!)"
        
        HTTPRequest.init().getRequestWithUrlString(urlString: url) { (response) in
            
            if response is NSArray{
                print(response)
                callback(response as! NSArray)
            }
         }
    }
    
    func dataForPopularTable(callback: @escaping (NSArray) -> Void) -> Void{
    
        Configuration.Singleton.sharedInstance.setData()
        let url = "\(Configuration.Singleton.sharedInstance.basicUrl!)\(Configuration.Singleton.sharedInstance.popularToken!)"
        HTTPRequest.init().getRequestWithUrlString(urlString:url) { (response) in
            if response is NSArray{
                print(response)
                callback(response as! NSArray)
            }
        }
        
    }
    
}
