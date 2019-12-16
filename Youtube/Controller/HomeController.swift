//
//  ViewController.swift
//  YouTube
//
//  Created by waleed on 11/27/19.
//  Copyright © 2019 iWi. All rights reserved.
//

import UIKit

class HomeController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    var videos: [Video]?
    let cellId = "cellId"
    let trendingCellId = "trendingCellId"
    let subscriptionCellId = "subscriptionCellId"
    let titles = ["Home","Trending","Subscribtions","Account"]

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let titleLabel = UILabel(frame:CGRect(x: 0, y: 0, width: view.frame.width - 32 , height: view.frame.height))
        titleLabel.text = "  Home"
        titleLabel.textColor = UIColor.white
        titleLabel.font = UIFont.systemFont(ofSize: 20)
        navigationItem.titleView = titleLabel
        
        navigationController?.navigationBar.isTranslucent = false
        
        setupCollectionView()
        setupMenuBar()
        setupNavBarButtons()
        
    }
    
    
    func setupCollectionView() {
        // here we access the layout parameter in appDelegate
        if let flowLayout = collectionView?.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.scrollDirection = .horizontal
            flowLayout.minimumLineSpacing = 0
        }
        
    collectionView.backgroundColor = .white
//    collectionView.register(VideoCell.self, forCellWithReuseIdentifier: "cellId")
//    collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: cellId)
    collectionView.register(FeedCell.self, forCellWithReuseIdentifier: cellId)
    collectionView.register(TrendingCell.self, forCellWithReuseIdentifier: trendingCellId)
    collectionView.register(SubscriptionCell.self, forCellWithReuseIdentifier: subscriptionCellId)
    collectionView.contentInset = UIEdgeInsets(top: 50, left: 0, bottom: 0, right: 0)
    collectionView.scrollIndicatorInsets = UIEdgeInsets(top: 50, left: 0, bottom: 0, right: 0)
    collectionView.isPagingEnabled = true
    }
    
    
    
    func setupNavBarButtons() {
        let searchImage = UIImage(named:"search_icon")?.withRenderingMode(.alwaysOriginal)
        
        let searchBarButtonItem = UIBarButtonItem(image: searchImage, style: .plain, target: self, action: #selector(handleSearch))
        
        let moreButton = UIBarButtonItem(image: UIImage(named: "nav_more_icon")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(handleMore))
      
        navigationItem.rightBarButtonItems = [moreButton, searchBarButtonItem]
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    
    lazy var settingsLauncher: SettingsLauncher = {
        let launcher = SettingsLauncher()
        launcher.homeController = self
        return launcher
    }()
    
    @objc func handleMore() {
        settingsLauncher.showSettings()
    }
    
    @objc func handleSearch() {
        scrollToMenuIndex(menuIndex: 2)
    }
    
    func scrollToMenuIndex (menuIndex: Int) {
        let indexPath = NSIndexPath(item: menuIndex, section: 0)
        collectionView?.scrollToItem(at: indexPath as IndexPath, at: [], animated: true)
        setTitleForIndex(index: menuIndex)
    }
    
    
    private func setTitleForIndex (index: Int) {
        if let titleLabel = navigationItem.titleView as? UILabel {
            titleLabel.text = "  \(titles[index])"
        }
    }
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        print(scrollView.contentOffset.x)
        menuBar.horizontalBarLeftAnchorConstraint?.constant = scrollView.contentOffset.x / 4
    }
    
    
    override func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let index = targetContentOffset.move().x / view.frame.width
        let indexPath = NSIndexPath(item: Int(index), section: 0)
        menuBar.collectionView.selectItem(at: indexPath as IndexPath, animated: true, scrollPosition: [])
        
        setTitleForIndex(index: Int(index))

    }
    
    func showControllerForSetting(setting: Setting) {
        let dummySettingsViewController = UIViewController()
        dummySettingsViewController.view.backgroundColor = UIColor.white
        navigationController?.navigationBar.tintColor = UIColor.white
        dummySettingsViewController.navigationItem.title = setting.name.rawValue 
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationController?.pushViewController(dummySettingsViewController, animated: true)
    }
    

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let identifer: String
        
        if indexPath.item == 1 {
            identifer = trendingCellId
        }
        else if indexPath.item == 2 {
            identifer = subscriptionCellId
        }
        else {
            identifer = cellId
        }
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifer, for: indexPath)
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: view.frame.height - 70)
    }
        
    lazy var menuBar: MenuBar = {
        let mb = MenuBar()
        mb.homeController = self
        return mb
    }()
    
    private func setupMenuBar() {
        
        navigationController?.hidesBarsOnSwipe = true
        let redView = UIView()
        redView.backgroundColor = UIColor.rgb(red: 230, green: 32, blue: 31)
        view.addSubview(redView)
        view.addConstraintsWithFormat(format: "H:|[v0]|", views: redView)
        view.addConstraintsWithFormat(format: "V:[v0(50)]", views: redView)
        
        view.addSubview(menuBar)
        view.addConstraintsWithFormat(format: "H:|[v0]|", views: menuBar)
        view.addConstraintsWithFormat(format: "V:[v0(50)]", views: menuBar)
//        topLayoutGuide.topAnchor
        menuBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
    }
}

