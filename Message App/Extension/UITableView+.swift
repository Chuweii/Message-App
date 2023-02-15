//
//  UITableView+.swift
//  MVVM CollectionView
//
//  Created by NeferUser on 2022/12/27.
//

import UIKit

extension UITableView {
    
    ///完整資訊可參考 Reusable.swift
    ///https://github.com/AliSoftware/Reusable
    
    /// 註冊一個 Class-Based "UITableViewCell" 的 subclass
    final func register<T: UITableViewCell>(cellType: T.Type) {
        self.register(cellType.self, forCellReuseIdentifier: cellType.id)
    }
    
    /**
     Returns a reusable `UITableViewCell` object for the class inferred by the return-type
     
        - parameter indexPath: The index path specifying the location of the cell.
        - parameter cellType: The cell class to dequeue

     - returns: A `UITableViewCell` instance
     
     - note: The `cellType` parameter can generally be omitted and infered by the return type,
        except when your type is in a variable and cannot be determined at compile time.
     - seealso: `dequeueReusableCell(withIdentifier:,for:)`
     */
    func dequeueReusableCell<T: UITableViewCell>(for indexPath: IndexPath, cellType: T.Type = T.self) -> T {
        guard let cell = self.dequeueReusableCell(withIdentifier: cellType.id, for: indexPath) as? T else {
            fatalError(
                "Failed to dequeue a cell with identifier \(cellType.id) matching type \(cellType.self). "
                + "Check that the reuseIdentifier is set properly in your XIB/Storyboard "
                + "and that you registered the cell beforehand"
            )
        }
        return cell
    }
    
    /// 註冊一個 Class-Based "UITableViewHeaderFooterView" 的 subclass
    final func register<T: UITableViewHeaderFooterView>(headerFooterViewType: T.Type) {
          self.register(headerFooterViewType.self, forHeaderFooterViewReuseIdentifier: headerFooterViewType.id)
      }
    
    /**
     Returns a reusable `UITableViewHeaderFooterView` object for the class inferred by the return-type
        
     - parameter viewType: The view class to dequeue
           
     - returns: A `UITableViewHeaderFooterView` instance
     
     - note: The `viewType` parameter can generally be omitted and infered by the return type,
        except when your type is in a variable and cannot be determined at compile time.
     - seealso: `dequeueReusableHeaderFooterView(withIdentifier:)`
     */
    final func dequeueReusableHeaderFooterView<T: UITableViewHeaderFooterView>(_ viewType: T.Type = T.self) -> T? {
          guard let view = self.dequeueReusableHeaderFooterView(withIdentifier: viewType.id) as? T? else {
            fatalError(
              "Failed to dequeue a header/footer with identifier \(viewType.id) "
                + "matching type \(viewType.self). "
                + "Check that the reuseIdentifier is set properly in your XIB/Storyboard "
                + "and that you registered the header/footer beforehand"
            )
          }
          return view
      }
}
