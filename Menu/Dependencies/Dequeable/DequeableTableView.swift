import UIKit

public protocol DequeableTableView: Dequeable {
    func register(headerFooterViewType: DequeableComponentIdentifiable.Type)
    func register(headerFooterViewType: DequeableComponentIdentifiable.Type, hasXib: Bool)
    func dequeue<T>(_ indexPath: IndexPath) -> T where T : UITableViewCell & DequeableComponentIdentifiable
    func dequeue<T>() -> T where T : UITableViewHeaderFooterView & DequeableComponentIdentifiable
}

public extension DequeableTableView where Self: UITableView {
    
    func register(headerFooterViewType: DequeableComponentIdentifiable.Type) {
        register(headerFooterViewType: headerFooterViewType, hasXib: false)
    }
    
    func register(headerFooterViewType: DequeableComponentIdentifiable.Type, hasXib: Bool) {
        let identifier = headerFooterViewType.dequableComponentIdentifier
        if hasXib == true {
            let className = typeName(headerFooterViewType)
            let bundle = Bundle(for: headerFooterViewType)
            let nib = UINib(nibName: className, bundle: bundle)
            register(nib, forHeaderFooterViewReuseIdentifier: identifier)
        } else {
            register(headerFooterViewType, forHeaderFooterViewReuseIdentifier: identifier)
        }
    }
    
    func dequeue<T>(_ indexPath: IndexPath) -> T where T : UITableViewCell & DequeableComponentIdentifiable {
        return dequeueReusableCell(withIdentifier: T.dequableComponentIdentifier, for: indexPath) as! T
    }
    
    func dequeue<T>() -> T where T : UITableViewHeaderFooterView & DequeableComponentIdentifiable {
        return dequeueReusableHeaderFooterView(withIdentifier: T.dequableComponentIdentifier) as! T
    }
}
