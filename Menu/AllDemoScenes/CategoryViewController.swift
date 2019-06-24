import UIKit
import SortedSet
import Inbound

class CategoryViewController: UIViewController {
    
    final class SceneConfigurator: TypicalSceneConfigurator {}
    
    private let tableView: CategoryTableView
    
    let tableManager: CategoryTableView.Manager
    
    convenience init(categories: SortedSet<Category> = SortedSet<Category>()) {
        let controller = SortedListController<CategoryTableView>(sections: categories)
        self.init(controller: controller)
    }
    
    convenience init(controller: SortedListController<CategoryTableView>) {
        let tableManager = CategoryTableView.Manager(controller)
        self.init(tableManager: tableManager)
    }
    
    init(tableManager: CategoryTableView.Manager) {
        let tableView = CategoryTableView()
        tableManager.controller.delegate = tableView
        tableView.dataSource = tableManager
        tableView.delegate = tableManager
        self.tableManager = tableManager
        self.tableView = tableView
        super.init(nibName: nil, bundle: nil)
        SceneConfigurator.position(self.tableView, in: self.view)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func performDemo() {
        fatalError("Must override")
    }
    
    var demoName = "Demo"
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        title = demoName
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        performDemo()
    }
}
