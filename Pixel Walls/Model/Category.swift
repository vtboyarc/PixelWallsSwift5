//
//  Category.swift
//  Pixel Walls
//
//  Created by Adam Carter on 12/10/17.
//  Copyright © 2017 Adam Carter. All rights reserved.
//

import Foundation

class Category:NSObject{
    var name:String?
    var count:Int = 0
    var thumbUrl:String?
    var wpaper:[WPaper]?
    
    struct SerializedKeys{
        static let name = "name"
    }
    
    class func handleResponse(response:Any?) -> [Category]{
        var model = [Category]()
        if let response = response as? [String:Any]{
            if let categories = response["Categories"] as? NSArray{
                for category in categories{
                    let object = Category()
                    let category =  category as? [String:Any]
                    object.name = category![SerializedKeys.name] as? String
                    model.append(object)
                }
            }
        }
        return model
    }
}
