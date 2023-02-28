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
        self.addSubview(sendMessageBtn)
        self.addSubview(messageInputView)
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
    }
    
    // MARK: - Selector
    
    @objc func handleSendMessage() {
        print("handle send message")
    }
}
