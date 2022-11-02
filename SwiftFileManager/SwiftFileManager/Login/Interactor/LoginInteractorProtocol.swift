//
//  LoginInteractorProtocol.swift
//  SwiftFileManager
//
//  Created by m.khutornaya on 01.11.2022.
//

import Foundation

protocol LoginInteractorProtocol {
    func viewDidLoad()
    func createPassword(_ password: String, completion: @escaping (Error?) -> Void)
    func checkPassword(_ password: String, completion: () -> Void)
}
