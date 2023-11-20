//
//  FriendsTableViewCell.swift
//  VK
//
//  Created by Михаил Чертов on 20.11.2023.
//

import UIKit

class FriendsTableViewCell: UITableViewCell {

    static let reuseId = "friendsTableViewCell"
    
    private let avatarView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.clipsToBounds = true
        view.layer.masksToBounds = false
        return view
    }()
    
    private let avatarImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.backgroundColor = .green
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        return image
    }()
    
    private let fullNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let descriptionUser: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .gray
        return label
    }()
    
    private let stackVerticalName: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.spacing = 2
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    private let phoneButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "phone"), for: .normal)
        return button
    }()
    
    private let messageButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "message"), for: .normal)
        return button
    }()
    
    private let stackVerticalPhoneButton: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.spacing = 10
        stackView.distribution = .fill
        return stackView
    }()
    
    //MARK: - @objk & func
    
    func configure(avatar: String?, firstName: String?, lastName: String?, year: String?, region: String?) {
        if let avatar = avatar {
            self.avatarImage.image = UIImage(named: avatar)
        }
        
        self.fullNameLabel.text = configureFullName(firstName: firstName, lastName: lastName)
        self.descriptionUser.text = configureDescriptionUser(year: year, region: region)
        
    }
    
    private func configureDescriptionUser(year: String?, region: String?) -> String? {
        "\(year ?? "") \(region ?? "")"
    }
    
    private func configureFullName(firstName: String?, lastName: String?) -> String? {
         "\(firstName ?? "") \(lastName ?? "")"
    }
    
    private func createUI() {
        contentView.addSubview(avatarView)
        contentView.addSubview(avatarImage)
        
        stackVerticalName.addArrangedSubview(fullNameLabel)
        stackVerticalName.addArrangedSubview(descriptionUser)
        contentView.addSubview(stackVerticalName)
        
        stackVerticalPhoneButton.addArrangedSubview(phoneButton)
        stackVerticalPhoneButton.addArrangedSubview(messageButton)
        contentView.addSubview(stackVerticalPhoneButton)
        
    }
    
    @objc
    private func pressPhoneButton() {
        print("----- I'm calling -----")
    }
    
    @objc
    private func pressMessageButton() {
        print("----- I'm writing a message -----")
    }
    
    //MARK: - Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        createUI()
        phoneButton.addTarget(self, action: #selector(pressPhoneButton), for: .touchUpInside)
        messageButton.addTarget(self, action: #selector(pressMessageButton), for: .touchUpInside)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Layout
    
    override func layoutIfNeeded() {
        super.layoutIfNeeded()
        avatarView.layer.cornerRadius = avatarView.frame.size.width / 2
        avatarImage.layer.cornerRadius = avatarImage.frame.size.width / 2
        
        avatarView.layer.shadowColor = UIColor.black.cgColor
        avatarView.layer.shadowOpacity = 1
        avatarView.layer.shadowRadius = 5
        avatarView.layer.shadowOffset = CGSize.zero
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        NSLayoutConstraint.activate([
            
            avatarView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            avatarView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            avatarView.heightAnchor.constraint(equalToConstant: 60),
            avatarView.widthAnchor.constraint(equalTo: avatarView.heightAnchor, multiplier: 1/1),
            
            avatarImage.centerYAnchor.constraint(equalTo: avatarView.centerYAnchor),
            avatarImage.centerXAnchor.constraint(equalTo: avatarView.centerXAnchor),
            avatarImage.heightAnchor.constraint(equalTo: avatarView.heightAnchor),
            avatarImage.widthAnchor.constraint(equalTo: avatarView.widthAnchor),
            
            stackVerticalName.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            stackVerticalName.leadingAnchor.constraint(equalTo: avatarView.trailingAnchor, constant: 10),
            stackVerticalName.trailingAnchor.constraint(equalTo: stackVerticalPhoneButton.leadingAnchor, constant: -10),
            stackVerticalName.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 15),
            stackVerticalName.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -15),
      
            stackVerticalPhoneButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            stackVerticalPhoneButton.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            stackVerticalPhoneButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            stackVerticalPhoneButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            
        ])
    }
  

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
