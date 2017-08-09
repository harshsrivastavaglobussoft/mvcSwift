//
//  ReboundData.swift
//  DribbleInSwift
//
//  Created by Sumit Ghosh on 09/08/17.
//  Copyright © 2017 Sumit Ghosh. All rights reserved.
//

import UIKit

class ReboundData: NSObject {
    func getDataForReboundTable(callback: @escaping (NSArray) -> Void) -> Void {
        Apihelper.init() .getDataForRebound { (data) in
           callback(data)
        }
        
    }
}
