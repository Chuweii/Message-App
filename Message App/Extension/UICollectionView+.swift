//
//  UICollectionView+.swift
//  MVVM CollectionView
//
//  Created by NeferUser on 2022/12/27.
//

import UIKit

extension UICollectionView {
    
    /// 註冊一個 Class-Based "UICollectionViewCell" 的 subclass
    final func register<T: UICollectionViewCell>(cellType: T.Type) {
          self.register(cellType.self, forCellWithReuseIdentifier: cellType.id)
      }
    
    /**
     Returns a reusable `UICollectionViewCell` object for the class inferred by the return-type
     
     - parameter indexPath: The index path specifying the location of the cell.
     - parameter cellType: The cell class to dequeue
     
     - returns: A  `UICollectionViewCell` instance
     
     - note: The `cellType` parameter can generally be omitted and infered by the return type,
     except when your type is in a variable and cannot be determined at compile time.
     - seealso: `dequeueReusableCell(withReuseIdentifier:,for:)`
     */
    final func dequeueReusableCell<T: UICollectionViewCell>(for indexPath: IndexPath, cellType: T.Type = T.self) -> T {
          let bareCell = self.dequeueReusableCell(withReuseIdentifier: cellType.id, for: indexPath)
          guard let cell = bareCell as? T else {
            fatalError(
              "Failed to dequeue a cell with identifier \(cellType.id) matching type \(cellType.self). "
                + "Check that the reuseIdentifier is set properly in your XIB/Storyboard "
                + "and that you registered the cell beforehand"
            )
          }
          return cell
      }
    
    /// 註冊一個 Class-Based "UICollectionReusableView" 的 subclass
    final func register<T: UICollectionReusableView>(supplementaryViewType: T.Type, ofKind elementKind: String) {
          self.register(
            supplementaryViewType.self,
            forSupplementaryViewOfKind: elementKind,
            withReuseIdentifier: supplementaryViewType.id
          )
      }

    /**
     Returns a reusable `UICollectionReusableView` object for the class inferred by the return-type
       
     - parameter elementKind: The kind of supplementary view to retrieve.
     - parameter indexPath:   The index path specifying the location of the cell.
     - parameter viewType: The view class to dequeue
       
     - returns: A `UICollectionReusableView` instance
       
     - note: The `viewType` parameter can generally be omitted and infered by the return type,
       except when your type is in a variable and cannot be determined at compile time.
     - seealso: `dequeueReusableSupplementaryView(ofKind:,withReuseIdentifier:,for:)`
     */
    final func dequeueReusableSupplementaryView<T: UICollectionReusableView>
        (ofKind elementKind: String, for indexPath: IndexPath, viewType: T.Type = T.self) -> T {
          let view = self.dequeueReusableSupplementaryView(
            ofKind: elementKind,
            withReuseIdentifier: viewType.id,
            for: indexPath
          )
          guard let typedView = view as? T else {
            fatalError(
              "Failed to dequeue a supplementary view with identifier \(viewType.id) "
                + "matching type \(viewType.self). "
                + "Check that the reuseIdentifier is set properly in your XIB/Storyboard "
                + "and that you registered the supplementary view beforehand"
            )
          }
          return typedView
      }
}

