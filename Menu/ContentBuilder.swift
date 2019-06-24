import Foundation
import SortedSet

/// A convenience factory for building a model for a table view. Category will represent a table section. Item will represent a talbe view row.
struct ContentBuilder {
    
    /// Makes a collection of categories mapped to the supplied range. Each category will have the default number of rows.
    ///
    /// - Parameter range: The range of categories to make.
    /// - Returns: A collection of categories. These represent sections.
    static func makeCategories(range: CountableClosedRange<Int>) -> [Category] {
        return range.map {
            return makeCategory(name: String($0)) // default number of items
        }
    }
    
    /// Makes a category with a default number of items.
    ///
    /// - Parameters:
    ///   - name: The name of the category. This will be the section name.
    ///   - itemRange: The range of items to make. This will be the number of rows for this section.
    /// - Returns: A category, which represents a section.
    static func makeCategory(name: String, itemRange: CountableClosedRange<Int> = (1...3)) -> Category {
        let category = Category(name: name)
        let items = itemRange.map {
            Item(value: $0, category: category)
        }
        category.items = SortedSet(sorted: items)
        return category
    }
    
    /// Makes a category with a default number of items.
    ///
    /// - Parameters:
    ///   - name: The name of the category. This will be the section name.
    ///   - items: The items to make. This will be the rows for this section.
    /// - Returns: A category, which represents a section.
    static func makeCategory(name: String, withItems items: Int...) -> Category {
        let category = Category(name: name)
        let items = items.map {
            Item(value: $0, category: category)
        }
        category.items = SortedSet(sorted: items)
        return category
    }
}
