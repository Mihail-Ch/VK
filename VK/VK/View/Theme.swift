//
//  Theme.swift
//  VK
//
//  Created by Михаил Чертов on 07.12.2023.
//

import UIKit

protocol AppTheme {
    var backgroundColor: UIColor { get }
    var textColor: UIColor { get }
}

final class Theme {
    
    static var currentTheme: AppTheme = SystemBackground()
    
}

final class SystemBackground: AppTheme {
    var textColor: UIColor = .black
    var backgroundColor: UIColor = .systemBackground
}

final class LightGrayBackground: AppTheme {
    var textColor: UIColor = .black
    var backgroundColor: UIColor = .lightGray
}

final class RedBackground: AppTheme {
    var backgroundColor: UIColor = .systemRed
    var textColor: UIColor = .systemBlue
}
