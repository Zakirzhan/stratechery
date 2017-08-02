
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
    
    static func parsePage(type: String, id: String, callback: @escaping (Page?, Error?) -> Void ){
        let url = "http://uka.kz/parser.php"
        var params: [String: String] = ["format" : "json"]

        if type == "year" {
        params["year"] = id

        }
        else {
         params["page"]=id
        }
        print(params)
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
    var type: String
    var id: String
    var title: String
    var icon: String
}
