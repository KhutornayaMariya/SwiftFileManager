//
//  TabBarViewController.swift
//  SwiftFileManager
//
//  Created by m.khutornaya on 01.11.2022.
//

import Foundation
import UIKit

class TabBarViewController: UITabBarController {

    private let filesViewController = Factory(flow: .files)

    private let settingsViewController = Factory(flow: .settings)

    override func viewDidLoad() {
        super.viewDidLoad()
        tabBar.backgroundColor = .white
        setControllers()
    }

    private func setControllers() {
        viewControllers = [
            filesViewController.navigationController,
            settingsViewController.navigationController
        ]
    }
}
