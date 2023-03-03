//
//  UIViewController+.swift
//  Message App
//
//  Created by NeferUser on 2023/2/10.
//

import UIKit
import JGProgressHUD

extension UIViewController {
    
    static let hud = JGProgressHUD(style: .dark)
    
    // MARK: - Properties
    
    var topbarHeight: CGFloat {
           return UIApplication.shared.statusBarFrame.size.height +
               (self.navigationController?.navigationBar.frame.height ?? 0.0)
       }
    
    // MARK: - Methods
    
    /// Seg Background gradient
    func setBackgroundGradient(headerColor: CGColor, footerColor: CGColor) {
        let gradient = CAGradientLayer()
        gradient.colors = [headerColor, footerColor]
        gradient.locations = [0, 1]
        view.layer.addSublayer(gradient)
        gradient.frame = view.frame
    }
        
    func showLoader(_ show: Bool, withText text: String? = "Loading") {
        view.endEditing(true)
        UIViewController.hud.textLabel.text = text

        if show {
            UIViewController.hud.show(in: view)
        } else {
            UIViewController.hud.dismiss()
        }
    }
    
    func normalAlert(title:String, message:String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
}
