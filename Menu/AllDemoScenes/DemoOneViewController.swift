import UIKit

final class DemoOneViewController: CategoryViewController {
    
    override func performDemo() {
        
        // at this point sections 1 and 2 already exist
        // both have the default number of rows
        
        // let's make a section named '4'
        // the section will have the default number of rows
        
        let category = ContentBuilder.makeCategory(name: String(4))
        tableManager.controller.insert(section: category)
        
        dispatchAfter(seconds: 1) {
            
            // let's make a section named '3' that has a random number of rows
            
            let value = Int.random(in: 1...5)
            let range = (1...value)
            let category = ContentBuilder.makeCategory(name: String(3), itemRange: range)
            self.tableManager.controller.insert(section: category)
        }
    }
}
