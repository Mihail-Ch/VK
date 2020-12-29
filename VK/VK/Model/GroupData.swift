//
//  GroupData.swift
//  VK
//
//  Created by Михаил Чертов on 29.12.2020.
//

import Foundation

class GroupData {
    
    static func groupFactory() -> [Group] {
        return [
            Group(avatar: "g", groupName: "People"),
            Group(avatar: "g1", groupName: "World"),
            Group(avatar: "g2", groupName: "Cars"),
            Group(avatar: "g", groupName: "Sport"),
            Group(avatar: "g2", groupName: "Apple"),
            Group(avatar: "g1", groupName: "Google"),
            Group(avatar: "g", groupName: "GeekBrains"),
            Group(avatar: "g2", groupName: "Chak"),
            Group(avatar: "g1", groupName: "Travel"),
            Group(avatar: "g", groupName: "Ski"),
            Group(avatar: "g2", groupName: "Eng"),
            Group(avatar: "g1", groupName: "Nike"),
            Group(avatar: "g", groupName: "Lex")
        ]
    }
}
