import UIKit

final class ItemTableViewCell: UITableViewCell {
    
    struct Configurator<Model> {
        
        let titleKeyPath: KeyPath<Model, String>
        
        func configure(cell: ItemTableViewCell, model: Model) {
            cell.textLabel?.text = model[keyPath: titleKeyPath]
        }
    }
}

extension ItemTableViewCell: DequeableComponentIdentifiable {}
