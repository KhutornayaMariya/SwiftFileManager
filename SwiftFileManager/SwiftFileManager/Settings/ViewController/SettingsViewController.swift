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
}
