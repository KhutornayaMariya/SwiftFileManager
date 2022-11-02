//
//  LoginViewModel.swift
//  SwiftFileManager
//
//  Created by m.khutornaya on 01.11.2022.
//

import Foundation

struct LoginViewModel {
    let state: LoginState

    enum LoginState: String {
        case withPassword = "Введите пароль"
        case withNoPassword = "Создать пароль"
        case needRepeatPassword = "Повторите пароль"
    }
}
