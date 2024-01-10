//
//  Groups.swift
//  ВКонтакте
//
//  Created by Михаил Чертов on 31.12.2023.
//

protocol GroupsProtocol: Decodable {
    var id: Int {get}
    var name: String {get}
    var avatar: String {get}
    var caption: String {get}
}


struct Groups: GroupsProtocol {
   
    var id: Int
    var name: String
    var avatar: String
    var caption: String 
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case avatar = "photo_50"
        case caption = "description"
    }

}


