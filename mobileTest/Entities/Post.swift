//
//  Post.swift
//  mobileTest
//
//  Created by Gio Valdes on 8/11/22.
//

import Foundation

struct Post:Decodable{
    var userId:Int32
    var id:Int32
    var title:String
    var body:String
    var isFavorite:Bool?
    var author:AuthorUser?
}

struct Comment:Decodable {
    var postId:Int
    var id:Int
    var name:String
    var email:String
    var body:String
}
