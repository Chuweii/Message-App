//
//  UIViewController+.swift
//  Message App
//
//  Created by NeferUser on 2023/2/10.
//

import UIKit

extension UIViewController {
    
    func setBackgroundGradient() {
        let gradient = CAGradientLayer()
        gradient.colors = [UIColor.systemPurple.cgColor, UIColor.systemPink.cgColor]
        gradient.locations = [0, 1]
        view.layer.addSublayer(gradient)
        gradient.frame = view.frame
    }
}
