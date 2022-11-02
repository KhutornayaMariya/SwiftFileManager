//
//  LoginViewController.swift
//  SwiftFileManager
//
//  Created by m.khutornaya on 01.11.2022.
//

import Foundation
import UIKit

final class LoginViewController: UIViewController {

    var interactor: LoginInteractor?

    private let nc = NotificationCenter.default

    private lazy var loginView: LoginView = {
        let view = LoginView()

        view.translatesAutoresizingMaskIntoConstraints = false

        return view
    }()

    // MARK: Lifecycle

    init() {
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
        interactor?.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true

        nc.addObserver(self, selector: #selector(keyboardHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        nc.addObserver(self, selector: #selector(keyboardShow), name: UIResponder.keyboardWillShowNotification, object: nil)
    }

    override func viewDidDisappear(_ animated: Bool) {
        nc.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
        nc.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)

        loginView.cleanInputs()
    }

    private func setUp() {
        view.backgroundColor = .white
        view.addSubview(loginView)

        NSLayoutConstraint.activate([
            loginView.topAnchor.constraint(equalTo: view.topAnchor),
            loginView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            loginView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            loginView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
    }

    @objc
    private func keyboardHide() {
        loginView.scrollViewConstraint.constant = 0
        view.setNeedsLayout()
    }

    @objc
    private func keyboardShow(notification: Notification) {
        guard let frame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else { return }
        loginView.scrollViewConstraint.constant = -frame.size.height
        view.setNeedsLayout()
    }

    private func showAlert( alertTitle: String, alertMessage: String) {
        let alertController = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: .alert)
        let action = UIAlertAction(title: String.alertAction, style: .default, handler: nil)
        alertController.addAction(action)

        present(alertController, animated: true)
    }

    private func buttonAction(state: LoginViewModel.LoginState) -> () -> Void {
        switch state {
        case .withPassword, .needRepeatPassword:
            return checkPassword
        case .withNoPassword:
            return createPassword
        }
    }

    private func createPassword() {
        let filledPassword = loginView.getPassword()
        guard filledPassword.count > 3 else {
            showAlert(alertTitle: .alertTitle, alertMessage: .shortPassword)
            return
        }
        interactor?.createPassword(filledPassword, completion: { [weak self] error in
            self?.showAlert(alertTitle: .alertTitle, alertMessage: error?.localizedDescription ?? .errorMessage)
        })
    }

    private func checkPassword() {
        let filledPassword = loginView.getPassword()
        interactor?.checkPassword(filledPassword, completion: {
            self.showAlert(alertTitle: .alertTitle, alertMessage: .wrongCredsError)
        })
    }
}

extension LoginViewController: LoginViewControllerProtocol {
    func updateButton(with model: LoginViewModel) {
        loginView.setUpButton(with: model.state.rawValue)
        loginView.onTapButtonHandler = buttonAction(state: model.state)
        loginView.cleanInputs()
    }
}

private extension String {
    static let wrongCredsError = "Убедитесь в правильности введенного пароля"
    static let shortPassword = "Пароль должен содержать не менее четырех символов"
    static let alertTitle = "Ошибка пароля"
    static let errorMessage = "Произошла ошибка. Повторите позже"
    static let alertAction = "Повторить"
}
