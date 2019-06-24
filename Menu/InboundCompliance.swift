import Foundation
import SortedSet
import Inbound

extension Category: ListSection {
    
    var rows: SortedSet<Item> {
        get {
            return items
        }
        set {
            items = newValue
        }
    }
}

extension Item: ListRow {
    
    var section: Category {
        return category
    }
}

extension CategoryTableView: SortedListControllerDelegate {
    
    typealias Section = Category
    
}
