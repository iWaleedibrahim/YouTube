//
//  Video.swift
//  Youtube
//
//  Created by waleed on 11/30/19.
//  Copyright © 2019 iWi. All rights reserved.
//

import UIKit

class Video: NSObject {
    var title: String?
    var thumbnail_image_name: String?
    var channel: Channel?
    var number_of_views: NSNumber?
    var uploadDate: NSData?
    var duration: NSNumber?
}


class Channel: NSObject {
    var name: String?
    var profileImageName: String?
}
