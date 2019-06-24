import UIKit

final class RootTableViewCell: UITableViewCell {
    
    struct Configurator<Model> {
        
        let titleKeyPath: KeyPath<Model, String>
        let subtitleKeyPath: KeyPath<Model, String>
        
        func configure(cell: RootTableViewCell, model: Model) {
            cell.textLabel?.text = model[keyPath: titleKeyPath]
            cell.detailTextLabel?.text = model[keyPath: subtitleKeyPath]
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
        detailTextLabel?.numberOfLines = 0
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension RootTableViewCell: DequeableComponentIdentifiable {}
