//
//  UserConversationCell.swift
//  Message App
//
//  Created by NeferUser on 2023/2/14.
//

import UIKit
import SnapKit
import SDWebImage

class UserConversationCell: UITableViewCell {
    
    static let identifier = "UserConversationCell"
    
    // MARK: - Public
    
    public func configure(model: User) {
        guard let profileImageUrl = URL(string: model.profileImageUrl) else { return }
        
        usernameLabel.text = model.username
        fullnameLabel.text = model.fullname
        profileImageView.sd_setImage(with: profileImageUrl)
    }
    
    // MARK: - UIElement
    
    private lazy var profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .systemPurple
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 56 / 2
        return imageView
    }()
    
    private lazy var stackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [usernameLabel, fullnameLabel])
        stack.axis = .vertical
        stack.distribution = .fillEqually
        return stack
    }()
    
    private let usernameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 14)
        return label
    }()
    
    private let fullnameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.textColor = .lightGray
        return label
    }()

    // MARK: - Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setConstraints()
    }
    
    // MARK: - Setup UI
    
    private func setupUI() {
        self.backgroundColor = .white
        contentView.addSubview(profileImageView)
        contentView.addSubview(stackView)
    }
    
    // MARK: - Autolayout
    
    private func setConstraints() {
        profileImageView.snp.makeConstraints { make in
            make.centerY.equalTo(contentView.snp.centerY)
            make.left.equalTo(contentView.snp.left).offset(12)
            make.size.equalTo(56)
        }
        
        stackView.snp.makeConstraints { make in
            make.centerY.equalTo(profileImageView.snp.centerY)
            make.left.equalTo(profileImageView.snp.right).offset(12)
            make.right.equalTo(contentView.snp.right).offset(-12)
            make.height.equalTo(profileImageView.snp.height)
        }
    }
}
