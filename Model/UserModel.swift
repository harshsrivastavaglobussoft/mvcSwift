//
//  UserModel.swift
//  DribbleInSwift
//
//  Created by Sumit Ghosh on 12/08/17.
//  Copyright © 2017 Sumit Ghosh. All rights reserved.
//

import UIKit

class UserModel: NSObject {
    var name:NSString?
    var avatar_url:NSString?
    var location:NSString?
    init(dataDict:NSDictionary) {
        self.name = dataDict["name"]as? NSString
        self.avatar_url=dataDict["avatar_url"]as? NSString
        self.location=dataDict["location"]as? NSString
    }
}
