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

    init(
        input: LoginInput,
        router: LoginRouter,
        presenter: LoginPresenter
    ) {
        self.router = router
        self.presenter = presenter
    }

    private func passwordExists() -> Bool {
        return false
    }
}

extension LoginInteractor: LoginInteractorProtocol {

    func didTapLoginButton() {
        router.openTabBar()
    }

    func viewDidLoad() {
        presenter.updateView(hasPassword: passwordExists())
    }
}
