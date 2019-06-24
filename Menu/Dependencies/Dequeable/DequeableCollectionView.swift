import UIKit

public protocol DequeableCollectionView: Dequeable {
    func register(_ headerFooterViewType: DequeableComponentIdentifiable.Type, forSupplementaryViewOfKind kind: String)
    func register(_ headerFooterViewType: DequeableComponentIdentifiable.Type, forSupplementaryViewOfKind kind: String, hasXib: Bool)
    func dequeue<T>(_ indexPath: IndexPath) -> T where T : UICollectionViewCell & DequeableComponentIdentifiable
    func dequeueReusableSupplementaryView<T>(_ indexPath: IndexPath, ofKind kind: String) -> T where T : UICollectionReusableView & DequeableComponentIdentifiable
}

public extension DequeableCollectionView where Self: UICollectionView {
    
    func register(_ headerFooterViewType: DequeableComponentIdentifiable.Type, forSupplementaryViewOfKind kind: String) {
        register(headerFooterViewType, forSupplementaryViewOfKind: kind, hasXib: false)
    }
    
    func register(_ headerFooterViewType: DequeableComponentIdentifiable.Type, forSupplementaryViewOfKind kind: String, hasXib: Bool) {
        let identifier = headerFooterViewType.dequableComponentIdentifier
        if hasXib == true {
            let className = typeName(headerFooterViewType)
            let nib = UINib(nibName: className, bundle: Bundle(for: headerFooterViewType))
            register(nib, forSupplementaryViewOfKind: kind, withReuseIdentifier: identifier)
        } else {
            register(headerFooterViewType, forSupplementaryViewOfKind: kind, withReuseIdentifier: identifier)
        }
    }
    
    func dequeue<T>(_ indexPath: IndexPath) -> T where T : UICollectionViewCell & DequeableComponentIdentifiable {
      return dequeueReusableCell(withReuseIdentifier: T.dequableComponentIdentifier, for: indexPath) as! T
    }
  
    func dequeueReusableSupplementaryView<T>(_ indexPath: IndexPath, ofKind kind: String) -> T where T : UICollectionReusableView & DequeableComponentIdentifiable {
        return dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: T.dequableComponentIdentifier, for: indexPath) as! T
    }
  
}
