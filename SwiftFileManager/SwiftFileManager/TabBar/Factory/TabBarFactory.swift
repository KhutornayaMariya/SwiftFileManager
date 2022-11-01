//
//  TabBarFactory.swift
//  SwiftFileManager
//
//  Created by m.khutornaya on 01.11.2022.
//

import Foundation
import UIKit

final class Factory {

    enum Flow {
        case files
        case settings
    }

    let navigationController: UINavigationController = UINavigationController()
    let flow: Flow

    init(
        flow: Flow
    ) {
        self.flow = flow
        startModule()
    }

    func startModule() {
        switch flow {
        case .files:
            let controller = FilesViewController()

            navigationController.tabBarItem = UITabBarItem(title: "Files", image: UIImage(systemName: "doc"), selectedImage: nil)
            navigationController.setViewControllers([controller], animated: true)
        case .settings:
            let controller = UIViewController()
            controller.view.backgroundColor = .brown

            navigationController.tabBarItem = UITabBarItem(title: "Settings", image: UIImage(systemName: "gearshape.fill"), selectedImage: nil)
            navigationController.setViewControllers([controller], animated: true)
        }
    }
}
