//
//  HTTPRequest.swift
//  DribbleInSwift
//
//  Created by Sumit Ghosh on 08/08/17.
//  Copyright © 2017 Sumit Ghosh. All rights reserved.
//

import UIKit

class HTTPRequest: NSObject {
    func getRequestWithUrlString(urlString:String, callback: @escaping (Any) -> Void) -> Void{
        
        let searchUrl: URL = URL.init(string: urlString)!
        
        let request = NSMutableURLRequest(url:searchUrl as URL)
        
        request.httpMethod="GET"
        
        let task=URLSession.shared.dataTask(with: request as URLRequest) {
            data, response, error in
            
            // Check for error
            if error != nil
            {
                print("error=\(String(describing: error))")
                return
            }
            let responseString = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
            print("responseString = \(responseString!)")
    
            // Convert server json response to NSDictionary/NSArray
            do {
                let responseData = try JSONSerialization.jsonObject(with: data!, options: [JSONSerialization.ReadingOptions.allowFragments])
                
                callback(responseData)
            } catch _ as NSError {
                
                let responseString = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
                callback(responseString!)
                return
            }
        }
        task.resume()
    }
}
