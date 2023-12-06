//
//  Groups.swift
//  VK
//
//  Created by Михаил Чертов on 27.11.2023.
//

struct Groups: Decodable {
   
    var id: Int
    var name: String
    var avatar: String
    var description: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case avatar = "photo_50"
        case description
    }

}
