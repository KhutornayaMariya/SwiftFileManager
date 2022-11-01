//
//  LoginBuilder.swift
//  SwiftFileManager
//
//  Created by m.khutornaya on 01.11.2022.
//

import Foundation
import UIKit

final class LoginBuilder: LoginBuilderProtocol {

    func build(input: LoginInput) -> UIViewController {
        let viewController = LoginViewController()
        let router = LoginRouter()
        router.viewController = viewController
        let interactor = LoginInteractor(input: input, router: router)

        viewController.interactor = interactor

        return viewController
    }
}
