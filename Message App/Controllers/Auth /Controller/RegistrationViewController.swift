//
//  RegistrationViewController.swift
//  Message App
//
//  Created by Wei Chu on 2023/1/28.
//

import UIKit

class RegistrationViewController: UIViewController {
    
    // MARK: - View Model
    
    var viewModel = RegistractionViewModel()
    
    // MARK: - UIElement
    
    private let photoPlusImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: "person.crop.circle")
        image.tintColor = .white
        return image
    }()
    
    private lazy var stackView: UIStackView = {
        let stack = UIStackView()
        stack.addArrangedSubview(fullNameTextField)
        stack.addArrangedSubview(userNameTextField)
        stack.addArrangedSubview(emailTextField)
        stack.addArrangedSubview(passwordTextField)
        stack.addArrangedSubview(signUpBtn)
        stack.axis = .vertical
        stack.spacing = 16
        return stack
    }()
        
    private lazy var fullNameTextField: LoginTextField = {
        let field = LoginTextField(type: .fullName)
        field.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        return field
    }()

    private lazy var userNameTextField: LoginTextField = {
        let field = LoginTextField(type: .userName)
        field.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        return field
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
    
    private lazy var signUpBtn: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("Sign Up", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        btn.layer.cornerRadius = 5
        btn.setHeight(height: 50)
        btn.isEnabled = false
        btn.backgroundColor = .lightGray.withAlphaComponent(0.6)
        btn.addTarget(self, action: #selector(handleSignUp), for: .touchUpInside)
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
        view.addSubview(photoPlusImage)
        view.addSubview(stackView)
    }

    // MARK: - Autolayout
    
    private func setConstraints() {
        /// photoImage
        photoPlusImage.snp.makeConstraints { make in
            make.centerX.equalTo(view.snp.centerX)
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(32)
            make.size.equalTo(120)
        }
        /// stackView
        stackView.snp.makeConstraints { make in
            make.top.equalTo(photoPlusImage.snp.bottom).offset(32)
            make.left.equalTo(view.snp.left).offset(32)
            make.right.equalTo(view.snp.right).offset(-32)
        }
    }
    
    // MARK: - Selectors
    
    @objc func textDidChange(sender: UITextField) {
        if sender == emailTextField {
            viewModel.email = sender.text
        } else if sender == passwordTextField{
            viewModel.password = sender.text
        } else if sender == fullNameTextField{
            viewModel.fullName = sender.text
        } else if sender == userNameTextField {
            viewModel.userName = sender.text
        }
        
        checkFormStatus()
    }
    
    @objc func handleSignUp() {
        print("wait for check to sign up...")
    }
    
    @objc func didTapToSignUp() {
        print("Signing up ...")
    }
    
    // MARK: - Helper
    
    private func checkFormStatus() {
        if viewModel.formIsValid {
            signUpBtn.isEnabled = true
            signUpBtn.backgroundColor = .systemOrange.withAlphaComponent(0.3)
        } else {
            signUpBtn.isEnabled = false
            signUpBtn.backgroundColor = .lightGray.withAlphaComponent(0.6)
        }
    }
}

