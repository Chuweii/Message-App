//
//  NewMessageViewController.swift
//  Message App
//
//  Created by NeferUser on 2023/2/14.
//

import UIKit

class NewMessageViewController: UIViewController {
        
    private let viewModel = NewMessageViewModel()
    
    // MARK: - UIElement
    
    private lazy var tableView = GenericTableView(items: viewModel.users.value) { (cell: UserConversationCell, item, indexpath) in
        cell.configure(model: item)
        
    } selectHandler: { [weak self] item, indexpath in
        let vc = ChatController()
        vc.titleStr = item.username
        self?.navigationController?.pushViewController(vc, animated: true)
    }

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationStyle()
        fetchUser()
        setupUI()
        setBinding()
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
        tableView.setHeight(80)
    }
    
    // MARK: - Request
    
    private func fetchUser() {
        viewModel.fetchUsers()
    }
    
    // MARK: - Autolayout
    
    private func setConstraints() {
        tableView.frame = view.bounds
    }
    
    // MARK: - Selectors
    
    @objc func handleDismiss() {
        dismiss(animated: true)
    }
    
    // MARK: - Method
    
    private func setBinding() {
        viewModel.users.bind { [weak self] models in
            self?.tableView.setItems(models)
        }
    }
}
