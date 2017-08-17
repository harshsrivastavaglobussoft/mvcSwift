//
//  PopularData.swift
//  DribbleInSwift
//
//  Created by Sumit Ghosh on 09/08/17.
//  Copyright © 2017 Sumit Ghosh. All rights reserved.
//

import UIKit
class PopularData: NSObject {
    
    func getDataForPopularTable(callback: @escaping (NSArray) -> Void) -> Void {
        Apihelper.init().dataForPopularTable { (dataPopular) in
            let finalData:NSArray = MainModel.init().convertArrayToModel(dataArray: dataPopular)
            callback(finalData)
        }
    }
}
