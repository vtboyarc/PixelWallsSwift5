//
//  WPaper.swift
//  Pixel Walls
//
//  Created by Adam Carter on 12/10/17.
//  Copyright © 2017 Adam Carter. All rights reserved.
//

import Foundation

class WPaper:NSObject{
    var author:String?
    var url:String?
    var thumbUrl:String?
    var name:String?
    var category:String?
    
    struct SerializationKeys {
        static let author = "author"
        static let url = "url"
        static let thumbUrl = "thumbUrl"
        static let name = "name"
        static let category = "category"
    }
    class func handleResponse(responseObject:[String:Any]?) -> WPaper{
        let model = WPaper()
        if let response = responseObject{
            model.author = response[SerializationKeys.author] as? String
            model.url = response[SerializationKeys.url] as? String
            model.thumbUrl = response[SerializationKeys.thumbUrl] as? String
            model.name = response[SerializationKeys.name] as? String
            model.category = response[SerializationKeys.category] as? String
        }
        return model
    }
}
