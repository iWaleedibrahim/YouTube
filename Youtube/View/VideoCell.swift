//
//  VideoCell.swift
//  Youtube
//
//  Created by waleed on 11/30/19.
//  Copyright © 2019 iWi. All rights reserved.
//

import UIKit

class BaseCell: UICollectionViewCell {
    override init(frame: CGRect){
        super.init(frame:frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
        func setupViews() {
    
         }
    }

class VideoCell: BaseCell {
    
    var video: Video? {
        didSet {
            titleLabel.text = video?.title
            
            setupProfileImage()
            setupThumbnailImage()
            
//            if let thumbnailImageName = video?.thumbnailImageName {
//                thumbnailImageView.image = UIImage(named: thumbnailImageName)
//            }
            
            if let profileImageName = video?.channel?.profileImageName {
                userProfileImageView.image = UIImage(named: profileImageName)
            }
            if let channelName = video?.channel?.name, let numberOfViews = video?.numberOfViews {
                let numberFormatter = NumberFormatter()
                numberFormatter.numberStyle = .decimal
                let subtitleText = "\(String(describing: channelName)) • \(String(describing: numberFormatter.string(from: numberOfViews)!)) • 2 years ago"
                subtitleTextView.text = subtitleText
            }
            // MEASURE TITLE TEXT
            if let title = video?.title {
                let size = CGSize(width: frame.width - (16 + 44 + 8 + 16), height: 1000)
                let options = NSStringDrawingOptions.usesFontLeading.union((.usesLineFragmentOrigin))
                let estimatedRect = NSString(string: title).boundingRect(with: size, options: options, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14)], context: nil)
                
                if estimatedRect.size.width > 200 {
//                    print(estimatedRect.size.width)
                    titleLabelHeightContraint?.constant = 44
                }
                else {
//                    print(estimatedRect.size.width)
                    titleLabelHeightContraint?.constant = 20
                }
            }
        }
    }
    
    func setupThumbnailImage() {
        if let thumbnialImageUrl = video?.thumbnailImageName {
            thumbnailImageView.loadImageUsingUrlString( urlString: thumbnialImageUrl)
        }
    }
    
    func setupProfileImage () {
        if let profileImageUrl = video?.channel?.profileImageName  {
            userProfileImageView.loadImageUsingUrlString(urlString: profileImageUrl)
    }
}
    
    let thumbnailImageView: CustomImageView = {
        let imageView = CustomImageView()
        imageView.image = UIImage(named:"taylor_swift_blank_space")
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    let separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 230/255, green: 230/255, blue: 230/255, alpha: 1)
        return view
    }()
    
    
    let userProfileImageView: CustomImageView = {
        let imageView = CustomImageView()
        imageView.image = UIImage(named:"taylor_swift_profile")
        imageView.layer.cornerRadius = 22
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "stairway to heaven!"
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    let subtitleTextView: UITextView = {
        let textView = UITextView()
        textView.text = "using autolayouts and youtube api • 5,444,31 Views • 2 years ago"
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.textContainerInset = UIEdgeInsets(top: 0, left: -4, bottom: 0, right: 0)
        textView.textColor = UIColor.lightGray
        return textView
    }()
    
    var titleLabelHeightContraint: NSLayoutConstraint?
    
    override func setupViews() {
        addSubview(thumbnailImageView)
        addSubview(separatorView)
        addSubview(userProfileImageView)
        addSubview(titleLabel)
        addSubview(subtitleTextView)
        
        // inseated of using the syntax addContraints( NSLayout.....
        // we used NSLayoutContraint.activate( NSLayout...
        // refering to: https://stackoverflow.com/questions/47000671/cannot-convert-value-of-type-nslayoutconstraint-to-expected-argument-type-n
        // the second answer
        
        
        addConstraintsWithFormat(format: "H:|-16-[v0]-16-|", views: thumbnailImageView, userProfileImageView )
        
        //vertical constraints
        addConstraintsWithFormat(format: "V:|-16-[v0]-8-[v1(44)]-36-[v2(1)]|", views: thumbnailImageView, userProfileImageView, separatorView)
        
        //Horizontal constraints
        addConstraintsWithFormat(format: "H:|-16-[v0(44)]", views: userProfileImageView)
        addConstraintsWithFormat(format: "H:|[v0]|", views: separatorView)
        
        // top contriant:
        addConstraint(NSLayoutConstraint(item: titleLabel, attribute: .top, relatedBy: .equal, toItem: thumbnailImageView, attribute: .bottom, multiplier: 1, constant: 8))
        
        // left constraint:
        addConstraint(NSLayoutConstraint(item: titleLabel, attribute: .left, relatedBy: .equal, toItem: userProfileImageView, attribute: .right, multiplier: 1, constant: 8))
        
        //right constraint:
        addConstraint(NSLayoutConstraint(item: titleLabel, attribute: .right, relatedBy: .equal, toItem: thumbnailImageView, attribute: .right, multiplier: 1, constant: 0))
        
        // height contraint:
        titleLabelHeightContraint = NSLayoutConstraint(item: titleLabel, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 0, constant: 44)
        addConstraint(titleLabelHeightContraint!)
        
        
        
        // top contriant:
        addConstraint(NSLayoutConstraint(item: subtitleTextView, attribute: .top, relatedBy: .equal, toItem: titleLabel, attribute: .bottom, multiplier: 1, constant: 4))
        
        // left constraint:
        addConstraint(NSLayoutConstraint(item: subtitleTextView, attribute: .left, relatedBy: .equal, toItem: userProfileImageView, attribute: .right, multiplier: 1, constant: 8))
        
        //right constraint:
        addConstraint(NSLayoutConstraint(item: subtitleTextView, attribute: .right, relatedBy: .equal, toItem: thumbnailImageView, attribute: .right, multiplier: 1, constant: 0))
        
        // height contraint:
        addConstraint(NSLayoutConstraint(item: subtitleTextView, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 0, constant: 30))
    }
}





