import UIKit

final class DemoThreeViewController: CategoryViewController {
    
    override func performDemo() {
        
        // at this point sections 1 and 2 already exist
        // both have the default number of rows
        
        // let's make two new sections named '3' and '4' respectively
        
        let categories = ContentBuilder.makeCategories(range: 3...4)
        tableManager.controller.insert(sections: categories)
    }
}
