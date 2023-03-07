//
//  MessageCell.swift
//  Message App
//
//  Created by NeferUser on 2023/3/3.
//

import UIKit

class MessageCell: UICollectionViewCell {
    
    static let identifier = "MessageCell"
    
    // MARK: - Properties
    
    private let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.backgroundColor = .lightGray
        imageView.layer.cornerRadius = 32/2
        return imageView
    }()
    
    private let textView: UITextView = {
        let tv = UITextView()
        tv.backgroundColor = .clear
        tv.font = .systemFont(ofSize: 16)
        tv.isScrollEnabled = false
        tv.isEditable = false
        tv.textColor = .white
        tv.text = "Some test message for now .."
        return tv
    }()
    
    private let bubbleContainer: UIView = {
        let view = UIView()
        view.backgroundColor = .systemPurple
        view.layer.cornerRadius = 12
        return view
    }()
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup UI
    
    private func setupUI() {
        contentView.addSubview(profileImageView)
        contentView.addSubview(bubbleContainer)
        bubbleContainer.addSubview(textView)
        setConstraints()
    }
    
    // MARK: - Autolayout
    
    private func setConstraints() {
        profileImageView.snp.makeConstraints { make in
            make.left.equalTo(contentView.snp.left).offset(8)
            make.bottom.equalTo(contentView.snp.bottom).offset(8)
            make.size.equalTo(32)
        }
        
        bubbleContainer.snp.makeConstraints { make in
            make.top.equalTo(contentView.snp.top).offset(0)
            make.left.equalTo(profileImageView.snp.right).offset(5)
            make.width.equalTo(contentView.snp.width).multipliedBy(0.8)
        }
        
        textView.snp.makeConstraints { make in
            make.top.equalTo(bubbleContainer.snp.top).offset(4)
            make.left.equalTo(bubbleContainer.snp.left).offset(12)
            make.right.equalTo(bubbleContainer.snp.right).offset(4)
            make.bottom.equalTo(bubbleContainer.snp.bottom).offset(-12)
        }
    }
}
