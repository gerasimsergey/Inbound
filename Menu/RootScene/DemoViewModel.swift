import Foundation

struct DemoViewModel {
    
    let title: String
    let subtitle: String
    
    init(title: String, subtitle: String) {
        self.title = title
        self.subtitle = subtitle
    }
    
    init(_ demo: Demo) {
        let title = DemoViewModel.title(for: demo)
        let subtitle = DemoViewModel.subtitle(for: demo)
        self.init(title: title, subtitle: subtitle)
    }
    
    static func title(for demo: Demo) -> String {
        return demo.title
    }
    
    static func subtitle(for demo: Demo) -> String {
        return demo.subtitle
    }
}
