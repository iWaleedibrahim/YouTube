//
//  FeedCell.swift
//  Youtube
//
//  Created by waleed on 12/11/19.
//  Copyright © 2019 iWi. All rights reserved.
//

import UIKit

class FeedCell: BaseCell {
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .black
        return cv
    }()
    
    override func setupViews() {
        super.setupViews()
        
        backgroundColor = .brown
        addSubview(collectionView)
        addConstraintsWithFormat(format: "H:|[v0]|", views: collectionView)
        addConstraintsWithFormat(format: "H:[v0]", views: collectionView)
    }
}
