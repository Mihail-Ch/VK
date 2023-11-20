//
//  ViewController.swift
//  VK
//
//  Created by Михаил Чертов on 15.11.2023.
//

import UIKit

class LoginViewController: UIViewController {
    
    lazy var scrollView = UIScrollView()
    lazy var imageLogin = UIImageView()
    lazy var titleVK = UILabel()
    lazy var loginTextField = UITextField()
    lazy var passwordTextField = UITextField()
    lazy var loginButton = UIButton(type: .system)
    
    
    //MARK: - Live Cicle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        addUI()
        createUI()
        hideKeyboardGesture()
        loginButton.addTarget(self, action: #selector(pressButtonLogin), for: .touchUpInside)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(self.keyboardWasShown(notification:)),
                                               name: UIResponder.keyboardWillShowNotification,
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(self.keyboardWillBeHidden(notification:)),
                                               name: UIResponder.keyboardWillHideNotification,
                                               object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    

    //MARK: - Method
    
    private func addUI() {
        view.addSubview(scrollView)
        scrollView.addSubview(imageLogin)
        scrollView.addSubview(titleVK)
        scrollView.addSubview(loginTextField)
        scrollView.addSubview(passwordTextField)
        scrollView.addSubview(loginButton)
        
       
    }
    
    @objc private func pressButtonLogin(_ sender: Any) {
        showNextControllers()
    }
    
    //MARK: - Navigation
    
    private func showNextControllers() {
        let tabBar = UITabBarController()
        let friendsController = UINavigationController(rootViewController: FriendsViewController())
        let groupsController = UINavigationController(rootViewController: GroupsViewController())
        let photoController = UINavigationController(rootViewController: PhotosViewController())
        
        friendsController.title = "Друзья"
        groupsController.title = "Группы"
        photoController.title = "Фото"
        
        tabBar.setViewControllers([friendsController, groupsController, photoController], animated: true)
        
        guard let items = tabBar.tabBar.items else { return }
        let images = ["person.2", "person.3", "photo.stack"]
        
        for x in 0..<images.count {
            items[x].image = UIImage(systemName: images[x])
        }
        tabBar.modalPresentationStyle = .fullScreen
        present(tabBar, animated: true)
    }
    
    
    //MARK: Keyboard
    
    private func hideKeyboardGesture() {
        let hideKeyboardGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        scrollView.addGestureRecognizer(hideKeyboardGesture)
    }
    
    //Keyboard appears
    @objc private func keyboardWasShown(notification: Notification) {
        //size
        let info = notification.userInfo! as NSDictionary
        let kbSize = (info.value(forKey: UIResponder.keyboardFrameEndUserInfoKey) as! NSValue).cgRectValue.size
        let contentInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: kbSize.height, right: 0.0)
        
        self.scrollView.contentInset = contentInsets
        scrollView.scrollIndicatorInsets = contentInsets
    }
    
    //Keyboard disappears
    @objc private func keyboardWillBeHidden(notification: Notification) {
        // Indentation at the scrollView,
        let contentInsets = UIEdgeInsets.zero
        scrollView.contentInset = contentInsets
    }
   
    @objc func hideKeyboard() {
        self.scrollView.endEditing(true)
    }

}


//MARK: - Extension SetupUI

private extension LoginViewController {
    
    func createUI() {
        createScrollView()
        createImageLogo()
        createTitle()
        createLoginTextField()
        createPasswordTextField()
        createLoginButton()
        
        createConstraints()
    }
    
    //MARK: - Setup UI
    
    func createScrollView() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.showsVerticalScrollIndicator = true
        scrollView.isDirectionalLockEnabled = true
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.backgroundColor = .clear
    }
    
    func createImageLogo() {
        imageLogin.translatesAutoresizingMaskIntoConstraints = false
        imageLogin.contentMode = .scaleAspectFit
        imageLogin.image = UIImage(named: "logo")
    }
    
    private func createTitle() {
        titleVK.translatesAutoresizingMaskIntoConstraints = false
        titleVK.text = "Вход ВКонтакте"
        titleVK.font = UIFont.boldSystemFont(ofSize: 25)
    }
    
    private func createLoginTextField() {
        loginTextField.translatesAutoresizingMaskIntoConstraints = false
        loginTextField.borderStyle = .roundedRect
        loginTextField.backgroundColor = UIColor(hex: "EEF0F1")
        let placeholder = NSAttributedString(string: "Телефон или почта", attributes: [
            .foregroundColor: UIColor.systemGray,
            .font: UIFont.systemFont(ofSize: 14)
        ])
        loginTextField.attributedPlaceholder = placeholder
    }
    
    private func createPasswordTextField() {
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        passwordTextField.borderStyle = .roundedRect
        passwordTextField.backgroundColor = UIColor(hex: "EEF0F1")
        let placeholder = NSAttributedString(string: "Пароль", attributes: [
            .foregroundColor: UIColor.systemGray,
            .font: UIFont.systemFont(ofSize: 14)
        ])
        passwordTextField.attributedPlaceholder = placeholder
    }
    
    private func createLoginButton() {
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        loginButton.setTitle("Войти", for: .normal)
        loginButton.backgroundColor = UIColor(hex: "457EDA")
        loginButton.tintColor = .white
        loginButton.layer.cornerRadius = 7
    }
    
    //MARK: - Constraints
    
    private func createConstraints() {
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            imageLogin.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor, constant: 170),
            imageLogin.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            imageLogin.widthAnchor.constraint(equalToConstant: 60),
            imageLogin.heightAnchor.constraint(equalToConstant: 60),
            
            titleVK.topAnchor.constraint(equalTo: imageLogin.bottomAnchor, constant: 20),
            titleVK.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            
            loginTextField.topAnchor.constraint(equalTo: titleVK.bottomAnchor, constant: 20),
            loginTextField.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            loginTextField.leadingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leadingAnchor, constant: 15),
            loginTextField.trailingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.trailingAnchor, constant: 15),
            loginTextField.heightAnchor.constraint(equalToConstant: 40),
            
            passwordTextField.topAnchor.constraint(equalTo: loginTextField.bottomAnchor, constant: 5),
            passwordTextField.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            passwordTextField.leadingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leadingAnchor, constant: 15),
            passwordTextField.trailingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.trailingAnchor, constant: 15),
            passwordTextField.heightAnchor.constraint(equalToConstant: 40),
            
            loginButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 20),
            loginButton.leadingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leadingAnchor, constant: 15),
            loginButton.trailingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.trailingAnchor, constant: 15),
            loginButton.heightAnchor.constraint(equalToConstant: 40),
            loginButton.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor, constant: 20),
        ])
    }
    
}

