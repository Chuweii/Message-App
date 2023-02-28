//
//  SignUpViewController.swift
//  Message App
//
//  Created by Wei Chu on 2023/1/28.
//

import UIKit
import Firebase

class SignUpViewController: UIViewController {
    
    // MARK: - View Model
    
    private var viewModel = SignUpViewModel()
    private var profileImage: UIImage?
    
    // MARK: - UIElement
    
    private lazy var photoPlusBtn: UIButton = {
        let btn = UIButton(type: .system)
        btn.setImage(UIImage(named: "plus_photo"), for: .normal)
        btn.tintColor = .white
        btn.clipsToBounds = true
        btn.addTarget(self, action: #selector(handleSelectPhoto), for: .touchUpInside)
        return btn
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
        configNotification()
        view.addSubview(photoPlusBtn)
        view.addSubview(stackView)
    }
    
    // MARK: - Notification Observer
    
    private func configNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    // MARK: - Autolayout
    
    private func setConstraints() {
        /// photoPlusBtn
        photoPlusBtn.snp.makeConstraints { make in
            make.centerX.equalTo(view.snp.centerX)
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(0)
            make.size.equalTo(140)
        }
        /// stackView
        stackView.snp.makeConstraints { make in
            make.top.equalTo(photoPlusBtn.snp.bottom).offset(32)
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
        guard let profileImage = profileImage else {
            self.normalAlert(title: "Sign up error", message: "Please pick a photo.")
            return
        }
        viewModel.handleSignUp(profileImage: profileImage, vc: self)
    }
    
    @objc func handleSelectPhoto() {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        present(imagePickerController, animated: true)
    }
        
    @objc func keyboardWillShow() {
        if view.frame.origin.y == 0 {
            self.view.frame.origin.y -= 100
        }
    }
    
    @objc func keyboardWillHide(){
        if view.frame.origin.y != 0 {
            view.frame.origin.y = 0
        }
    }

    // MARK: - Check Status
    
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

// MARK: - UINavigationControllerDelegate, UIImagePickerControllerDelegate

extension SignUpViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[.originalImage] as? UIImage
        profileImage = image
        photoPlusBtn.setImage(image?.withRenderingMode(.alwaysOriginal), for: .normal)
        photoPlusBtn.layer.cornerRadius = photoPlusBtn.frame.size.width / 2
        photoPlusBtn.layer.borderColor = UIColor.white.cgColor
        photoPlusBtn.layer.borderWidth = 3
        dismiss(animated: true)
    }
}
