//
//  Photo.swift
//  ВКонтакте
//
//  Created by Михаил Чертов on 31.12.2023.
//

class Photo: Decodable {
    
    var id: Int = 0
    var ownerId: Int = 0
    var sizes = [Sizes]()

    enum CodingKeys: String, CodingKey {
        case id
        case ownerId = "owner_id"
        case sizes
    }

}

class Sizes: Decodable {
    let url: String
}
