import UIKit

final class DemoTwoViewController: CategoryViewController {
    
    override func performDemo() {
        
        // at this point sections 1 and 2 already exist
        // both have the default number of rows
        
        // let's make a row named '4' for an existing section
        
        let category = tableManager.controller.sections[1]
        let item = Item(value: 4, category: category)
        tableManager.controller.insert(row: item)
    }
}
