//
//  User.swift
//  VK
//
//  Created by Михаил Чертов on 28.12.2020.
//
import UIKit

class Response: Decodable {
    var response: UserResponse
}

class UserResponse: Decodable {
    var userResponse: [User]
}

class User: Decodable {
    
    var id: Int = 0
    var firstName: String = ""
    var lastName: String = ""
    var avatar: String = ""
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case firstName = "first_name"
        case lastName = "last_name"
        case avatar = "photo_50"
    }
    
    convenience required init(from decoder: Decoder) throws {
        self.init()
        
        let values = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try values.decode(Int.self, forKey: .id)
        self.firstName = try values.decode(String.self, forKey: .firstName)
        self.lastName = try values.decode(String.self, forKey: .lastName)
        self.avatar = try values.decode(String.self, forKey: .avatar)
        
    }
}
