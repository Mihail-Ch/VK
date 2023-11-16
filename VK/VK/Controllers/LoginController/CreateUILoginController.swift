//
//  CreateUILoginController.swift
//  VK
//
//  Created by Михаил Чертов on 15.11.2023.
//

import UIKit


extension LoginViewController {
    
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
    
    private func createScrollView() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.showsVerticalScrollIndicator = true
        scrollView.isDirectionalLockEnabled = true
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.backgroundColor = .clear
    }
    
    private func createImageLogo() {
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
