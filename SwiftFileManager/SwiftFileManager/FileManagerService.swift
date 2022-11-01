//
//  FileManagerService.swift
//  SwiftFileManager
//
//  Created by m.khutornaya on 01.11.2022.
//

import Foundation

protocol FileManagerServiceProtocol {
    func createNewFolder(url: URL)
    func addFile(url: URL, name: String, data: Data)
    func deleteFile(path: String)
}

final class FileManagerService: FileManagerServiceProtocol {
    func createNewFolder(url: URL) {
        do {
            try FileManager.default.createDirectory(at: url, withIntermediateDirectories: false)
        } catch {
            print(error.localizedDescription)
        }
    }

    func addFile(url: URL, name: String, data: Data) {
        let imagePath = url.appendingPathComponent(name)
        FileManager.default.createFile(atPath: imagePath.path, contents: data, attributes: nil)
    }

    func deleteFile(path: String) {
        do {
            try FileManager.default.removeItem(atPath: path)
        } catch {
            print(error)
        }
    }
}
