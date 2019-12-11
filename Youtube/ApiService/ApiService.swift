//
//  ApiService.swift
//  Youtube
//
//  Created by waleed on 12/10/19.
//  Copyright © 2019 iWi. All rights reserved.
//

import UIKit

class ApiService: NSObject {

    
    static let sharedInstance = ApiService()
    
    func fetchVideos(completion: @escaping ([Video])-> () ) {
        
        // URLify the string to be of type url that URLRequest function accept as paramater of type URL
        let url = URL(string: "https://s3-us-west-2.amazonaws.com/youtubeassets/home.json")!
        let request = URLRequest(url: url)
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if error != nil {
                print((error)!)
                return
            }
            
            
            do {
                let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers)
                
                var videos = [Video]()
                for dictionary in json as! [[String: AnyObject]] {
                    let video = Video()
                    video.title = dictionary["title"] as? String
                    video.thumbnailImageName = dictionary["thumbnail_image_name"] as? String
                    let channelDictionary = dictionary["channel"] as? [String: AnyObject]
                    let channel = Channel()
                    channel.name = channelDictionary?["name"] as? String
                    channel.profileImageName = channelDictionary?["profile_image_name"] as? String
                    video.channel = channel
                    
                    videos.append(video)
                  }
                DispatchQueue.main.async {
                   completion(videos)
                }
                
            }
            catch let jsonError {
                print(jsonError)
            }
            
            //            let string = NSString(da ta: data!, encoding: String.Encoding.utf8.rawValue)
            //            print(string!)
            
        }
        task.resume()
    }
}

