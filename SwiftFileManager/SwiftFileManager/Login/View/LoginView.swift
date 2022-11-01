//
//  LoginView.swift
//  SwiftFileManager
//
//  Created by m.khutornaya on 01.11.2022.
//

import Foundation
import UIKit

class LoginView: UIView {

    public var scrollViewConstraint: NSLayoutConstraint!

    private let scrollView: UIScrollView = {
        let view = UIScrollView()

        view.translatesAutoresizingMaskIntoConstraints = false

        return view
    }()

    private let contentView: UIView = {
        let view = UIView()

        view.translatesAutoresizingMaskIntoConstraints = false

        return view
    }()

    private let backgroundView: UIView = {
        let view = UIView()

        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .systemGray6
        view.layer.borderWidth = 0.5
        view.layer.borderColor = UIColor.lightGray.cgColor
        view.layer.cornerRadius = 10

        return view
    }()

    private lazy var inputPasswordField: UITextField = {
        let view = UITextField()

        view.placeholder = "Введите пароль"
        view.textColor = .black
        view.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        view.autocapitalizationType = .none
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isSecureTextEntry = true
        view.delegate = self
        view.tintColor = .darkGray

        return view
    }()

    private lazy var loginButton: UIButton = {
        let view = UIButton()

        view.layer.cornerRadius = 10
        view.layer.masksToBounds = true
        view.backgroundColor = .systemBlue
        view.translatesAutoresizingMaskIntoConstraints = false

        return view
    }()

    public var onTapButtonHandler: (() -> Void)? {
        didSet {
            loginButton.addTarget(self, action: #selector(tapWrapper), for: .touchUpInside)
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setUp()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setUp() {
        backgroundColor = .white
        addSubview(scrollView)
        scrollView.addSubview(contentView)

        let subviews = [backgroundView, loginButton]
        subviews.forEach { contentView.addSubview($0) }
        backgroundView.addSubview(inputPasswordField)

        scrollViewConstraint = scrollView.bottomAnchor.constraint(equalTo: bottomAnchor)

        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
            scrollViewConstraint,
            scrollView.trailingAnchor.constraint(equalTo: trailingAnchor),

            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),

            backgroundView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: .size),
            backgroundView.heightAnchor.constraint(equalToConstant: .size),
            backgroundView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: .safeArea),
            backgroundView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -.safeArea),

            inputPasswordField.topAnchor.constraint(equalTo: backgroundView.topAnchor),
            inputPasswordField.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor),
            inputPasswordField.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor),
            inputPasswordField.bottomAnchor.constraint(equalTo: backgroundView.bottomAnchor),

            loginButton.topAnchor.constraint(equalTo: backgroundView.bottomAnchor, constant: .safeArea),
            loginButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: .safeArea),
            loginButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -.safeArea),
            loginButton.heightAnchor.constraint(equalToConstant: 50),
            loginButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        ])
    }

    @objc
    private func tapWrapper() {
        self.onTapButtonHandler?()
    }

    private func isInputsFilled() -> Bool {
        guard let password = inputPasswordField.text
        else {
            return false
        }
        return !password.isEmpty
    }
}

extension LoginView {

    public func cleanInputs() {
        inputPasswordField.text = nil
        loginButton.isEnabled = false
    }

    public func disableButtons() {
        loginButton.isEnabled = false
    }

    public func getPassword() -> String {
        return inputPasswordField.text!
    }
}

extension LoginView: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        endEditing(true)
        return true
    }

    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        if isInputsFilled() {
            loginButton.isEnabled = true
        } else {
            loginButton.isEnabled = false
        }
    }
}

private extension CGFloat {
    static let size: CGFloat = 50
    static let safeArea: CGFloat = 16
    static let vertical: CGFloat = 120
}
