//
//  FeedCell.swift
//  Youtube
//
//  Created by waleed on 12/11/19.
//  Copyright © 2019 iWi. All rights reserved.
//

import UIKit

class FeedCell: BaseCell, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout   {
    
    let cellId = "cellId"
    var videos: [Video]?
    
    
    func fetchVideos() {
        ApiService.sharedInstance.fetchVideos {
            (videos: [Video]) in
            self.videos = videos
            self.collectionView.reloadData()
        }
    }
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = UIColor.clear
        cv.dataSource = self
        cv.delegate = self
        return cv
    }()
    
    override func setupViews() {
        super.setupViews()
        fetchVideos()
        addSubview(collectionView)
        addConstraintsWithFormat(format: "H:|[v0]|", views: collectionView)
        addConstraintsWithFormat(format: "V:|[v0]|", views: collectionView)
        
        collectionView.register(VideoCell.self, forCellWithReuseIdentifier: cellId)
    }
    
    

     func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //        if let count = videos?.count {
        //            return count
        //        }
        //        return 0
        return videos?.count ?? 0 // putting ?? 0 is same as commented code
    }
    
     func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellId", for: indexPath) as! VideoCell
        cell.video = videos?[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height = (frame.width - 16 - 16) * 9 / 16
        return CGSize(width: frame.width, height: height + 16 + 80)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }

    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}
