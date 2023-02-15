//
//  LoginTextField.swift
//  Message App
//
//  Created by NeferUser on 2023/2/11.
//

import UIKit

/// For Login page's Text Field
enum LoginTextFieldType {
    case email
    case password
    case userName
    case fullName
}

class LoginTextField: UnderlinedTextField {
    
    // MARK: - Properties
    
    let type: LoginTextFieldType
    
    // MARK: - Init
    
    init(type: LoginTextFieldType) {
        self.type = type
        super.init(frame: .zero)
        setTextFieldType()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Set Type
    
    private func setTextFieldType() {
        switch type {
        case .email:
            self.placeholder = "Email"
            self.leftView = TextFieldWithLeftView(field: self, iconName: "envelope.fill", color: .white)
        case .password:
            self.placeholder = "Password"
            self.isSecureTextEntry = true
            self.leftView = TextFieldWithLeftView(field: self, iconName: "lock.fill", color: .white)
        case .userName:
            self.placeholder = "User Name"
            self.leftView = TextFieldWithLeftView(field: self, iconName: "person.fill", color: .white)
        case .fullName:
            self.placeholder = "Full Name"
            self.leftView = TextFieldWithLeftView(field: self, iconName: "person.fill", color: .white)
        }
        
        self.textColor = .white
        self.setHeight(height: 50)
    }
}

/// TextField's LeftView
class TextFieldWithLeftView: UIView {
    
    // MARK: - Properties & UIElement
    
    let iconName: String
    let iconColor: UIColor
    let textField: UITextField
    let leftImageView = UIImageView()
    
    // MARK: - Init
    
    init(field: UITextField, iconName: String, color: UIColor) {
        self.iconName = iconName
        self.iconColor = color
        self.textField = field
        super.init(frame: .zero)
        
        leftImageView.image = UIImage(systemName: iconName)
        leftImageView.tintColor = iconColor
        self.addSubview(leftImageView)
        self.frame = CGRect(x: 0, y: 0, width: UIImage(systemName: iconName)!.size.width + 10, height: UIImage(systemName: iconName)!.size.height)
        leftImageView.frame = CGRect(x: 10, y: 0, width: UIImage(systemName: iconName)!.size.width, height: UIImage(systemName: iconName)!.size.height)
        
        field.leftView = self
        field.leftViewMode = .always
        field.clearButtonMode = .whileEditing
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
