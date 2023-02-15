//
//  Dynamic.swift
//  MVVM CollectionView
//
//  Created by NeferUser on 2022/11/18.
//

import Foundation

class Dynamic<T> {
    
    typealias Listener = (T) -> Void
    var listener: Listener?
    
    var value: T {
        didSet {
            listener?(value)
        }
    }
    
    func bind(callback: @escaping (T)-> Void) {
        self.listener = callback
        listener?(value)
    }
    
    init(_ value: T) {
        self.value = value
    }
}
