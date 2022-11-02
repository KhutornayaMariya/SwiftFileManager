//
//  KeychainManager.swift
//  SwiftFileManager
//
//  Created by m.khutornaya on 02.11.2022.
//

import Foundation
import KeychainAccess

final class KeychainManager {

    private let keychain = Keychain()
    private let key = UUID().uuidString

    private func getPassword() -> String? {
        guard let password = keychain[key] else {
            return nil
        }
        return password
    }
}

extension KeychainManager: KeychainManagerProtocol {

    func passwordExists() -> Bool {
        print(key)
        guard getPassword() != nil else {
            return false
        }
        return true
    }

    func isPasswordValid(_ password: String) -> Bool {
        print(key)
        let keychainPassword = getPassword()
        guard let keychainPassword = keychainPassword else {
            return false
        }
        return keychainPassword == password
    }

    func savePassword(_ password: String, completion: @escaping (Bool, Error?) -> Void) {
        print(key)
        do {
            try keychain.set(password, key: key)
            completion(true, nil)
        } catch let error {
            print(error)
            completion(false, error)
        }
    }

    func removePassword(completion: @escaping (Bool, Error?) -> Void) {
        print(key)
        do {
            try keychain.remove(key)
            completion(true, nil)
        } catch let error {
            print(error)
            completion(false, error)
        }
    }
}
