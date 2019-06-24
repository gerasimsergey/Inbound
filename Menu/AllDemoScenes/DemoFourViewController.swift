import UIKit

final class DemoFourViewController: CategoryViewController {
    
    override func performDemo() {
        
        // at this point sections 1 and 2 already exist
        // both have the default number of rows
        
        // let's make a section named '3'
        
        let name = String(3)
        let category = ContentBuilder.makeCategory(name: name)
        tableManager.controller.insert(section: category)
    }
}
