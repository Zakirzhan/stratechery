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



struct Feed {
    var title: String?
    var link: String?
    var imageLink: String?
    var date: String?
    //    var releaseDate: String
    
    init?(map: Map) {
        
    }
    
    static func fetchFeed(callback: @escaping ([Feed]?, Error?) -> Void ){
        let url = "http://uka.kz/?type=feed&page=4"
        Alamofire.request(url).responseJSON { response in
//            print(response)
            if let json = response.result.value {
                let feeds = Mapper<Feed>().mapArray(JSONObject: json)
                callback(feeds, nil)
                // serialized json response
            }//          let feeds = Mapper<Feed>().mapArray(JSONObject: json)
        }
        
    }
    
}


extension Feed: Mappable {
    mutating func mapping(map: Map) {
        title <- map["title"]
        link <- map["url"]
        imageLink <- map["image"]
        date <- map["date"]
    }
}
