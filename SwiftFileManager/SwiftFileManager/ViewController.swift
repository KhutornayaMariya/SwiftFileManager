//
//  ViewController.swift
//  SwiftFileManager
//
//  Created by m.khutornaya on 31.10.2022.
//

import UIKit

final class ViewController: UIViewController {

    let url: URL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]

    var files: [URL] {
        return (try? FileManager.default.contentsOfDirectory(at: url, includingPropertiesForKeys: nil)) ?? []
    }

    private lazy var tableView: UITableView = {
        let tableView = UITableView()

        tableView.rowHeight = UITableView.automaticDimension
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "DefaultCell")
        tableView.tableFooterView = UIView(frame: .zero)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.translatesAutoresizingMaskIntoConstraints = false

        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUp()
    }

    // MARK: Lifecycle

    init() {
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setUp() {
        setUpNavigationBar()

        view.backgroundColor = .white
        view.addSubview(self.tableView)

        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant:20),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

    private func setUpNavigationBar() {
        let infoButtonItem = UIBarButtonItem(
            title: "Добавить фотографию",
            style: UIBarButtonItem.Style.plain,
            target: self,
            action: #selector(openImagePicker)
        )
        navigationItem.rightBarButtonItem = infoButtonItem
    }

    @objc
    func openImagePicker() {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true)
    }

    private func addFile(name: String, data: Data) {
        let imagePath = self.url.appendingPathComponent(name)
        FileManager.default.createFile(atPath: imagePath.path, contents: data, attributes: nil)
    }

    private func deleteFile(path: String) {
        do {
            try FileManager.default.removeItem(atPath: path)
        } catch {
            print(error)
        }
    }

    private func cellSubtitle(path: String) -> String {
        var isFolder: ObjCBool = false
        _ = FileManager.default.fileExists(atPath: path, isDirectory: &isFolder)

        if isFolder.boolValue {
            return "FOLDER"
        } else {
            return "FILE"
        }
    }

    private func showAlert(image: UIImage) {
        let alertController = UIAlertController(title: "Загрузить фото", message: nil, preferredStyle: .alert)
        alertController.addTextField { textField in
            textField.placeholder = "Введите название"
        }

        let saveImageAction = UIAlertAction(title: "Сохранить", style: .default) { [weak self] action in
            guard let self = self,
                  let imageName = alertController.textFields?[0].text,
                  !imageName.isEmpty,
                  let data = image.pngData()
            else { return }

            self.addFile(name: imageName, data: data)
            self.tableView.reloadData()
        }

        alertController.addAction(saveImageAction)
        present(alertController, animated: true)
    }
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return files.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "DefaultCell")

        let item = self.files[indexPath.row]
        cell.textLabel?.text = item.lastPathComponent
        cell.detailTextLabel?.text = cellSubtitle(path: item.path)

        return cell
    }

    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let action = UIContextualAction(style: .destructive, title: "Удалить") { [weak self] (_, _, _) in
            guard let self = self else { return }

            self.deleteFile(path: self.files[indexPath.row].path)
            self.tableView.reloadData()
        }
        return .init(actions: [action])
    }
}

extension ViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.originalImage] as? UIImage else { return }
        dismiss(animated: true)

        showAlert(image: image)
    }
}
