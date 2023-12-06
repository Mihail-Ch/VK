//
//  ProfileViewController.swift
//  VK
//
//  Created by Михаил Чертов on 04.12.2023.
//

import UIKit

class ProfileViewController: UIViewController {
    
    private var vkApi = VKApi()
    
    private let viewProfile: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .green
        view.clipsToBounds = true
        view.layer.masksToBounds = false
        return view
    }()
    
    private let imageProfile: UIImageView = {
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
        label.font = UIFont.boldSystemFont(ofSize: 25)
        label.textAlignment = .center
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Профиль"
        view.backgroundColor = .systemBackground
        view.addSubview(viewProfile)
        view.addSubview(imageProfile)
        view.addSubview(fullNameLabel)
        setupShadow()
        createConstraints() 
       
        vkApi.getUser { [weak self] user in
            self?.configure(avatar: user.avatar, firstName: user.firstName, lastName: user.lastName)
        }
    }
    
    func configure(avatar: String?, firstName: String?, lastName: String?) {
        if let avatar = avatar {
            self.imageProfile.getPhoto(url: avatar)
        }
        self.fullNameLabel.text = configureFullName(firstName: firstName, lastName: lastName)
    }
    
    private func configureFullName(firstName: String?, lastName: String?) -> String? {
            "\(firstName ?? "") \(lastName ?? "")"
    }
    
    private func setupShadow() {

        viewProfile.layer.shadowColor = UIColor.black.cgColor
        viewProfile.layer.shadowOpacity = 1
        viewProfile.layer.shadowRadius = 5
        viewProfile.layer.shadowOffset = CGSize.zero
    }
    
    private func createConstraints() {
        let avatarSize = view.bounds.size.width / 3
        viewProfile.layer.cornerRadius = avatarSize / 2
        imageProfile.layer.cornerRadius = avatarSize / 2
        
        NSLayoutConstraint.activate([
            viewProfile.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
            viewProfile.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            viewProfile.widthAnchor.constraint(equalToConstant: avatarSize),
            viewProfile.heightAnchor.constraint(equalTo: viewProfile.widthAnchor),
            
            imageProfile.topAnchor.constraint(equalTo: viewProfile.topAnchor),
            imageProfile.trailingAnchor.constraint(equalTo: viewProfile.trailingAnchor),
            imageProfile.leadingAnchor.constraint(equalTo: viewProfile.leadingAnchor),
            imageProfile.bottomAnchor.constraint(equalTo: viewProfile.bottomAnchor),
            
            fullNameLabel.topAnchor.constraint(equalTo: viewProfile.bottomAnchor, constant: 20),
            fullNameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            fullNameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 10),
            fullNameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
            
    }
}


