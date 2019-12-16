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
    let baseUrl = "https://s3-us-west-2.amazonaws.com/youtubeassets"
    
    
    func fetchVideos(completion: @escaping ([Video])-> () ) {
        fetchFeedForUrlString(stringUrl: "\(baseUrl)/home.json", completion: completion)
    }
    
    func fetchTrendingFeed(completion: @escaping ([Video])-> () ) {
        fetchFeedForUrlString(stringUrl: "\(baseUrl)/trending.json", completion: completion)
    }
    
    func fetchsubscriptionFeed(completion: @escaping ([Video])-> () ) {
        fetchFeedForUrlString(stringUrl: "\(baseUrl)/subscriptions.json", completion: completion)
    }
    
    func fetchFeedForUrlString(stringUrl: String, completion: @escaping ([Video])-> () ) {
        
        // construch URL to provide for request function
        let url = URL(string: stringUrl)!
        // construct api request using the URLRequest function with the url
        let request = URLRequest(url: url)
        // construct dataTask with the url request.
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
                    video.thumbnail_image_name = dictionary["thumbnail_image_name"] as? String
                    video.number_of_views = dictionary["number_of_views"] as? NSNumber
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
        }
        task.resume()
    }
}


