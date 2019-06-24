import UIKit

final class DemoSixViewController: CategoryViewController {
    
    override func performDemo() {
        
        // at this point sections named '1', '2', '3' and '4' exist
        // the first three sections have the default number of rows
        // the fourth section has rows named '1', '2' and '4'
        
        let rows = collectRows()
        tableManager.controller.insert(rows: rows)
    }
    
    private func collectRows() -> [Item] {
        var rows = [Item]()
        // let's add a row named '3' into the section named '4'
        let category2 = tableManager.controller.sections[3]
        let item2 = Item(value: 3, category: category2)
        rows.append(item2)
        // let's add a row named '4' to the section named '1'
        let category1 = tableManager.controller.sections[0]
        let item1 = Item(value: 4, category: category1)
        rows.append(item1)
        return rows
    }
}
