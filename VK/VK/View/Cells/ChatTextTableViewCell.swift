//
//  ChatTableViewCell.swift
//  VK
//
//  Created by Михаил Чертов on 20.11.2023.
//

import UIKit

class ChatTextTableViewCell: UITableViewCell {

    static let reuseId = "chatTableViewCell"
    
    private let textChat: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textAlignment = .left
        return label
    }()
    
    private func createUI() {
        contentView.addSubview(textChat)

        NSLayoutConstraint.activate([
            
            textChat.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            textChat.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            textChat.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            
        ])
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = Theme.currentTheme.backgroundColor
        createUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
        
    }
    
    func configureLeft() {
        textChat.text = "Делаем подобие чата :)"
    }
    func configureRight() {
        textChat.text = "Вроде что - то получилось, но у текста не хватает лица :)"
        textChat.textAlignment = .right
        textChat.textColor = .darkGray
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        textChat.text = nil
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}

