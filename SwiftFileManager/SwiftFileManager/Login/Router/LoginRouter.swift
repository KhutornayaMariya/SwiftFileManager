//
//  LoginRouter.swift
//  SwiftFileManager
//
//  Created by m.khutornaya on 01.11.2022.
//

import Foundation
import UIKit

final class LoginRouter {
    weak var viewController: UIViewController?

    init() {}

    private func present(
        _ presentedViewController: UIViewController,
        modalPresentationStyle: UIModalPresentationStyle,
        animated: Bool = true
    ) {
        presentedViewController.modalPresentationStyle = modalPresentationStyle
        viewController?.present(presentedViewController, animated: animated)
    }
}

extension LoginRouter: LoginRouterProtocol {
    func openTabBar() {
        let navigationController = UINavigationController(rootViewController: TabBarViewController())
        navigationController.isNavigationBarHidden = true
        present(navigationController, modalPresentationStyle: .overCurrentContext, animated: true)
    }

    func dismiss() {
        viewController?.dismiss(animated: true)
    }
}
