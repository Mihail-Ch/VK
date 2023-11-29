//
//  TestModel.swift
//  VK
//
//  Created by Михаил Чертов on 27.11.2023.
//

import Foundation

struct Response<T:Decodable>: Decodable {
    var response: ResponseObject<T>
    
}

struct ResponseObject<T: Decodable>: Decodable {
    var count: Int
    var items: [T]
    
    enum CodingKeys: String, CodingKey {
      //  case response
        case count
        case items
    }
}

