//
//  ConversationController.swift
//  Message App
//
//  Created by Wei Chu on 2023/1/15.
//

import UIKit

class ConversationController: UIViewController {
    
    // MARK: - UIElement
    
    private lazy var tableView: UITableView = {
        let table = UITableView()
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        table.dataSource = self
        table.delegate = self
        return table
    }()
    
    private lazy var plusBtn: UIButton = {
        let btn = UIButton(type: .system)
        btn.setImage(UIImage(systemName: "plus"), for: .normal)
        btn.backgroundColor = .systemPurple
        btn.tintColor = .white
        btn.layer.cornerRadius = 56 / 2
        btn.addTarget(self, action: #selector(showNewMessage), for: .touchUpInside)
        return btn
    }()
    
    // MARK: - Lifecycle

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
        navigationController?.setupNavStyle(vc: self, title: "Messages", preferLargeTitle: true, background: .systemPurple)
        /// Navgation Left BarButtonItem
        let image = UIImage(systemName: "person.circle.fill")
        navigationItem.leftBarButtonItems = [UIBarButtonItem(image: image, style: .plain, target: self, action: #selector(showProfile))]
        
        /// Navigation Right BarButtonItem
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Sign Out", style: .plain, target: self, action: #selector(handleSignOut))
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        view.addSubview(tableView)
        view.addSubview(plusBtn)
    }
        
    // MARK: - Autolayout
    
    private func setConstraints() {
        tableView.frame = view.bounds

        plusBtn.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-16)
            make.right.equalTo(view.safeAreaLayoutGuide.snp.right).offset(-24)
            make.size.equalTo(56)
        }
    }

    // MARK: - Selectors
    
    @objc func showProfile() {
        let loginNavVC = UINavigationController(rootViewController: LoginViewController())
        loginNavVC.modalPresentationStyle = .fullScreen
        loginNavVC.navigationBar.tintColor = .white
        present(loginNavVC, animated: true)
    }
    
    @objc func showNewMessage() {
        let navVC = UINavigationController(rootViewController: NewMessageViewController())
        navVC.modalPresentationStyle = .fullScreen
        present(navVC, animated: true)
    }
    
    @objc func handleSignOut() {
        AuthService.shared.signOut { [weak self] success in
            guard let self = self else{ return }
            
            if success{
                DispatchQueue.main.async {
                    let vc = LoginViewController()
                    let navVC = UINavigationController(rootViewController: vc)
                    navVC.modalPresentationStyle = .fullScreen
                    self.present(navVC, animated: true)
                }
            }
        }
    }
}

/// UITableView
extension ConversationController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 30
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = "Hello World"
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
}
