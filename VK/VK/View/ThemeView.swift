//
//  ThemeView.swift
//  VK
//
//  Created by Михаил Чертов on 07.12.2023.
//

import UIKit

protocol ThemeViewProtocol {
    func updateColor()
}

final class ThemeView: UIView {
    
    var delegateTheme: ThemeViewProtocol?
    
    private let stackVerticalButton: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.spacing = 20
        stackView.distribution = .fill
        return stackView
    }()
    
    private var buttonSystemBack: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.borderColor = UIColor.black.cgColor
        button.layer.borderWidth = 1
        button.backgroundColor = SystemBackground().backgroundColor
        return button
    }()
    
    private var buttonGrayBack: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.borderColor = UIColor.black.cgColor
        button.layer.borderWidth = 1
        button.backgroundColor = LightGrayBackground().backgroundColor
        return button
    }()
    
    private var buttonRedBack: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.borderColor = UIColor.black.cgColor
        button.layer.borderWidth = 1
        button.backgroundColor = RedBackground().backgroundColor
        return button
    }()
    
    
    init() {
        super.init(frame: .zero)
        self.backgroundColor = .systemBlue//Theme.currentTheme.backgroundColor
        setupViews()
        buttonSystemBack.addTarget(self, action: #selector(tapSystemBack), for: .touchUpInside)
        buttonGrayBack.addTarget(self, action: #selector(tapGrayBack), for: .touchUpInside)
        buttonRedBack.addTarget(self, action: #selector(tapRedBack), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        stackVerticalButton.addArrangedSubview(buttonSystemBack)
        stackVerticalButton.addArrangedSubview(buttonGrayBack)
        stackVerticalButton.addArrangedSubview(buttonRedBack)
        addSubview(stackVerticalButton)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            stackVerticalButton.topAnchor.constraint(equalTo: topAnchor),
            stackVerticalButton.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackVerticalButton.trailingAnchor.constraint(equalTo: trailingAnchor),
            stackVerticalButton.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
}


private extension ThemeView {
    
    @objc func tapSystemBack() {
        Theme.currentTheme = SystemBackground()
        backgroundColor = Theme.currentTheme.backgroundColor
        delegateTheme?.updateColor()
    }
    
    @objc func tapGrayBack() {
        Theme.currentTheme = LightGrayBackground()
        backgroundColor = Theme.currentTheme.backgroundColor
        delegateTheme?.updateColor()
    }
    
    @objc func tapRedBack() {
        Theme.currentTheme = RedBackground()
        backgroundColor = Theme.currentTheme.backgroundColor
        delegateTheme?.updateColor()
    }
}
