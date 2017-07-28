
//  Created by macbook on 13.07.17.
//  Copyright © 2017 zaka. All rights reserved.
//
import Foundation
import Alamofire
import ObjectMapper

struct Page {
    var title: String? 
    var html: String?
    //    var releaseDate: String
    
    init?(map: Map) {
        
    }
    
    static func parsePage(year: Int, callback: @escaping (Page?, Error?) -> Void ){
        let url = "http://uka.kz/parser.php"
        
        let params: [String: Any] = [
            "year" : year,
            "format" : "json",
        ]
        
        Alamofire.request(url, parameters: params).responseJSON { response in
//            print(response)
            if let json = response.result.value {
                let feeds = Mapper<Page>().map(JSONObject: json)
                callback(feeds, nil)
            }
            else {
                print(response.error)
                callback(nil, response.error)

            }
        }
        
    }
    
}

extension Page: Mappable {
    mutating func mapping(map: Map) {
        title <- map["title"]
        html <- map["html"]
    }
}

struct MyPage {
    var year: Int
    var title: String
}
