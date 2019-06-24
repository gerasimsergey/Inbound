import UIKit

final class RootViewController: UIViewController {

    final class SceneConfigurator: TypicalSceneConfigurator {}
    
    private let tableView: RootTableView
    
    private let tableManager: RootTableView.Manager
    
    convenience init () {
        let tableManager = RootTableView.Manager()
        self.init(tableManager: tableManager)
    }
    
    init(tableManager: RootTableView.Manager) {
        let tableView = RootTableView()
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableManager.didSelect = { [unowned self] demo in
            self.show(demo.scene, sender: nil)
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidLoad()
        if let indexPath = tableView.indexPathForSelectedRow {
            tableView.deselectRow(at: indexPath, animated: true)
        }
    }
}
