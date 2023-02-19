//
//  LoginViewController.swift
//  Message App
//
//  Created by Wei Chu on 2023/1/28.
//

import UIKit
import SnapKit

class LoginViewController: UIViewController {
    
    //MARK: - View Model
    
    var viewModel = LoginViewViewModel()
    
    // MARK: - UIElement
    
    private let iconImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: "bubble.right")
        image.tintColor = .white
        return image
    }()
    
    private lazy var stackView: UIStackView = {
        let stack = UIStackView()
        stack.addArrangedSubview(emailTextField)
        stack.addArrangedSubview(passwordTextField)
        stack.addArrangedSubview(loginBtn)
        stack.axis = .vertical
        stack.spacing = 16
        return stack
    }()
    
    private lazy var emailTextField: LoginTextField = {
        let field = LoginTextField(type: .email)
        field.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        return field
    }()
    
    private lazy var passwordTextField: LoginTextField = {
        let field = LoginTextField(type: .password)
        field.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        return field
    }()
    
    private lazy var loginBtn: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("Log In", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        btn.layer.cornerRadius = 5
        btn.setHeight(height: 50)
        btn.isEnabled = false
        btn.backgroundColor = .lightGray.withAlphaComponent(0.6)
        btn.addTarget(self, action: #selector(handleLogin), for: .touchUpInside)
        return btn
    }()
    
    private lazy var shouldSignupBtn: UIButton = {
        let btn = UIButton(type: .system)
        let attributedTitle = NSMutableAttributedString(string: "Didn't have account?  ", attributes: [.font: UIFont.systemFont(ofSize: 16), .foregroundColor: UIColor.white])
        attributedTitle.append(NSMutableAttributedString(string: "Sign Up", attributes: [.font: UIFont.boldSystemFont(ofSize: 18), .foregroundColor: UIColor.white]))
        btn.setAttributedTitle(attributedTitle, for: .normal)
        btn.addTarget(self, action: #selector(goToSignUp), for: .touchUpInside)
        return btn
    }()

    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setConstraints()
    }
    
    // MARK: - Setup UI
    
    private func setupUI() {
        self.setBackgroundGradient()
        view.addSubview(iconImage)
        view.addSubview(stackView)
        view.addSubview(shouldSignupBtn)
    }

    // MARK: - Autolayout
    
    private func setConstraints() {
        /// iconImage
        iconImage.snp.makeConstraints { make in
            make.centerX.equalTo(view.snp.centerX)
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(32)
            make.size.equalTo(120)
        }
        /// stackView
        stackView.snp.makeConstraints { make in
            make.top.equalTo(iconImage.snp.bottom).offset(32)
            make.left.equalTo(view.snp.left).offset(32)
            make.right.equalTo(view.snp.right).offset(-32)
        }
        /// shouldSignupBtn
        shouldSignupBtn.snp.makeConstraints { make in
            make.centerX.equalTo(view.snp.centerX)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-20)
            make.width.equalTo(view.snp.width).multipliedBy(0.8)
            make.height.equalTo(50)
        }
    }
    
    // MARK: - Selectors
    
    @objc func textDidChange(sender: UITextField) {
        if sender == emailTextField {
            viewModel.email = sender.text
        } else {
            viewModel.password = sender.text
        }
        
        checkFormStatus()
    }
    
    @objc func handleLogin() {
        viewModel.checkUserLogin(vc: self)
    }
    
    @objc func goToSignUp() {
        let registerVC = RegistrationViewController()
        navigationController?.pushViewController(registerVC, animated: true)
    }
    
    // MARK: - Helper
    
    private func checkFormStatus() {
        if viewModel.formIsValid {
            loginBtn.isEnabled = true
            loginBtn.backgroundColor = .systemOrange.withAlphaComponent(0.3)
        } else {
            loginBtn.isEnabled = false
            loginBtn.backgroundColor = .lightGray.withAlphaComponent(0.6)
        }
    }
}
