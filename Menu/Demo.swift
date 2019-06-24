import UIKit
import SortedSet

enum Demo: Int, CaseIterable {
        
    case one, two, three, four, five, six, seven
    
    static var all: [Demo] {
        return Demo.allCases
    }
    
    var title: String {
        return "Demo \(rawValue + 1)"
    }
    
    var subtitle: String {
        switch self {
        case .one:
            return """
            • Insert two sections in two transactions.
            • The first transaction should append as last.
            • The second transaction should insert just before last.
            """
        case .two:
            return """
            • Insert a single row.
            • The row should append as last.
            """
        case .three:
            return """
            • Insert multiple sections in a single transaction.
            • Both should append as last, in numerical order.
            """
        case .four:
            return """
            • Insert a single section in a single transaction.
            • The section should append as last.
            """
        case .five:
            return """
            • Insert a single section in a single transaction.
            • The section is already present, so an insert animation should not take place.
            """
        case .six:
            return """
            • Insert multiple items spanning mulitiple sections, in one transaction.
            • Row named '4' being added to section named '1'
            • Row named '3' being added to section named '4'
            """
        case .seven:
            return """
            • Remove multiple rows spanning mulitiple sections, in one transaction.
            • Row named '2' being removed from section named '1'
            • Row named '3' being removed from section named '3'
            """
        }
    }
    
    var scene: UIViewController {
        let controller: CategoryViewController
        switch self {
        case .one:
            let categories = SortedSet(sorted: ContentBuilder.makeCategories(range: (1...2)))
            controller = DemoOneViewController(categories: categories)
        case .two:
            let categories = SortedSet(sorted: ContentBuilder.makeCategories(range: (1...2)))
            controller = DemoTwoViewController(categories: categories)
        case .three:
            let categories = SortedSet(sorted: ContentBuilder.makeCategories(range: (1...2)))
            controller = DemoThreeViewController(categories: categories)
        case .four:
            let categories = SortedSet(sorted: ContentBuilder.makeCategories(range: (1...2)))
            controller = DemoFourViewController(categories: categories)
        case .five:
            let categories = SortedSet(sorted: ContentBuilder.makeCategories(range: (1...2)))
            controller = DemoFiveViewController(categories: categories)
        case .six:
            var categories = SortedSet(sorted: ContentBuilder.makeCategories(range: (1...3)))
            let category = ContentBuilder.makeCategory(name: String(4), withItems: 1, 2, 4)
            categories.insert(category)
            controller = DemoSixViewController(categories: categories)
        case .seven:
            let categories = SortedSet(sorted: ContentBuilder.makeCategories(range: (1...3)))
            controller = DemoSevenViewController(categories: categories)
        }
        controller.demoName = title
        return controller
    }
}
