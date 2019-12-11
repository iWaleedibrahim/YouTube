//
//  Extensions.swift
//  Youtube
//
//  Created by waleed on 11/30/19.
//  Copyright © 2019 iWi. All rights reserved.
//

import UIKit

extension UIColor {
    static func rgb( red:CGFloat, green:CGFloat, blue:CGFloat ) -> UIColor {
        return UIColor(red: red/255, green: green/255, blue: blue/255, alpha: 1)
    }
}

extension UIView {
    func addConstraintsWithFormat(format: String, views: UIView...) {
        var viewsDictionary = [String: UIView]()
        for (index, view) in views.enumerated() {
            let key = "v\(index)"
            view.translatesAutoresizingMaskIntoConstraints = false
            viewsDictionary[key] = view
        }
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: format, options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: viewsDictionary))
    }
}


let imageCache = NSCache<AnyObject, AnyObject>()

// this class includes the solution to the common rendering problem of the UIcollection view or tableview
 // of mixing data between cells due to connection issues
  // we use NSCache.

class CustomImageView: UIImageView {
    
    var imageUrlString: String?
    
    func loadImageUsingUrlString (urlString: String) {
            imageUrlString = urlString // used to make sure each photo in the correct cell
            image = nil
        
        if let imageFromCache = imageCache.object(forKey: urlString as AnyObject) as? UIImage {
            self.image = imageFromCache
            return
        }
        
        
            let url = URL(string: urlString)
            let request = URLRequest(url: url!)
            let task = URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error ) in
                if error != nil {
                    print(error!)
                    return
                }
                else {
                    DispatchQueue.main.async {
                        let imageToCache = UIImage(data: data!)
                        if self.imageUrlString == urlString {
                            self.image = imageToCache
                        }
                        imageCache.setObject(imageToCache!,forKey:  urlString as AnyObject )
                    }
                }
            })
        task.resume()
    }
}

