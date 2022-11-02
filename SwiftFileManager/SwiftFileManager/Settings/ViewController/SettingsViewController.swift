//
//  SettingsViewController.swift
//  SwiftFileManager
//
//  Created by m.khutornaya on 01.11.2022.
//

import Foundation
import UIKit

final class SettingsViewController: UIViewController {

    private lazy var settingsView: SettingsView = {
        let view = SettingsView()

        view.translatesAutoresizingMaskIntoConstraints = false
        view.onTapButtonHandler = changePassword
        view.onSwitchHandler = setSorting
        view.setSwitcher(isOn: UserDefaults.standard.bool(forKey: "sort"))

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
    }

    private func setUp() {
        view.backgroundColor = .white
        view.addSubview(settingsView)

        NSLayoutConstraint.activate([
            settingsView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            settingsView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            settingsView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            settingsView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
    }

    private func changePassword() {
        let viewController = LoginBuilder().build(input: LoginInput(entryPoint: .settings))
        let navigationController = UINavigationController(rootViewController: viewController)
        navigationController.isNavigationBarHidden = true
        present(navigationController, animated: true)
    }

    private func setSorting() {
        let sort = settingsView.isSwitcherOn()

        if UserDefaults.standard.bool(forKey: "sort") == sort {
            return
        } else {
            UserDefaults.standard.set(sort, forKey: "sort")
            NotificationCenter.default.post(name: NSNotification.Name.reloadTableView, object: nil)
        }
    }
}
