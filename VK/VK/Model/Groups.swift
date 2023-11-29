//
//  Groups.swift
//  VK
//
//  Created by Михаил Чертов on 27.11.2023.
//

struct Groups: Codable {
   
    var id: Int
    var name: String
    var avatar: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case avatar = "photo_50"
    }
    
    
    
    
}
