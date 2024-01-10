//
//  Friends.swift
//  ВКонтакте
//
//  Created by Михаил Чертов on 31.12.2023.
//


protocol FriendsProtocol: Decodable {
    var id: Int {get}
    var firstName: String? {get}
    var lastName: String? {get}
    var avatar: String? {get}
    var city: City? {get}
    var online: Int {get}
}


struct Friends:FriendsProtocol {
    
    var id: Int
    var firstName: String?
    var lastName: String?
    var avatar: String?
    var city: City?
    var online: Int
    
    
    enum CodingKeys: String, CodingKey {
        case id
        case firstName = "first_name"
        case lastName = "last_name"
        case avatar = "photo_50"
        case online
        case city
        
    }
}

struct City: Decodable {
    var id: Int
    var title: String
}

