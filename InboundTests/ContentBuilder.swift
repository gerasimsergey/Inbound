import Foundation
import SortedSet

struct ContentBuilder {
    
    static func makeCategories(range: CountableClosedRange<Int>) -> [Category] {
        return range.map {
            return makeCategory(name: String($0))
        }
    }
    
    static func makeCategory(name: String, itemRange: CountableClosedRange<Int> = (1...3)) -> Category {
        let category = Category(name: name)
        let items = makeItems(range: itemRange, for: category)
        category.items = SortedSet(sorted: items)
        return category
    }
    
    static func makeItems(range: CountableClosedRange<Int>, for category: Category) -> [Item] {
        return range.map {
            Item(value: $0, category: category)
        }
    }
    
    static func makeCategory(name: String, withItems items: Int...) -> Category {
        let category = Category(name: name)
        let items = items.map {
            Item(value: $0, category: category)
        }
        category.items = SortedSet(sorted: items)
        return category
    }
}
