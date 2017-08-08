//
//  Configuration.swift
//  DribbleInSwift
//
//  Created by Sumit Ghosh on 07/08/17.
//  Copyright © 2017 Sumit Ghosh. All rights reserved.
//

import UIKit


class Configuration: NSObject {
    var basicUrl:NSString!
    var popularToken:NSString!
    var timeToken:NSString!
    var reboundToken:NSString!
    
    class Singleton {
        static let sharedInstance: Singleton = {
            let instance = Singleton()
            return instance
        }()
    }
    //to make it thread safe
    private let accessQueue = DispatchQueue(label: "SynchronizedAccess", attributes: .concurrent)
    
    func setData() -> Void {
        self.accessQueue.sync() {
            basicUrl="https://api.dribbble.com/v1/shots?sort=&"
        popularToken="access_token=a589847521cfb6420457b84d97addee8c7b108ad49d9a5768f66109bc0bbea21"
        timeToken="list=teams&access_token=a589847521cfb6420457b84d97addee8c7b108ad49d9a5768f66109bc0bbea21"
        reboundToken="list=rebounds&access_token=a589847521cfb6420457b84d97addee8c7b108ad49d9a5768f66109bc0bbea21"
        }
    }
    
}
