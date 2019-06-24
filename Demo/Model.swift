import Foundation
import SortedSet

class Base {
    
    let name: String
    
    var displayName: String {
        return name
    }
    
    init(name: String) {
        self.name = name
    }
    
    init(value: Int) {
        self.name = String(value)
    }
}

final class Category: Base {
    
    var rows = SortedSet<Item>()
    
    override var displayName: String {
        return "Category " + super.displayName
    }
}

final class Item: Base {
    
    unowned let section: Category
    
    var subtitle: String = "This is a row"
    
    override var displayName: String {
        return "Item " + super.displayName
    }
    
    init(value: Int, section: Category) {
        self.section = section
        super.init(value: value)
    }
}
