//
//  CutomInputView.swift
//  Message App
//
//  Created by NeferUser on 2023/2/23.
//

import UIKit
import SnapKit

class CutomInputView: UIView {
    
    // MARK: - UIElement
    
    private lazy var messageInputView: UITextView = {
        let textView = UITextView()
        textView.font = UIFont.systemFont(ofSize: 16)
        textView.isScrollEnabled = false
        return textView
    }()
    
    private lazy var sendMessageBtn: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("Send", for: .normal)
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        btn.setTitleColor(.systemPurple, for: .normal)
        btn.addTarget(self, action: #selector(handleSendMessage), for: .touchUpInside)
        return btn
    }()
    
    private let placeholderLabel: UILabel = {
        let label = UILabel()
        label.text = "Enter message"
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .lightGray
        return label
    }()

    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setConstraints()
    }
    
    override var intrinsicContentSize: CGSize {
        return .zero
    }
    
    // MARK: - Setup UI
    
    private func setupUI() {
        autoresizingMask = .flexibleHeight
        setNotificationCenter()
        self.addSubview(sendMessageBtn)
        self.addSubview(messageInputView)
        self.addSubview(placeholderLabel)
        
        /// Add view layer 
        layer.shadowOpacity = 0.25
        layer.shadowRadius = 10
        layer.shadowOffset = .init(width: 0, height: -8)
        layer.shadowColor = UIColor.lightGray.cgColor
    }

    private func setNotificationCenter() {
        NotificationCenter.default.addObserver(self, selector: #selector(handleTextInputChange), name: UITextView.textDidChangeNotification, object: nil)
    }
    
    // MARK: - Autolayout
    
    private func setConstraints() {
        sendMessageBtn.snp.makeConstraints { make in
            make.size.equalTo(50)
            make.top.equalTo(self.snp.top).offset(4)
            make.right.equalTo(self.snp.right).offset(-8)
        }
        
        messageInputView.snp.makeConstraints { make in
            make.top.equalTo(self.snp.top).offset(12)
            make.left.equalTo(self.snp.left).offset(8)
            make.right.equalTo(sendMessageBtn.snp.left).offset(-8)
            make.bottom.equalTo(self.snp.bottom).offset(-8)
        }
        
        placeholderLabel.snp.makeConstraints { make in
            make.left.equalTo(messageInputView.snp.left).offset(5)
            make.centerY.equalTo(messageInputView.snp.centerY)
        }
    }
    
    // MARK: - Selector
    
    @objc func handleSendMessage() {
        print("handle send message")
    }
    
    @objc func handleTextInputChange() {
        placeholderLabel.isHidden = !self.messageInputView.text.isEmpty
    }
}
