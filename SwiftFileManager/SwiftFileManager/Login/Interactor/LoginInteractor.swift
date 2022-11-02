//
//  LoginInteractor.swift
//  SwiftFileManager
//
//  Created by m.khutornaya on 01.11.2022.
//

import Foundation

final class LoginInteractor {

    private let router: LoginRouterProtocol
    private let presenter: LoginPresenterProtocol
    private let keychainManager: KeychainManagerProtocol = KeychainManager()

    init(
        router: LoginRouter,
        presenter: LoginPresenter
    ) {
        self.router = router
        self.presenter = presenter
    }

    private func passwordExists() -> Bool {
        keychainManager.passwordExists()
    }
}

extension LoginInteractor: LoginInteractorProtocol {

    func createPassword(_ password: String, completion: @escaping (Error?) -> Void) {
        keychainManager.savePassword(password) { [weak self] result, error in
            guard error == nil, result else {
                completion(error)
                return
            }

            self?.presenter.updateView(hasPassword: self?.passwordExists() ?? false, needRepeat: true)
        }
    }

    func checkPassword(_ password: String, completion: () -> Void) {
        guard keychainManager.isPasswordValid(password) else {
            completion()
            return
        }
        router.openTabBar()
    }

    func viewDidLoad() {
        presenter.updateView(hasPassword: passwordExists(), needRepeat: false)
    }
}
