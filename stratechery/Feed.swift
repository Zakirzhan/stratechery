//
//  JSONFetch.swift
//  stratechery
//
//  Created by macbook on 13.07.17.
//  Copyright © 2017 zaka. All rights reserved.
//
import Foundation
import Alamofire
import ObjectMapper
import Cache


struct Feed {
    var title: String?
    var link: String?
    var imageLink: String?
    var date: String?
    var description: String?
    var html: String?
    //    var releaseDate: String
    
    init?(map: Map) {
        
    }
    
    static func fetchFeed(page: Int, callback: @escaping ([Feed]?, Error?) -> Void ){
        let cache = HybridCache(name: "Fetch")
        print("json\(page)")
        let json: JSON? = cache.object(forKey: "json\(page)")
        
            if json != nil {
//                print(json)
                let feeds = Mapper<Feed>().mapArray(JSONObject: json?.object)
            
            callback(feeds, nil)
//                print(feeds)
        } else  {
            let url = "http://uka.kz/"
            
            let params: [String: Any] = [
                "type" : "feed",
                "page" : page
            ]
            
            Alamofire.request(url, parameters: params).responseJSON { response in
                if let json = response.result.value {
                 
                    let feeds = Mapper<Feed>().mapArray(JSONObject: json)
                    do {
                        try cache.addObject(JSON.array(feeds!.toJSON()), forKey: "json\(page)")
                    }
                    catch {
                        print("Error")
                    }
                    callback(feeds, nil)
                }
                else {
                    callback(nil, response.error)
                }
            }
        }
        
        
    }
    
}

extension Feed: Mappable {
    mutating func mapping(map: Map) {
        title <- map["title"]
        link <- map["url"]
        imageLink <- map["image"]
        date <- map["date"]
        description <- map["content"]
        html <- map["html"]
    }
}
