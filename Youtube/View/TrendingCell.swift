//
//  TrendingCell.swift
//  Youtube
//
//  Created by waleed on 12/13/19.
//  Copyright © 2019 iWi. All rights reserved.
//

import UIKit

class TrendingCell: FeedCell {
    override func fetchVideos() {
        ApiService.sharedInstance.fetchTrendingFeed { (videos) in
            self.videos = videos
            self.collectionView.reloadData()
            print("The Self Variable is\(self)")
        }
    }
}



