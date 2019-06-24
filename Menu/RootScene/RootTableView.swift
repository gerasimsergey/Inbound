import UIKit

final class RootTableView: UITableView {
    
    final class Manager: NSObject {
        
        private let demos = Demo.all
        
        typealias DemoConsumer = (Demo) -> Void
        
        var didSelect: DemoConsumer?
    }
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: .zero, style: style)
        register(cellType: RootTableViewCell.self)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension RootTableView.Manager: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return demos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let tableView = tableView as? DequeableTableView {
            return tableView.dequeue(indexPath) as RootTableViewCell
        }
        fatalError("Must conform to protocol DequableTableView")
    }
}

extension RootTableView.Manager: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let cell = cell as? RootTableViewCell else {
            fatalError("Expecting RootTableViewCell")
        }
        guard let demo = Demo(rawValue: indexPath.row) else {
            fatalError("Unexpected indexPath")
        }
        let model = DemoViewModel(demo)
        let configurator = RootTableViewCell.Configurator<DemoViewModel>(
            titleKeyPath: \.title,
            subtitleKeyPath: \.subtitle
        )
        configurator.configure(cell: cell, model: model)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let demo = Demo(rawValue: indexPath.row) else {
            fatalError("Unexpected indexPath")
        }
        didSelect?(demo)
    }
}

extension RootTableView: DequeableTableView {}
