//
//  ThemeView.swift
//  ВКонтакте
//
//  Created by Михаил Чертов on 31.12.2023.
//

import UIKit

protocol ThemeViewProtocol {
    func updateColor()
}

class ThemeView: UIView {
    
    var delegateTheme: ThemeViewProtocol?
    
    //MARK: - Elements
    
    private let stackVerticalButton: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.spacing = 12
        stackView.distribution = .fill
        stackView.backgroundColor = .clear
        return stackView
    }()
    
    private var buttonSystemBack: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.borderColor = UIColor.black.cgColor
        button.layer.borderWidth = 1
        button.backgroundColor = SystemBackground().backgroundColor
        button.layer.cornerRadius = 7
        return button
    }()
    
    private var buttonGrayBack: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.borderColor = UIColor.black.cgColor
        button.layer.borderWidth = 1
        button.backgroundColor = LightGrayBackground().backgroundColor
        button.layer.cornerRadius = 7
        return button
    }()
    
    private var buttonRedBack: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.borderColor = UIColor.black.cgColor
        button.layer.borderWidth = 1
        button.backgroundColor = RedBackground().backgroundColor
        button.layer.cornerRadius = 7
        return button
    }()
    
    //MARK: - Init
    
    init() {
        super.init(frame: .zero)
        setupViews()
        buttonSystemBack.addTarget(self, action: #selector(tapSystemBack), for: .touchUpInside)
        buttonGrayBack.addTarget(self, action: #selector(tapGrayBack), for: .touchUpInside)
        buttonRedBack.addTarget(self, action: #selector(tapRedBack), for: .touchUpInside)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Layout
    
    private func setupViews() {
        stackVerticalButton.addArrangedSubview(buttonSystemBack)
        stackVerticalButton.addArrangedSubview(buttonGrayBack)
        stackVerticalButton.addArrangedSubview(buttonRedBack)
        addSubview(stackVerticalButton)
        setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            stackVerticalButton.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            stackVerticalButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            stackVerticalButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            stackVerticalButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 10)
        ])
    }
}

//MARK: - Method + Extension

private extension ThemeView {
    
    @objc func tapSystemBack() {
        Theme.currentTheme = SystemBackground()
        delegateTheme?.updateColor()
    }
    
    @objc func tapGrayBack() {
        Theme.currentTheme = LightGrayBackground()
        delegateTheme?.updateColor()
    }
    
    @objc func tapRedBack() {
        Theme.currentTheme = RedBackground()
        delegateTheme?.updateColor()
    }

}
