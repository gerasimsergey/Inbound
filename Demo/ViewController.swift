import UIKit
import Inbound
import SortedSet

class ViewController: UIViewController {

    @IBOutlet weak var tableView: TableView! {
        didSet {
            tableView.dataSource = self
        }
    }
    
    private let controller = SortedListController<TableView>()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        controller.delegate = tableView
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let category = Category(value: 2)
        let items = (1...3).reversed().map {
            Item(value: $0, section: category)
        }
        category.rows = SortedSet(unsorted: items)
        
        controller.insert(section: category)
        
        dispatchAfter(seconds: 1) {
            
            let category = Category(value: 1)
            let items = (1...3).map {
                Item(value: $0, section: category)
            }
            category.rows = SortedSet(sorted: items)
            
            self.controller.insert(section: category)
        }
        
        dispatchAfter(seconds: 2) {
            
            var rows = [Item]()
            
            // you may want to pull out an existing section
            var category = self.controller.sections[1]
            var item = Item(value: 4, section: category)
            rows.append(item)
            
            // or create a new object that is identical (as per equatable) to an existing section
            category = Category(value: 1)
            let items = (1...3).map {
                Item(value: $0, section: category)
            }
            category.rows = SortedSet(sorted: items)
            
            item = Item(value: 4, section: category)
            rows.append(item)
            item = Item(value: 5, section: category)
            rows.append(item)
            
            self.controller.insert(rows: rows)
        }
        
        dispatchAfter(seconds: 3) {
            
            // let's fetch and update. item is a pointer.
            let item = self.controller.sections[1].rows[2]
            item.subtitle = "THIS IS A GREAT ROW!"
            let indexPath = self.controller.indexPath(forRow: item)!
            self.tableView.reloadRows(at: [indexPath], with: .automatic)
            
        }

    }
}

extension ViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        let sections = controller.sections
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let sections = controller.sections
        let section = sections[section]
        let rows = section.rows
        return rows.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let sections = controller.sections
        let section = sections[indexPath.section]
        let row = section.rows[indexPath.row]
        if Int(row.name) == 4 || Int(row.name) == 5 {
            cell.textLabel?.textColor = .red
        } else {
            cell.textLabel?.textColor = .black
        }
        cell.textLabel?.text = row.displayName
        cell.detailTextLabel?.text = row.subtitle
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let sections = controller.sections
        let section = sections[section]
        return section.displayName
    }
}
