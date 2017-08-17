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
        let url="\(Configuration.BASIC_URL)\(Configuration.REBOUNDNAME)\(Configuration.ACCESS_TOKEN)"
        
        print(url)
        
      HTTPRequest.init().getRequestWithUrlString(urlString: url) { (response) in
        
             if response is NSArray {
                print(response)
                callback(response as! NSArray)
            }
        }
        
    }
    
    
    
    func dataForTimeTable(callback: @escaping (NSArray) -> Void) -> Void {
        
        let url = "\(Configuration.BASIC_URL)\(Configuration.TIME_NAME)\(Configuration.ACCESS_TOKEN)"
        
        
        HTTPRequest.init().getRequestWithUrlString(urlString: url) { (response) in
            
            if response is NSArray{
                print(response)
                callback(response as! NSArray)
            }
         }
    }
    
    func dataForPopularTable(callback: @escaping (NSArray) -> Void) -> Void{
        let url = "\(Configuration.BASIC_URL)\(Configuration.POPULAR_NAME)\(Configuration.ACCESS_TOKEN)"
        
        
        HTTPRequest.init().getRequestWithUrlString(urlString:url) { (response) in
            if response is NSArray{
                print(response)
                callback(response as! NSArray)
                
            }
        }
        
    }
    
}
