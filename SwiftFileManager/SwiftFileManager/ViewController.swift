//
//  ViewController.swift
//  SwiftFileManager
//
//  Created by m.khutornaya on 31.10.2022.
//

import UIKit

final class ViewController: UIViewController {

    private lazy var tableView: UITableView = {
        let tableView = UITableView()

        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 45
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
        view.backgroundColor = .white

        view.addSubview(self.tableView)

        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        residentNames.count
        return 10
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DefaultCell", for: indexPath)
//        cell.textLabel?.text = self.residentNames[indexPath.row]
        return cell
    }
}
