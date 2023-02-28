//
//  ChatController.swift
//  Message App
//
//  Created by NeferUser on 2023/2/21.
//

import UIKit
import SnapKit

class ChatController: UIViewController {
    
    // MARK: - Properties
    
    var titleStr = ""
    private lazy var customInputView: CutomInputView = {
        let inputView = CutomInputView()
        return inputView
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = titleStr
        view.backgroundColor = .white
        view.addSubview(customInputView)
        setConstraints()
    }
    
    override var inputAccessoryView: UIView? {
        get { return customInputView }
    }
    
    override var canBecomeFirstResponder: Bool {
        return true
    }
    
    // MARK: - Autolayout
    
    private func setConstraints() {
        customInputView.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.width.equalTo(view.snp.width)
            
        }
    }
    
}
