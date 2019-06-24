import UIKit
import SortedSet

/// The delegate of a SortedListController must adopt the SortedListControllerDelegate protocol. Functions of this protocol allow the delegate to manage delete and insert animations that keep the view in sync with the model.
public protocol SortedListControllerDelegate: class {
    
    /// Represents a section.
    associatedtype Section: ListSection
    
    /// The news sections and new rows that have been introduced to the model. The onus is on you to check if newSections or newRows has a count greater than zero.
    typealias Positions = (sections: IndexSet, rows: [IndexPath])
    
    /// Informs the delegate that a new section has been inserted at a specific index.
    ///
    /// - Parameters:
    ///   - controller: The controller managing the model.
    ///   - section: The new section that was inserted.
    ///   - indexSet: The new index position of the new section.
    func controller(_ controller: SortedListController<Self>, didInsertSection section: Section, atIndex indexSet: IndexSet)
    
    /// Informs the delegate that an existing section has been removed at a specific index.
    ///
    /// - Parameters:
    ///   - controller: The controller managing the model.
    ///   - section: The section that was removed.
    ///   - indexSet: The previous index position of the removed section.
    func controller(_ controller: SortedListController<Self>, didRemoveSection section: Section, atIndex indexSet: IndexSet)
    
    /// Informs the delegate that new sections have been inserted at specific index positions.
    ///
    /// - Parameters:
    ///   - controller: The controller managing the model.
    ///   - sections: The new sections that have been inserted.
    ///   - indexSet: The new index positions of the new sections.
    func controller(_ controller: SortedListController<Self>, didInsertSections sections: [Section], atIndex indexSet: IndexSet)
    
    /// Informs the delegate that existing sections have been removed and the index positions they were removed from.
    ///
    /// - Parameters:
    ///   - controller: The controller managing the model.
    ///   - sections: The sections that were removed.
    ///   - indexSet: The previous index positions of the removed sections.
    func controller(_ controller: SortedListController<Self>, didRemoveSections sections: [Section], atIndex indexSet: IndexSet)
    
    /// Informs the delegate that a new row has been inserted at a specific index.
    ///
    /// - Parameters:
    ///   - controller: The controller managing the model.
    ///   - row: The new row that was inserted.
    ///   - indexPath: The new index position of the new row.
    func controller(_ controller: SortedListController<Self>, didInsertRow row: Section.Row, atIndex indexPath: IndexPath)
    
    /// Informs the delegate that an existing row has been removed at a specific index.
    ///
    /// - Parameters:
    ///   - controller: The controller managing the model.
    ///   - row: The row that was removed.
    ///   - indexPath: The previous index position of the removed row.
    func controller(_ controller: SortedListController<Self>, didRemoveRow row: Section.Row, atIndex indexPath: IndexPath)
    
    /// Informs the delegate that new rows have been inserted at specific index positions.
    ///
    /// - Parameters:
    ///   - controller: The controller managing the model.
    ///   - rows: The new rows that have been inserted.
    ///   - positions: The new sections and the new rows that have been inserted.
    func controller(_ controller: SortedListController<Self>, didInsertRows rows: [Section.Row], atPositions positions: Positions)
    
    /// Informs the delegate that existing rows have been removed and the index positions they were removed from.
    ///
    /// - Parameters:
    ///   - controller: The controller managing the model.
    ///   - rows: The rows that were removed.
    ///   - positions: The sections and the rows that have been removed. If a section had all of its rows removed, then that section was removed.
    func controller(_ controller: SortedListController<Self>, didRemoveRows rows: [Section.Row], atPositions positions: Positions)
}

public extension SortedListControllerDelegate where Self: UITableView {
    
    func controller(_ controller: SortedListController<Self>, didInsertSection section: Section, atIndex indexSet: IndexSet) {
        insertSections(indexSet, with: .automatic)
    }
    
    func controller(_ controller: SortedListController<Self>, didRemoveSection section: Section, atIndex indexSet: IndexSet) {
        deleteSections(indexSet, with: .automatic)
    }
    
    func controller(_ controller: SortedListController<Self>, didInsertSections sections: [Section], atIndex indexSet: IndexSet) {
        insertSections(indexSet, with: .automatic)
    }
    
    func controller(_ controller: SortedListController<Self>, didRemoveSections sections: [Section], atIndex indexSet: IndexSet) {
        deleteSections(indexSet, with: .automatic)
    }
    
    func controller(_ controller: SortedListController<Self>, didInsertRow row: Section.Row, atIndex indexPath: IndexPath) {
        insertRows(at: [indexPath], with: .automatic)
    }
    
    func controller(_ controller: SortedListController<Self>, didRemoveRow row: Section.Row, atIndex indexPath: IndexPath) {
        deleteRows(at: [indexPath], with: .automatic)
    }
    
    func controller(_ controller: SortedListController<Self>, didInsertRows rows: [Section.Row], atPositions positions: Positions) {
        beginUpdates()
        insertSections(positions.sections, with: .automatic)
        insertRows(at: positions.rows, with: .automatic)
        endUpdates()
    }
    
    func controller(_ controller: SortedListController<Self>, didRemoveRows rows: [Section.Row], atPositions positions: Positions) {
        beginUpdates()
        deleteSections(positions.sections, with: .automatic)
        deleteRows(at: positions.rows, with: .automatic)
        endUpdates()
    }
}

public extension SortedListControllerDelegate where Self: UICollectionView {
    
    func controller(_ controller: SortedListController<Self>, didInsertSection section: Section, atIndex indexSet: IndexSet) {
        insertSections(indexSet)
    }
    
    func controller(_ controller: SortedListController<Self>, didRemoveSection section: Section, atIndex indexSet: IndexSet) {
        deleteSections(indexSet)
    }
    
    func controller(_ controller: SortedListController<Self>, didInsertSections sections: [Section], atIndex indexSet: IndexSet) {
        insertSections(indexSet)
    }
    
    func controller(_ controller: SortedListController<Self>, didRemoveSections sections: [Section], atIndex indexSet: IndexSet) {
        deleteSections(indexSet)
    }
    
    func controller(_ controller: SortedListController<Self>, didInsertRow row: Section.Row, atIndex indexPath: IndexPath) {
        insertItems(at: [indexPath])
    }
    
    func controller(_ controller: SortedListController<Self>, didRemoveRow row: Section.Row, atIndex indexPath: IndexPath) {
        deleteItems(at: [indexPath])
    }
    
    func controller(_ controller: SortedListController<Self>, didInsertRows rows: [Section.Row], atPositions positions: Positions) {
        performBatchUpdates({
            insertSections(positions.sections)
            insertItems(at: positions.rows)
        }, completion: nil)
    }
    
    func controller(_ controller: SortedListController<Self>, didRemoveRows rows: [Section.Row], atPositions positions: Positions) {
        performBatchUpdates({
            deleteSections(positions.sections)
            deleteItems(at: positions.rows)
        }, completion: nil)
    }
}
