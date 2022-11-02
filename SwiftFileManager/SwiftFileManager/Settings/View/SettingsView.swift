//
//  SettingsView.swift
//  SwiftFileManager
//
//  Created by m.khutornaya on 01.11.2022.
//

import Foundation
import UIKit

final class SettingsView: UIView {

    private lazy var label: UILabel = {
        let view = UILabel()

        view.text = .sorting
        view.translatesAutoresizingMaskIntoConstraints = false

        return view
    }()

    private lazy var changePasswordButton: UIButton = {
        let view = UIButton()

        view.layer.cornerRadius = 10
        view.layer.masksToBounds = true
        view.backgroundColor = .systemBlue
        view.setTitle(.changePassword, for: .normal)
        view.translatesAutoresizingMaskIntoConstraints = false

        return view
    }()

    private lazy var sortingSwitcher: UISwitch = {
        let view = UISwitch()

        view.translatesAutoresizingMaskIntoConstraints = false

        return view
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setUp()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setUp() {
        backgroundColor = .white
        [label, changePasswordButton, sortingSwitcher].forEach { addSubview($0)}

        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: topAnchor, constant: .safeArea),
            label.leadingAnchor.constraint(equalTo: leadingAnchor, constant: .safeArea),

            sortingSwitcher.topAnchor.constraint(equalTo: topAnchor, constant: .safeArea),
            sortingSwitcher.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -.safeArea),

            changePasswordButton.topAnchor.constraint(equalTo: sortingSwitcher.bottomAnchor, constant: .safeArea),
            changePasswordButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: .safeArea),
            changePasswordButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -.safeArea),
            changePasswordButton.heightAnchor.constraint(equalToConstant: .size)
        ])
    }

    public var onTapButtonHandler: (() -> Void)? {
        didSet {
            changePasswordButton.addTarget(self, action: #selector(tapWrapper), for: .touchUpInside)
        }
    }

    public var onSwitchHandler: (() -> Void)? {
        didSet {
            sortingSwitcher.addTarget(self, action: #selector(switchWrapper), for: .valueChanged)
        }
    }

    @objc
    private func tapWrapper() {
        self.onTapButtonHandler?()
    }

    @objc
    private func switchWrapper() {
        self.onSwitchHandler?()
    }
}

extension SettingsView {

    func setSwitcher(isOn: Bool) {
        sortingSwitcher.isOn = isOn
    }

    func isSwitcherOn() -> Bool {
        sortingSwitcher.isOn
    }
}

private extension CGFloat {
    static let size: CGFloat = 50
    static let safeArea: CGFloat = 16
}

private extension String {
    static let sorting = "Сортировка по алфавиту"
    static let changePassword = "Поменять пароль"
}
