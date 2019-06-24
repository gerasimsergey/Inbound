import Foundation
import SortedSet

/// A section in a ListController must be represented by this protocol.
public protocol ListSection: Listable {
    
    /// Represents a row.
    associatedtype Row: ListRow
    
    /// The rows in this section of your view.
    var rows: SortedSet<Row> { get set }
}
