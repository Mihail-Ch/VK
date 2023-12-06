//
//  GroupTableViewCell.swift
//  VK
//
//  Created by Михаил Чертов on 20.11.2023.
//

import UIKit

class GroupTableViewCell: UITableViewCell {

    static let reuseId = "groupTableViewCell"
    
    private let avatarGroupView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .red
        view.clipsToBounds = true
        return view
    }()
    
    private var avatarGroupImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.backgroundColor = .green
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        return image
    }()
    
    private var titleLabelGroup: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var descriptionGroup: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14)
        label.lineBreakMode = .byTruncatingTail
        label.numberOfLines = 2
        label.textColor = .gray
        return label
    }()
    
    private let stackVerticalTitle: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.spacing = 0
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    func configureCell(avatar: String, title: String, description: String) {
        self.avatarGroupImage.getPhoto(url: avatar)
        self.titleLabelGroup.text = title
        self.descriptionGroup.text = description
    }
    
    
    private func createUI() {
        contentView.addSubview(avatarGroupView)
        contentView.addSubview(avatarGroupImage)
        stackVerticalTitle.addArrangedSubview(titleLabelGroup)
        stackVerticalTitle.addArrangedSubview(descriptionGroup)
        contentView.addSubview(stackVerticalTitle)

        NSLayoutConstraint.activate([
            
            avatarGroupView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            avatarGroupView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            avatarGroupView.heightAnchor.constraint(equalToConstant: 50),
            avatarGroupView.widthAnchor.constraint(equalTo: avatarGroupView.heightAnchor, multiplier: 1/1),
            
            avatarGroupImage.centerYAnchor.constraint(equalTo: avatarGroupView.centerYAnchor),
            avatarGroupImage.centerXAnchor.constraint(equalTo: avatarGroupView.centerXAnchor),
            avatarGroupImage.heightAnchor.constraint(equalTo: avatarGroupView.heightAnchor),
            avatarGroupImage.widthAnchor.constraint(equalTo: avatarGroupView.widthAnchor, multiplier: 1/1),
            
            stackVerticalTitle.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            stackVerticalTitle.leadingAnchor.constraint(equalTo: avatarGroupView.trailingAnchor, constant: 10),
            stackVerticalTitle.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            stackVerticalTitle.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 15),
            stackVerticalTitle.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -15)
        ])
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        createUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
        
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        avatarGroupImage.image = nil
        titleLabelGroup.text = nil
        descriptionGroup.text = nil
    }
    
    override func layoutIfNeeded() {
        super.layoutIfNeeded()
        avatarGroupView.layer.cornerRadius = avatarGroupView.frame.size.width / 2
        avatarGroupImage.layer.cornerRadius = avatarGroupImage.frame.size.width / 2
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
