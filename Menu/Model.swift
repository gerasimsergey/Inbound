import Foundation
import SortedSet

class Base {
    
    let name: String
    
    init(name: String) {
        self.name = name
    }
    
    init(value: Int) {
        self.name = String(value)
    }
}

final class Category: Base {
    var items = SortedSet<Item>()
}

extension Category: Equatable {
    
    static func ==(lhs: Category, rhs: Category) -> Bool {
        return lhs.name == rhs.name
    }
}

extension Category: Comparable {
    
    static func <(lhs: Category, rhs: Category) -> Bool {
        return lhs.name.compare(rhs.name) == .orderedAscending
    }
}

extension Category: Hashable {
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(name)
    }
}

final class Item: Base {
    
    unowned let category: Category
    
    init(value: Int, category: Category) {
        self.category = category
        super.init(value: value)
    }
}

extension Item: Equatable {
    
    static func ==(lhs: Item, rhs: Item) -> Bool {
        return lhs.name == rhs.name
    }
}

extension Item: Comparable {
    
    static func <(lhs: Item, rhs: Item) -> Bool {
        return lhs.name.compare(rhs.name) == .orderedAscending
    }
}

extension Item: Hashable {
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(name)
    }
}


