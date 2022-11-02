//
//  LoginInteractorProtocol.swift
//  SwiftFileManager
//
//  Created by m.khutornaya on 01.11.2022.
//

import Foundation

protocol LoginInteractorProtocol {
    func viewDidLoad()
    func didTapSingUpButton(_ password: String, completion: @escaping (Error?) -> Void)
    func didTapSingInButton(_ password: String, completion: () -> Void)
}
