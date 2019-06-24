import UIKit

final class DemoSevenViewController: CategoryViewController {
    
    override func performDemo() {
        
        // at this point sections named '1', '2' and '3' exist
        // both have the default number of rows
        
        let rows = collectRows()
        tableManager.controller.remove(rows: rows)
    }
    
    private func collectRows() -> [Item] {
        var rows = [Item]()
        // let's remove an existing row named '2' for an existing section named '1'
        var section = tableManager.controller.sections[0]
        var row = section.items[1]
        rows.append(row)
        // let's remove an existing row named '3' for an existing section named '3'
        section = tableManager.controller.sections[2]
        row = section.items[2]
        rows.append(row)
        return rows
    }
}
