//
//  Friends.swift
//  VK
//
//  Created by Михаил Чертов on 27.11.2023.
//


struct Friends: Decodable {
    
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
