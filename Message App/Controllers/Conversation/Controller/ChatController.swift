//
//  ChatController.swift
//  Message App
//
//  Created by NeferUser on 2023/2/21.
//

import UIKit
import SnapKit

class ChatController: UIViewController {
    
    // MARK: - Properties & UIElement
    
    var titleStr = ""
    private var messages = [Message]()
    
    private lazy var customInputView: CutomInputView = {
        let inputView = CutomInputView()
        inputView.delegate = self
        return inputView
    }()
    
    private lazy var collectionView: UICollectionView = {
        /// UICollectionView FlowLayout
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: view.frame.width, height: 50)
        layout.sectionInset = .init(top: 16, left: 0, bottom: 16, right: 0)
        
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.dataSource = self
        collection.delegate = self
        collection.register(MessageCell.self, forCellWithReuseIdentifier: MessageCell.identifier)
        collection.alwaysBounceVertical = true

        return collection
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override var inputAccessoryView: UIView? {
        get { return customInputView }
    }
    
    override var canBecomeFirstResponder: Bool {
        return true
    }
    
    // MARK: - Setup UI
    
    private func setupUI() {
        title = titleStr
        view.backgroundColor = .white
        view.addSubview(collectionView)
        view.addSubview(customInputView)
        setConstraints()
    }
    
    // MARK: - Autolayout
    
    private func setConstraints() {
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(view.snp.top).offset(topbarHeight + 10)
            make.left.equalTo(view.snp.left).offset(0)
            make.right.equalTo(view.snp.right).offset(0)
            make.bottom.equalTo(view.snp.bottom).offset(0)
        }
        
        customInputView.snp.makeConstraints { make in
            make.left.equalTo(view.snp.left).offset(0)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(0)
            make.height.equalTo(50)
            make.width.equalTo(view.snp.width)
        }
    }
}

/// UICollectionView
extension ChatController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 15
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MessageCell.identifier, for: indexPath)
        return cell
    }
}

/// CustomInputAccessoryDelegate
extension ChatController: CustomInputAccessoryDelegate {
    func inputView(_ inputView: CutomInputView, wantsToSend message: String) {
        print("sended ... message")
    }
}
