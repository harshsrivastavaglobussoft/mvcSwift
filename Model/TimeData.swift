//
//  TimeData.swift
//  DribbleInSwift
//
//  Created by Sumit Ghosh on 09/08/17.
//  Copyright © 2017 Sumit Ghosh. All rights reserved.
//

import UIKit

class TimeData: NSObject {
    func getDataForTimeTable(callback: @escaping (NSArray) -> Void) -> Void {
        Apihelper.init().dataForTimeTable { (dataTime) in
            let finalData:NSArray = MainModel.init().convertArrayToModel(dataArray: dataTime)
            callback(finalData)
        }
    }
}
