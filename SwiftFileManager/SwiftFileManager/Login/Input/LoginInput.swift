//
//  LoginInput.swift
//  SwiftFileManager
//
//  Created by m.khutornaya on 02.11.2022.
//

import Foundation

struct LoginInput {
    let entryPoint: EntryPoint

    enum EntryPoint {
        case startApp
        case settings
    }
}
