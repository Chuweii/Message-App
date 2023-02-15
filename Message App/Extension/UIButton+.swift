//
//  UIButton+.swift
//  Message App
//
//  Created by NeferUser on 2023/2/10.
//

import UIKit

//MARK: - 抓圖方法

extension UIButton {
    
    func downloaded(from url: URL, contentMode mode: ContentMode = .scaleAspectFit) {
        self.imageView?.contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
            else { return }
            DispatchQueue.main.async() { [weak self] in
                self?.setImage(image, for: .normal)
            }
        }.resume()
    }
    func downloaded(from link: String, contentMode mode: ContentMode = .scaleAspectFit) {
        guard let url = URL(string: link) else { return }
        downloaded(from: url, contentMode: mode)
    }
}
