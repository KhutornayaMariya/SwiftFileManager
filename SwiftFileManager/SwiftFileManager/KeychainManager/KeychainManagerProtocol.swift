//
//  KeychainManagerProtocol.swift
//  SwiftFileManager
//
//  Created by m.khutornaya on 02.11.2022.
//

import Foundation

protocol KeychainManagerProtocol {
    func isPasswordValid(_ password: String) -> Bool
    func passwordExists() -> Bool
    func savePassword(_ password: String, completion: @escaping (Bool, Error?) -> Void)
    func removePassword(completion: @escaping (Bool, Error?) -> Void)
}
