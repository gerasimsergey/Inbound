import UIKit

final class DemoFiveViewController: CategoryViewController {
    
    override func performDemo() {
        
        // at this point sections 1 and 2 already exist
        // both have the default number of rows
        
        // let's attempt to insert a section that already exists, named '2'
        
        let name = String(2)
        let category = ContentBuilder.makeCategory(name: name)
        tableManager.controller.insert(section: category)
    }
}
