//
//  GenericTableView.swift
//  Message App
//
//  Created by Wei Chu on 2023/1/15.
//

import UIKit

class GenericTableView<T, Cell: UITableViewCell>: UITableView, UITableViewDelegate, UITableViewDataSource {

    // MARK: - Properties

    var items = Dynamic([T]())
    var configure: (Cell, T, IndexPath) -> Void
    var selectHandler: (T, IndexPath) -> Void
    
    // MARK: - init
    
    init(items: [T], configure: @escaping (Cell, T, IndexPath) -> Void, selectHandler: @escaping (T, IndexPath) -> Void) {
        self.items.value = items
        self.configure = configure
        self.selectHandler = selectHandler
        
        super.init(frame: .zero, style: .plain)
        self.register(cellType: Cell.self)
        self.dataSource = self
        self.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UITableView
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.value.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.dequeueReusableCell(for: indexPath) as Cell
        let item = items.value[indexPath.row]
        configure(cell, item, indexPath)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = items.value[indexPath.row]
        selectHandler(item, indexPath)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
}
