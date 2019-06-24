import Foundation

/// A row in a ListController must be represented by this protocol.
public protocol ListRow: Listable {
    
    /// Represents a section.
    associatedtype Section: ListSection
    
    /// The sections of your view.
    var section: Section { get }
}
