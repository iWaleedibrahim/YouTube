//
//  SubscriptionCell.swift
//  Youtube
//
//  Created by waleed on 12/15/19.
//  Copyright © 2019 iWi. All rights reserved.
//

import UIKit

class SubscriptionCell: FeedCell {
    
    override func fetchVideos() {
        ApiService.sharedInstance.fetchsubscriptionFeed{ (videos) in
            self.videos = videos
            self.collectionView.reloadData()
        }
    }
}
