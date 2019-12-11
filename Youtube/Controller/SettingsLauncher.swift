//
//  SettingsLauncher.swift
//  Youtube
//
//  Created by waleed on 12/1/19.
//  Copyright © 2019 iWi. All rights reserved.
//

import UIKit



class Setting: NSObject {
    
    let name: SettingName
    let imageName: String?
    
    init(name: SettingName, imageName: String) {
        self.name = name
        self.imageName = imageName
    }
}


enum SettingName: String {
    case Settings = "settings"
    case TermsPrivacy = "Terms & Privacy"
    case SendFeedback = "Send Feedback"
    case Help = "Help"
    case SwitchAccount = "Switch Account"
    case Cancel = "Cancel & Dismiss"
}


class SettingsLauncher: NSObject, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    
    
    let blackView = UIView()
    let cellId = "cellId"
    let cellHeight: CGFloat = 50
    var homeController: HomeController?
    
    
    let settings: [Setting] = {
        let cancelSetting = Setting(name: .Cancel, imageName: "cancel")
        let settingsSetting = Setting(name: .Settings, imageName: "settings")
        
        return [settingsSetting,
                Setting(name: .TermsPrivacy, imageName: "privacy"),
                Setting(name: .SendFeedback, imageName: "feedback"),
                Setting(name: .Help, imageName: "help"),
                Setting(name: .SwitchAccount, imageName: "switch_account"),
               cancelSetting]
    }()
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = UIColor.white
        return cv
    }()
    
    @objc func showSettings() {
        if let window = UIApplication.shared.keyWindow{
            blackView.backgroundColor = UIColor.init(white: 0, alpha: 0.7)
            blackView.addGestureRecognizer( UITapGestureRecognizer(target: self, action: #selector(handleDismiss)))
            window.addSubview(blackView)
            window.addSubview(collectionView)
            let height: CGFloat = CGFloat(settings.count) * cellHeight
            let y: CGFloat = window.frame.height - height
            collectionView.frame = CGRect(x: 0, y: window.frame.height , width: window.frame.width, height: height)
            collectionView.isScrollEnabled = false
            blackView.frame = window.frame
            blackView.alpha = 0
            
        
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                self.blackView.alpha = 1
                self.collectionView.frame = CGRect(x: 0, y: y, width: self.collectionView.frame.width, height: self.collectionView.frame.height )
            }, completion: nil)
            
            
            
//            UIView.animate(withDuration: 0.3, animations: {
//                self.blackView.alpha = 1
//                self.collectionView.frame = CGRect(x: 0, y: y, width: self.collectionView.frame.width, height: self.collectionView.frame.height )
//            })
            
        }
    }
    
    
//    UIView.animate(withDuration: 0.5) {
//    self.blackView.alpha = 0
//    if let window = UIApplication.shared.keyWindow {
//    self.collectionView.frame = CGRect(x: 0, y: window.frame.height, width: self.collectionView.frame.width, height: self.collectionView.frame.height)
//    }
//    }
    
    @objc func handleDismiss (setting: Setting) {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            UIView.animate(withDuration: 0.5) {
                self.blackView.alpha = 0
                if let window = UIApplication.shared.keyWindow {
                    self.collectionView.frame = CGRect(x: 0, y: window.frame.height, width: self.collectionView.frame.width, height: self.collectionView.frame.height)
                }
            }
        }) { (completed: Bool) in
            if setting.name != .Cancel {
                self.homeController?.showControllerForSetting(setting: setting)
            }
            //HomeController().showControllerForSettings()
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return settings.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! SettingCell
        let setting = settings[indexPath.item]
        cell.setting = setting
        return cell
    }
    
    // used to edit cell size
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
       return CGSize(width: collectionView.frame.width, height: cellHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }

    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let setting = self.settings[indexPath.item]
        handleDismiss(setting: setting)
    }
    
    override init() {
        super.init()
            collectionView.dataSource = self
            collectionView.delegate = self
            collectionView.register(SettingCell.self, forCellWithReuseIdentifier: cellId)
    }
}

