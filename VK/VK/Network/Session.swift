//
//  Session.swift
//  VK
//
//  Created by Михаил Чертов on 21.01.2021.
//

import Foundation


class Session {
    
    static let shared = Session()

    private init() { }

    var userId: Int = 0
    var token: String = ""
    
    
}
