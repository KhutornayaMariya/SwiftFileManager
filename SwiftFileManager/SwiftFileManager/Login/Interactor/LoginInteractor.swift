//
//  LoginInteractor.swift
//  SwiftFileManager
//
//  Created by m.khutornaya on 01.11.2022.
//

import Foundation

final class LoginInteractor: LoginInteractorProtocol {

    private let router: LoginRouter

    init(
        input: LoginInput,
        router: LoginRouter
    ) {
        self.router = router
    }

    func didTapLoginButton() {
        router.openFilesScreen()
    }
}
