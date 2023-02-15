//
//  NewMessageViewController.swift
//  Message App
//
//  Created by NeferUser on 2023/2/14.
//

import UIKit

class NewMessageViewController: UIViewController {
    
    private lazy var tableView: UITableView = {
        let table = UITableView()
        table.register(UserConversationCell.self, forCellReuseIdentifier: UserConversationCell.identifier)
        table.dataSource = self
        table.delegate = self
        return table
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationStyle()
        setupUI()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setConstraints()
    }
    
    // MARK: - Setup UI
    
    private func navigationStyle() {
        navigationController?.setupNavStyle(vc: self, title: "New Message", preferLargeTitle: false, background: .systemPurple)
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(handleDismiss))
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        view.addSubview(tableView)
    }
    
    // MARK: - Autolayout
    
    private func setConstraints() {
        tableView.frame = view.bounds
    }
    
    // MARK: - Selectors
    
    @objc func handleDismiss() {
        dismiss(animated: true)
    }
}

/// UITableView
extension NewMessageViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 30
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: UserConversationCell.identifier, for: indexPath)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
}
