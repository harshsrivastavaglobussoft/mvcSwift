//
//  MainModel.swift
//  DribbleInSwift
//
//  Created by Sumit Ghosh on 12/08/17.
//  Copyright © 2017 Sumit Ghosh. All rights reserved.
//

import UIKit

class MainModel: NSObject {
    var images:ImageModel!
    var user:UserModel!
    
    
    
    public func convertArrayToModel(dataArray:NSArray) -> NSArray {
        let finalArrayofModels:NSMutableArray = NSMutableArray.init()
        
        for data in dataArray {
            let model:MainModel = MainModel.init()
            let dataDict:NSDictionary=data as! NSDictionary
            let imageDict:NSDictionary = dataDict["images"] as! NSDictionary
            let userDict:NSDictionary = dataDict["user"] as! NSDictionary
            model.images=ImageModel.init(dataDict: imageDict)
            model.user=UserModel.init(dataDict: userDict)
            finalArrayofModels.add(model)
        }
        return finalArrayofModels;
    }
 
}
