//
//  User.swift
//  mobileTest
//
//  Created by Gio Valdes on 10/11/22.
//

import Foundation

struct AuthorUser: Decodable {
    var id: Int32
    var name: String
    var username: String
    var email: String
    var address: AdreessUser?
    var phone: String?
    var website: String?
    var company: Company?
}

struct AdreessUser: Decodable {
    var street: String
    var suite: String
    var city: String
    var zipcode: String
    var geo: Geolocation
}
struct Geolocation: Decodable {
    var lat: String
    var lng: String
}
struct Company: Decodable {
    var name: String
    var catchPhrase: String
    var bs: String
}
