//
//  LoginPresenter.swift
//  SwiftFileManager
//
//  Created by m.khutornaya on 01.11.2022.
//

import Foundation

final class LoginPresenter {

    typealias ViewModel = LoginViewModel

    weak var viewController: LoginViewControllerProtocol?

    init(viewController: LoginViewControllerProtocol) {
        self.viewController = viewController
    }
}

extension LoginPresenter: LoginPresenterProtocol {
    func updateView(hasPassword: Bool, needRepeat: Bool) {
        guard !needRepeat else {
            viewController?.updateButton(with: ViewModel(state: .needRepeatPassword))
            return
        }
        let state: LoginViewModel.LoginState = hasPassword ? .withPassword : .withNoPassword
        let viewModel = ViewModel(state: state)

        viewController?.updateButton(with: viewModel)
    }
}
