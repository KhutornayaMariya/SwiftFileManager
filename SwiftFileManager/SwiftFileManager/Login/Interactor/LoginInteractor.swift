//
//  LoginInteractor.swift
//  SwiftFileManager
//
//  Created by m.khutornaya on 01.11.2022.
//

import Foundation

final class LoginInteractor {

    private let input: LoginInput
    private let router: LoginRouterProtocol
    private let presenter: LoginPresenterProtocol
    private let keychainManager: KeychainManagerProtocol = KeychainManager()

    init(
        input: LoginInput,
        router: LoginRouter,
        presenter: LoginPresenter
    ) {
        self.input = input
        self.router = router
        self.presenter = presenter
    }

    private func passwordExists() -> Bool {
        if input.entryPoint == .settings {
            return false
        }
        return keychainManager.passwordExists()
    }
}

extension LoginInteractor: LoginInteractorProtocol {

    func didTapSingUpButton(_ password: String, completion: @escaping (Error?) -> Void) {
        keychainManager.savePassword(password) { [weak self] result, error in
            guard error == nil, result else {
                completion(error)
                return
            }

            self?.presenter.updateView(hasPassword: self?.passwordExists() ?? false, needRepeat: true)
        }
    }

    func didTapSingInButton(_ password: String, completion: () -> Void) {
        guard keychainManager.isPasswordValid(password) else {
            completion()
            return
        }
        if input.entryPoint == .startApp {
            router.openTabBar()
        } else {
            router.dismiss()
        }
    }

    func viewDidLoad() {
        presenter.updateView(hasPassword: passwordExists(), needRepeat: false)
    }
}
