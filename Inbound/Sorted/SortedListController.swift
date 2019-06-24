import Foundation
import SortedSet

/// A controller for the model of a table view or a collection view.
public class SortedListController<Delegate: SortedListControllerDelegate>: NSObject {
    
    /// The object that acts of the delegate for the SortedListController.
    public weak var delegate: Delegate?
    
    /// The model objects that represent sections of your view.
    public private(set) var sections: SortedSet<Delegate.Section>
    
    /// Initialises a SortedListController with model objects that represent sections of your view. Each section will have model items that represent it's rows.
    ///
    /// - Parameter sections: Model objects that represent sections of your view.
    public init<Section>(sections: SortedSet<Section> = SortedSet<Section>()) where Section == Delegate.Section {
        self.sections = sections
    }
    
    /// Inserts a section model object into the SortedListController. The delegate will subsequently be notified of this update. If the model object is already known to the SortedListController, it will be ignored and the delegate will not be notified.
    ///
    /// - Parameter section: A model object that represents a section of your view.
    public func insert<Section>(section: Section) where Section == Delegate.Section {
        let outcome = sections.insert(section)
        if outcome.didInsert {
            let indexSet = IndexSet([outcome.index])
            delegate?.controller(self, didInsertSection: section, atIndex: indexSet)
        }
    }
    
    /// Inserts a collection of section model objects into the SortedListController. The delegate will subsequently be notified of this update. If the model objects are already known to the SortedListController, they will be ignored and the delegate will not be notified of those specific model objects.
    ///
    /// - Parameter objects: Model objects that represent sections of your view.
    public func insert<Section>(sections objects: [Section]) where Section == Delegate.Section {
        
        let insertions = sections.insert(objects)
        
        if insertions.count > 0 {
            
            var collector = [Section]()
            let indexes: [Int] = insertions.compactMap {
                guard $0.outcome.didInsert else {
                    return nil
                }
                collector.append($0.object)
                return $0.outcome.index
            }
            
            delegate?.controller(self, didInsertSections: collector, atIndex: IndexSet(indexes))
        }
    }
    
    /// Inserts a row model object into the SortedListController. The delegate will subsequently be notified of this update. If the model object is already known to the SortedListController, it will be ignored and the delegate will not be notified.
    ///
    /// - Parameter row: A model object that represents a row of your view.
    public func insert<R>(row: R) where R == Delegate.Section.Row, R.Section == Delegate.Section {
        if let sectionIndex = sections.index(of: row.section) {
            var section = sections[sectionIndex]
            let outcome = section.rows.insert(row)
            if outcome.didInsert {
                let rowIndex = outcome.index
                let indexPath = IndexPath(row: rowIndex, section: sectionIndex)
                delegate?.controller(self, didInsertRow: row, atIndex: indexPath)
            }
        } else {
            insert(section: row.section)
        }
    }
    
    /// Inserts a collection row model objects into the SortedListController. The delegate will subsequently be notified of this update. If any of the model object are already known to the SortedListController, they will be ignored and the delegate will not be notified of those specific model objects.
    ///
    /// - Parameter rows: Model objects that represent rows in your view.
    public func insert<R>(rows: [R]) where R == Delegate.Section.Row, R.Section == Delegate.Section {
        var insertedSectionIndexes = [Int]()
        var newRows = [IndexPath]()
        var insertedRows = [R]()
        for row in rows {
            let outcome = sections.insert(row.section)
            let sectionIndex = outcome.index
            if outcome.didInsert {
                insertedSectionIndexes.append(sectionIndex)
                insertedRows.append(contentsOf: row.section.rows)
            } else {
                // this Chapter already existed so didInsert false
                var section = sections[sectionIndex]
                let outcome = section.rows.insert(row)
                if outcome.didInsert {
                    let rowIndex = outcome.index
                    let indexPath = IndexPath(row: rowIndex, section: sectionIndex)
                    newRows.append(indexPath)
                    insertedRows.append(row)
                }
            }
        }
        if insertedSectionIndexes.count > 0 || newRows.count > 0 {
            delegate?.controller(self, didInsertRows: insertedRows, atPositions: (
                sections: IndexSet(insertedSectionIndexes),
                rows: newRows
            ))
        }
    }
    
    /// Removes a section model object from the SortedListController. The delegate will subsequently be notified of this update. If the model object is already unknown to the SortedListController, it will be ignored and the delegate will not be notified.
    ///
    /// - Parameter section: A model object that represents a section of your view.
    public func remove<Section>(section: Section) where Section == Delegate.Section {
        if let sectionIndex = sections.remove(section) {
            let indexSet = IndexSet([sectionIndex])
            delegate?.controller(self, didRemoveSection: section, atIndex: indexSet)
        }
    }
    
    /// Removes a collection of section model objects from the SortedListController. The delegate will subsequently be notified of this update. If any of the model objects are already unknown to the SortedListController, they will be ignored and the delegate will not be notified of those specific model objects.
    ///
    /// - Parameter objects: Model objects that represent sections of your view.
    public func remove<Section>(sections objects: [Section]) where Section == Delegate.Section {
        let removals = sections.remove(objects)
        if removals.count > 0 {
            var collector = [Section]()
            let indexes: [Int] = removals.compactMap {
                guard $0.index != nil else {
                    return nil
                }
                collector.append($0.object)
                return $0.index
            }
            if indexes.count > 0 {
                delegate?.controller(self, didRemoveSections: collector, atIndex: IndexSet(indexes))
            }
        }
    }
    
    /// Removes a row model object from the SortedListController. The delegate will subsequently be notified of this update. If the model object is already unknown to the SortedListController, it will be ignored and the delegate will not be notified.
    ///
    /// - Parameter row: A model object that represents a row in your view.
    public func remove<R>(row: R) where R == Delegate.Section.Row, R.Section == Delegate.Section {
        if let sectionIndex = sections.index(of: row.section) {
            var section = sections[sectionIndex]
            let countBeforeRemove = section.rows.count
            if let rowIndex = section.rows.remove(row) {
                if countBeforeRemove == 1 {
                    remove(section: row.section)
                } else {
                    let indexPath = IndexPath(row: rowIndex, section: sectionIndex)
                    delegate?.controller(self, didRemoveRow: row, atIndex: indexPath)
                }
            }
        }
    }
    
    /// Removes a collection of row model objects from the SortedListController. The delegate will subsequently be notified of this update. If any of the model objects are unknown to the SortedListController, they will be ignored and the delegate will not be notified of those specific model objects.
    ///
    /// - Parameter rows: Model objects that represent rows in your view.
    public func remove<R>(rows: [R]) where R == Delegate.Section.Row, R.Section == Delegate.Section {
        
        let matchingRows = rows.filter { (rowA) -> Bool in
            for section in sections {
                for rowB in section.rows {
                    if rowA == rowB {
                        return true
                    }
                }
            }
            return false
        }
        
        var rowIndexes = [IndexPath]()
        var oldRows = [R]()
        
        /// collect row indexes
        for row in matchingRows {
            let sectionIndex = sections.index(of: row.section)!
            let section = sections[sectionIndex]
            let rowIndex = section.rows.index(of: row)!
            let indexPath = IndexPath(row: rowIndex, section: sectionIndex)
            rowIndexes.append(indexPath)
        }
        
        /// remove rows
        for row in matchingRows {
            let sectionIndex = sections.index(of: row.section)!
            var section = sections[sectionIndex]
            oldRows.append(row)
            section.rows.remove(row)
        }
        
        let emptySections = sections.filter { (section) -> Bool in
            return section.rows.count == 0
            }
        
        let removals = sections.remove(emptySections)
        let sectionIndexes: [Int] = removals.map { (removal) -> Int in
            return removal.index!
        }
        
        let rowIndexeeeees = rowIndexes.filter { (indexPath) -> Bool in
            return sectionIndexes.contains(indexPath.section) == false
        }
        
        if sectionIndexes.count > 0 || rowIndexeeeees.count > 0 {
            delegate?.controller(self, didRemoveRows: oldRows, atPositions: (
                sections: IndexSet(sectionIndexes),
                rows: rowIndexeeeees
            ))
        }
        
    }
    
    /// Provides the index position of the section.
    ///
    /// - Parameter section: A model object that represents a section of your view.
    /// - Returns: The index position of the section.
    public func index<Section>(forSection section: Section) -> Int? where Section == Delegate.Section {
        return sections.index(of: section)
    }
    
    /// Provides the index position of the row.
    ///
    /// - Parameter row: A model object that represents a row of your view.
    /// - Returns: The index position of the row.
    public func indexPath<R>(forRow row: R) -> IndexPath? where R == Delegate.Section.Row, R.Section == Delegate.Section {
        if let sectionIndex = sections.index(of: row.section) {
            let section = sections[sectionIndex]
            if let rowIndex = section.rows.index(of: row) {
                return IndexPath(row: rowIndex, section: sectionIndex)
            }
            return nil
        }
        return nil
    }
}
