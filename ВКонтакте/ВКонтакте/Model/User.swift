//
//  User.swift
//  ВКонтакте
//
//  Created by Михаил Чертов on 31.12.2023.
//

struct ResponseUser<T: Decodable>: Decodable {
    let response: [T]
}

struct User: Decodable {
    var id: Int = 0
    var firstName: String = ""
    var lastName: String = ""
    var avatar: String = ""
    
    enum CodingKeys: String, CodingKey {
        case id
        case firstName = "first_name"
        case lastName = "last_name"
        case avatar = "photo_100"
    }
}

