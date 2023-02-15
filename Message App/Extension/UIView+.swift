//
//  UIView+.swift
//  MVVM CollectionView
//
//  Created by NeferUser on 2022/12/27.
//

import UIKit

// MARK: - Set Autolayout

extension UIView {
    //設定layout 對齊某一邊 leading、trailing、top、bottom
        func anchor(top: NSLayoutYAxisAnchor? = nil,
                left: NSLayoutXAxisAnchor? = nil,
                bottom: NSLayoutYAxisAnchor? = nil,
                right: NSLayoutXAxisAnchor? = nil,
                paddingTop: CGFloat = 0,
                paddingLeft: CGFloat = 0,
                paddingBottom: CGFloat = 0,
                paddingRight: CGFloat = 0,
                width: CGFloat? = nil,
                height: CGFloat? = nil){
        
        //由程式產生的元件，皆需把該元件AutoResize 關閉，否則會造成衝突
        translatesAutoresizingMaskIntoConstraints = false
        
        if let top = top {
            topAnchor.constraint(equalTo: top, constant: paddingTop).isActive = true
        }
        if let left = left {
            leftAnchor.constraint(equalTo: left, constant: paddingLeft).isActive = true
        }
        if let bottom = bottom {
            bottomAnchor.constraint(equalTo: bottom, constant: paddingBottom).isActive = true
        }
        if let right = right {
            rightAnchor.constraint(equalTo: right, constant: paddingRight).isActive = true
        }
        if let width = width {
            widthAnchor.constraint(equalToConstant: width).isActive = true
        }
        
        if let height = height {
            heightAnchor.constraint(equalToConstant: height).isActive = true
        }
    }
    //水平置中
    func centerX(inView view: UIView, topAnchor: NSLayoutYAxisAnchor?, paddingTop: CGFloat? = nil) {
        
        translatesAutoresizingMaskIntoConstraints = false
        centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        if let topAnchor = topAnchor,
           let padding = paddingTop {
            self.topAnchor.constraint(equalTo: topAnchor, constant: padding).isActive = true
        }
    }
    //垂直置中
    func centerY(inView view: UIView, leftAnochor: NSLayoutXAxisAnchor?, paddingLeft: CGFloat? = nil) {
        
        translatesAutoresizingMaskIntoConstraints = false
        centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        if let leftAnochor = leftAnochor,
           let padding = paddingLeft {
            self.leftAnchor.constraint(equalTo: leftAnochor, constant: padding).isActive = true
        }
    }
    //設定元件大小
    func setDimensions(height: CGFloat, width: CGFloat) {
        
        translatesAutoresizingMaskIntoConstraints = false
        heightAnchor.constraint(equalToConstant:height).isActive = true
        widthAnchor.constraint(equalToConstant: width).isActive = true
    }
    //設定寬高
    func setHeight(height: CGFloat) {
        
        translatesAutoresizingMaskIntoConstraints = false
        heightAnchor.constraint(equalToConstant: height).isActive = true
    }
    
    func setWidth(width: CGFloat) {
        
        translatesAutoresizingMaskIntoConstraints = false
        widthAnchor.constraint(equalToConstant: width).isActive = true
    }
    //全螢幕
    func fillSuperview() {
        
        translatesAutoresizingMaskIntoConstraints = false
        guard let superviewTopAnchor = superview?.topAnchor,
              let superviewBottomAnchor = superview?.bottomAnchor,
              let superviewLeftAnchor = superview?.leftAnchor,
              let superviewRightAnchor = superview?.rightAnchor else {
                  return
              }
        
        anchor(top: superviewTopAnchor, left: superviewLeftAnchor,
               bottom: superviewBottomAnchor, right: superviewRightAnchor)
    }
}


extension UIView {
    
    static var id: String {
        return String(describing: self)
    }
    
    func addSubviews(_ views: UIView...) {
        views.forEach {
            addSubview($0)
        }
    }
    
    func rotate(_ toValue: CGFloat, duration: CFTimeInterval = 0.2) {
        let animation = CABasicAnimation(keyPath: "transform.rotation")
        
        animation.toValue = toValue
        animation.duration = duration
        animation.isRemovedOnCompletion = false
        animation.fillMode = CAMediaTimingFillMode.forwards
        
        self.layer.add(animation, forKey: nil)
    }
    
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIView.dismissKeyboard))
        tap.cancelsTouchesInView = false
        self.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        self.endEditing(true)
    }
    /// 用於tableViewCell和collectionViewCell
    
    func roundCorners(_ corners:CACornerMask, radius: CGFloat) {
        self.layer.cornerRadius = radius
        //        self.layer.maskedCorners = corners
    }
    
    // Using a function since `var image` might conflict with an existing variable
    // (like on `UIImageView`)
    func asImage() -> UIImage {
        let renderer = UIGraphicsImageRenderer(bounds: bounds)
        return renderer.image { rendererContext in
            layer.render(in: rendererContext.cgContext)
        }
    }
    
    enum ViewBorder: String {
        case left = "borderLeft"
        case right = "borderRight"
        case top = "borderTop"
        case bottom = "borderBottom"
    }
    
    func addBorder(edge: ViewBorder, color: UIColor = .hexColor("f0eff0"), borderWidth: CGFloat = 1){
        
        /// 添加前先確認是否有重複
        removeBorder(border: edge)
        
        let border = CALayer()
        border.backgroundColor = color.cgColor
        border.name = edge.rawValue
        
        switch edge {
            case .top:
                border.frame = CGRect(x: 0, y: 0, width: frame.width, height: borderWidth)
            case .bottom:
                border.frame = CGRect(x: 0, y: frame.height - borderWidth, width: frame.width, height: borderWidth)
            case .left:
                border.frame = CGRect(x: 0, y: 0, width: borderWidth, height: frame.height)
            case .right:
                border.frame = CGRect(x: frame.width - borderWidth, y: 0, width: borderWidth, height: frame.height)
        }
        
        layer.addSublayer(border)
    }
    
    func removeBorder(border: ViewBorder) {
        var layerForRemove: CALayer?
        
        for layer in self.layer.sublayers! {
            if layer.name == border.rawValue {
                layerForRemove = layer
            }
        }
        
        if let layer = layerForRemove {
            layer.removeFromSuperlayer()
        }
    }
}


extension CALayer {
    
    enum ViewBorder: String {
        case left = "borderLeft"
        case right = "borderRight"
        case top = "borderTop"
        case bottom = "borderBottom"
    }
    
    func addBorder(edge: ViewBorder, color: UIColor = .hexColor("f0eff0"), borderWidth: CGFloat = 1){
        
        /// 添加前先確認是否有重複
        removeBorder(border: edge)
        
        let border = CALayer()
        border.backgroundColor = color.cgColor
        border.name = edge.rawValue
        
        switch edge {
            case .top:
                border.frame = CGRect(x: 0, y: 0, width: frame.width, height: borderWidth)
            case .bottom:
                border.frame = CGRect(x: 0, y: frame.height - borderWidth, width: frame.width, height: borderWidth)
            case .left:
                border.frame = CGRect(x: 0, y: 0, width: borderWidth, height: frame.height)
            case .right:
                border.frame = CGRect(x: frame.width - borderWidth, y: 0, width: borderWidth, height: frame.height)
        }
        
        addSublayer(border)
    }
    
    func removeBorder(border: ViewBorder) {
        var layerForRemove: CALayer?
        
        for layer in sublayers! {
            if layer.name == border.rawValue {
                layerForRemove = layer
            }
        }
        
        if let layer = layerForRemove {
            layer.removeFromSuperlayer()
        }
    }
}

