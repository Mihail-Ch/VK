//
//  Response.swift
//  ВКонтакте
//
//  Created by Михаил Чертов on 31.12.2023.
//

import Foundation


struct Response<T:Decodable>: Decodable {
    var response: ResponseObject<T>
    
}

struct ResponseObject<T: Decodable>: Decodable {
    var count: Int
    var items: [T]
    
    enum CodingKeys: String, CodingKey {
        case count
        case items
    }
}
