//
//  UINavigationController+.swift
//  Message App
//
//  Created by NeferUser on 2023/2/14.
//

import UIKit

extension UINavigationController {
    
    func setupNavStyle(vc: UIViewController, title: String,preferLargeTitle: Bool , background: UIColor) {
        /// Title
        vc.navigationItem.title = title
        vc.navigationController?.navigationBar.prefersLargeTitles = preferLargeTitle
        
        /// Navgation Background Color
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        appearance.backgroundColor = background
        
        /// NavigationBar
        vc.navigationController?.navigationBar.tintColor = .white
        vc.navigationController?.navigationBar.standardAppearance = appearance
        vc.navigationController?.navigationBar.compactAppearance = appearance
        vc.navigationController?.navigationBar.scrollEdgeAppearance = appearance
        vc.navigationController?.navigationBar.isTranslucent = true
        vc.navigationController?.navigationBar.overrideUserInterfaceStyle = .dark
    }
}
