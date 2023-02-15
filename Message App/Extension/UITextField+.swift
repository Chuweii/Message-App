//
//  UITextField+.swift
//  Message App
//
//  Created by Wei Chu on 2023/2/9.
//

import UIKit

/// Text Field 下底線樣式
extension UITextField {
    
    func setBottomBorder(backgroundColor: CGColor, lineColor: CGColor) {
        self.borderStyle = .none
        self.layer.backgroundColor = backgroundColor
        self.layer.masksToBounds = false
        self.layer.shadowColor = lineColor
        self.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        self.layer.shadowOpacity = 1.0
        self.layer.shadowRadius = 0.0
    }
}

