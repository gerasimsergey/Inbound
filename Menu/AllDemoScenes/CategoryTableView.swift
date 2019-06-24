import UIKit
import Inbound

final class CategoryTableView: UITableView {
    
    final class Manager: NSObject {
        
        let controller: SortedListController<CategoryTableView>
        
        init(_ controller: SortedListController<CategoryTableView>) {
            self.controller = controller
        }
    }
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        register(cellType: ItemTableViewCell.self)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension CategoryTableView.Manager: UITableViewDataSource {
    
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
        if let tableView = tableView as? DequeableTableView {
            return tableView.dequeue(indexPath) as ItemTableViewCell
        }
        fatalError("Must conform to protocol DequeableTableView")
    }
}

extension CategoryTableView.Manager: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let sections = controller.sections
        let section = sections[section]
        return section.name
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let cell = cell as? ItemTableViewCell else {
            fatalError("Expecting ItemTableViewCell")
        }
        let sections = controller.sections
        let section = sections[indexPath.section]
        let row = section.rows[indexPath.row]
        let model = ItemViewModel(row)
        let configurator = ItemTableViewCell.Configurator<ItemViewModel>(titleKeyPath: \.title)
        configurator.configure(cell: cell, model: model)
    }
}

extension CategoryTableView: DequeableTableView {}
