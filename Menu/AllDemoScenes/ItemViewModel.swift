import Foundation

struct ItemViewModel {
    
    let title: String
    
    init(title: String) {
        self.title = title
    }
    
    init(_ item: Item) {
        let title = ItemViewModel.title(for: item)
        self.init(title: title)
    }
    
    static func title(for item: Item) -> String {
        return item.name
    }
}
