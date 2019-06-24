import Foundation
import Inbound
import SortedSet

extension TableView: SortedListControllerDelegate {
    typealias Section = Category
}

extension Category: ListSection {
    
    static func ==(lhs: Category, rhs: Category) -> Bool {
        /// you may want to compare items here. it's your call.
        return lhs.name == rhs.name
    }
    
    static func <(lhs: Category, rhs: Category) -> Bool {
        /// you may want to compare items here. it's your call.
        return lhs.name.compare(rhs.name) == .orderedAscending
    }
    
    func hash(into hasher: inout Hasher) {
        /// you may want to include items here. it's your call.
        hasher.combine(name)
    }
}

extension Item: ListRow {
    
    static func ==(lhs: Item, rhs: Item) -> Bool {
        return lhs.name == rhs.name
    }
    
    static func <(lhs: Item, rhs: Item) -> Bool {
        return lhs.name.compare(rhs.name) == .orderedAscending
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(name)
    }
}
