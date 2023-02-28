//
//  UnderLineTextField.swift
//  Message App
//
//  Created by Wei Chu on 2023/2/9.
//

import UIKit

/// Text Field With BottomLine & Padding
class UnderlinedTextField: UITextField {

    // MARK: - Properties
    
    let underlineLayer = CALayer()
    var textPadding = UIEdgeInsets(
        top: 7,
        left: 7,
        bottom: 7,
        right: 7
    )

    // MARK: - Init

    /// in `init(frame:)` Add our underlineLayer as a sublayer of the view's main layer
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.layer.addSublayer(underlineLayer)
    }
    
    /// In `init?(coder:)` Add our underlineLayer as a sublayer of the view's main layer
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.layer.addSublayer(underlineLayer)
    }
    
    // MARK: - Method
    
    /// Size the underline layer and position it as a one point line under the text field.
    func setupUnderlineLayer() {
        var frame = self.bounds
        frame.origin.y = frame.size.height - 1
        frame.size.height = 1

        underlineLayer.frame = frame
        underlineLayer.backgroundColor = UIColor.white.cgColor
    }
    
    // MARK: - Override

    /// Any time we are asked to update our subviews,
    /// adjust the size and placement of the underline layer too.
    override func layoutSubviews() {
        super.layoutSubviews()
        setupUnderlineLayer()
    }
    
    /// Override to add Text Field padding.
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        let rect = super.textRect(forBounds: bounds)
        return rect.inset(by: textPadding)
    }

    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        let rect = super.editingRect(forBounds: bounds)
        return rect.inset(by: textPadding)
    }
}

