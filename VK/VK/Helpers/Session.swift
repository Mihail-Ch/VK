//
//  Session.swift
//  VK
//
//  Created by Михаил Чертов on 21.11.2023.
//

import UIKit

class Session {
    static let shared = Session()
    
    private init() { }
    var token: String = ""
    var userId: Int = 0
}
