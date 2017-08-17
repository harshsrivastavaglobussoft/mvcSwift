//
//  ImageModel.swift
//  DribbleInSwift
//
//  Created by Sumit Ghosh on 12/08/17.
//  Copyright © 2017 Sumit Ghosh. All rights reserved.
//

import UIKit

class ImageModel: NSObject {
    var normal:NSString?
    var teaser:NSString?
    var hidpi:NSString?
    
    init(dataDict: NSDictionary) {
        self.normal=dataDict["normal"] as? NSString
        self.teaser=dataDict["teaser"] as? NSString
        self.hidpi=dataDict["hidpi"] as? NSString
    }
}
