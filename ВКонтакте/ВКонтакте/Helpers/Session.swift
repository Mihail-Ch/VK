//
//  Session.swift
//  ВКонтакте
//
//  Created by Михаил Чертов on 31.12.2023.
//

import UIKit

class Session {
    static let shared = Session()
    
    private init() { }
    var token: String = ""
    var userId: Int = 0
}
