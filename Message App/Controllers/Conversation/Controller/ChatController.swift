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
    
    private lazy var customInputView: CutomInputView = {
        let inputView = CutomInputView()
        
        return inputView
    }()
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: 50, height: 50)
        layout.minimumInteritemSpacing = 1
        layout.minimumLineSpacing = 2
        
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.dataSource = self
        collection.delegate = self
        collection.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
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

extension ChatController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 15
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        cell.backgroundColor = .red
        return cell
    }
}

