//
//  Video.swift
//  Youtube
//
//  Created by waleed on 11/30/19.
//  Copyright © 2019 iWi. All rights reserved.
//

import UIKit

class Video: NSObject {
    var thumbnailImageName: String?
    var title: String?
    var channel: Channel?
    var numberOfViews: NSNumber?
    var uploadDate: NSData?
}



class Channel: NSObject {
    var name: String?
    var profileImageName: String?
}
