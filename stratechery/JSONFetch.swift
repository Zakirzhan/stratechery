//
//  JSONFetch.swift
//  stratechery
//
//  Created by macbook on 13.07.17.
//  Copyright © 2017 zaka. All rights reserved.
//

import Foundation
import ObjectMapper


class Project: NSObject, Mappable {
    
    var projectId: Int?
    var accountId: Int?
    var dateCreated: Int?
    var dateModified: Int?
    var title: String?
    var status: String?
    
    override init() {
        super.init()
    }
    
    convenience required init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        projectId <- map["id"]
        accountId <- map["account_id"]
        dateCreated <- map["date_created"]
        dateModified <- map["date_modified"]
        title <- map["title"]
        status <- map["status"]
    }
}
