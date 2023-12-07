//
//  ProfileViewController.swift
//  VK
//
//  Created by Михаил Чертов on 04.12.2023.
//

import UIKit

class ProfileViewController: UIViewController {
    
    private var vkApi = VKApi()
    private var isTap: Bool = false
    private var isUserProfile: Bool
    
    init(name: String? = nil, photo: UIImage? = nil, isUserProfile: Bool) {
        self.isUserProfile = isUserProfile
        super.init(nibName: nil, bundle: nil)
        imageProfile.image = photo
        fullNameLabel.text = name
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var viewTheme: ThemeView = {
        let view = ThemeView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
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

    private let changeColor: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Сменить цвет", for: .normal)
        button.backgroundColor = UIColor(hex: "457EDA")
        button.tintColor = .white
        button.layer.cornerRadius = 7
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Профиль"
        view.backgroundColor = Theme.currentTheme.backgroundColor
        navigationController?.navigationBar.backgroundColor = Theme.currentTheme.backgroundColor
        view.addSubview(viewProfile)
        view.addSubview(imageProfile)
        view.addSubview(fullNameLabel)
        view.addSubview(viewTheme)
        changeColor.addTarget(self, action: #selector(buttonChangeColor), for: .touchUpInside)
        setupShadow()
        createConstraints()
        vkApi.getUser { [weak self] user in
            self?.configure(avatar: user.avatar, firstName: user.firstName, lastName: user.lastName)
        }
        
        if isUserProfile {
            vkApi.getUser { [weak self] user in
                self?.updateData(model: user)
            }
        } else {
            viewTheme.isHidden = true
        }
    }
    
    //MARK: Method && @objc
    
    func updateData(model: User?) {
        guard let model = model else {
            return
        }
        if let url = URL(string: model.avatar ?? ""),
           let data = try? Data(contentsOf: url) {
            DispatchQueue.main.async {
                self.imageProfile.image = UIImage(data: data)
            }
        }
        DispatchQueue.main.async {
            self.configureFullName(firstName: model.firstName, lastName: model.lastName)
        }
    }
    
    @objc private func buttonChangeColor() {
        isTap.toggle()
        if isTap {
            Theme.currentTheme = RedBackground()
            view.backgroundColor = Theme.currentTheme.backgroundColor
        } else {
            Theme.currentTheme = SystemBackground()
            view.backgroundColor = Theme.currentTheme.backgroundColor

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
    
    //MARK: - Create Constraint
    
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
            
            viewTheme.topAnchor.constraint(equalTo: fullNameLabel.bottomAnchor, constant: 20),
            viewTheme.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            viewTheme.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            viewTheme.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -300),
            //viewProfile.heightAnchor.constraint(equalToConstant: 40),
            
        ])
            
    }
}


extension ProfileViewController: ThemeViewProtocol {
    func updateColor() {
        view.backgroundColor = Theme.currentTheme.backgroundColor
        fullNameLabel.textColor = Theme.currentTheme.textColor
    }
    
    
    
}
