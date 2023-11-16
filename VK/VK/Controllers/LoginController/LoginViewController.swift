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
        print("Hello world!")
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
        // Indentation at the scrollView, 0
        let contentInsets = UIEdgeInsets.zero
        scrollView.contentInset = contentInsets
    }
   
    @objc func hideKeyboard() {
        self.scrollView.endEditing(true)
    }

}

