import XCTest
import Inbound
import SortedSet

class InboundTests: XCTestCase {

    func testSortedListControllerInit() {
        final class CategoryTableView: UITableView, SortedListControllerDelegate {
            typealias Section = Category
        }
        let categories = ContentBuilder.makeCategories(range: 1...3)
        let sections = SortedSet(sorted: categories)
        let controller = SortedListController<CategoryTableView>(sections: sections)
        XCTAssertEqual(controller.sections, sections)
    }
    
    func testInsertNewSection() {
        final class CategoryTableView: UITableView, SortedListControllerDelegate {
            typealias Section = Category
            var insertedSection: Section?
            var position: IndexSet?
            func controller(_ controller: SortedListController<CategoryTableView>, didInsertSection section: Section, atIndex indexSet: IndexSet) {
                insertedSection = section
                position = indexSet
            }
            func controller(_ controller: SortedListController<CategoryTableView>, didRemoveSection section: Section, atIndex indexSet: IndexSet) {
                XCTFail()
            }
            func controller(_ controller: SortedListController<CategoryTableView>, didInsertSections sections: [Section], atIndex indexSet: IndexSet) {
                XCTFail()
            }
            func controller(_ controller: SortedListController<CategoryTableView>, didInsertRow row: Section.Row, atIndex indexPath: IndexPath) {
                XCTFail()
            }
            func controller(_ controller: SortedListController<CategoryTableView>, didRemoveRow row: Section.Row, atIndex indexPath: IndexPath) {
                XCTFail()
            }
            func controller(_ controller: SortedListController<CategoryTableView>, didInsertRows rows: [Section.Row], atPositions positions: Positions) {
                XCTFail()
            }
        }
        let tableView = CategoryTableView()
        let categories = ContentBuilder.makeCategories(range: 1...3)
        let sections = SortedSet(sorted: categories)
        let controller = SortedListController<CategoryTableView>(sections: sections)
        controller.delegate = tableView
        let category = ContentBuilder.makeCategory(name: String(4))
        controller.insert(section: category)
        XCTAssertNotNil(tableView.insertedSection)
        XCTAssertEqual(tableView.insertedSection, category)
        XCTAssertNotNil(tableView.position)
        XCTAssert(tableView.position?.count == 1)
        XCTAssert(tableView.position?.contains(3) == true) // zero indexed so position 4 will be index 3
        XCTAssert(controller.sections.count == 4)
    }
    
    func testInsertExistingSection() {
        final class CategoryTableView: UITableView, SortedListControllerDelegate {
            typealias Section = Category
            var insertedSection: Section?
            var position: IndexSet?
            func controller(_ controller: SortedListController<CategoryTableView>, didInsertSection section: Section, atIndex indexSet: IndexSet) {
                insertedSection = section
                position = indexSet
            }
            func controller(_ controller: SortedListController<CategoryTableView>, didRemoveSection section: Section, atIndex indexSet: IndexSet) {
                XCTFail()
            }
            func controller(_ controller: SortedListController<CategoryTableView>, didInsertSections sections: [Section], atIndex indexSet: IndexSet) {
                XCTFail()
            }
            func controller(_ controller: SortedListController<CategoryTableView>, didInsertRow row: Section.Row, atIndex indexPath: IndexPath) {
                XCTFail()
            }
            func controller(_ controller: SortedListController<CategoryTableView>, didRemoveRow row: Section.Row, atIndex indexPath: IndexPath) {
                XCTFail()
            }
            func controller(_ controller: SortedListController<CategoryTableView>, didInsertRows rows: [Section.Row], atPositions positions: Positions) {
                XCTFail()
            }
        }
        let tableView = CategoryTableView()
        let categories = ContentBuilder.makeCategories(range: 1...3)
        let sections = SortedSet(sorted: categories)
        let controller = SortedListController<CategoryTableView>(sections: sections)
        controller.delegate = tableView
        let category = ContentBuilder.makeCategory(name: String(1))
        controller.insert(section: category)
        XCTAssertNil(tableView.insertedSection)
        XCTAssertNil(tableView.position)
        XCTAssert(controller.sections.count == 3)
    }
    
    func testRemoveNewSection() {
        final class CategoryTableView: UITableView, SortedListControllerDelegate {
            typealias Section = Category
            var removedSection: Section?
            var position: IndexSet?
            func controller(_ controller: SortedListController<CategoryTableView>, didInsertSection section: Section, atIndex indexSet: IndexSet) {
                XCTFail()
            }
            func controller(_ controller: SortedListController<CategoryTableView>, didRemoveSection section: Section, atIndex indexSet: IndexSet) {
                removedSection = section
                position = indexSet
            }
            func controller(_ controller: SortedListController<CategoryTableView>, didInsertSections sections: [Section], atIndex indexSet: IndexSet) {
                XCTFail()
            }
            func controller(_ controller: SortedListController<CategoryTableView>, didInsertRow row: Section.Row, atIndex indexPath: IndexPath) {
                XCTFail()
            }
            func controller(_ controller: SortedListController<CategoryTableView>, didRemoveRow row: Section.Row, atIndex indexPath: IndexPath) {
                XCTFail()
            }
            func controller(_ controller: SortedListController<CategoryTableView>, didInsertRows rows: [Section.Row], atPositions positions: Positions) {
                XCTFail()
            }
        }
        let tableView = CategoryTableView()
        let categories = ContentBuilder.makeCategories(range: 1...3)
        let sections = SortedSet(sorted: categories)
        let controller = SortedListController<CategoryTableView>(sections: sections)
        controller.delegate = tableView
        let category = ContentBuilder.makeCategory(name: String(4))
        controller.remove(section: category)
        XCTAssertNil(tableView.removedSection)
        XCTAssertNil(tableView.position)
        XCTAssert(controller.sections.count == 3)
    }

    func testRemoveExistingSection() {
        final class CategoryTableView: UITableView, SortedListControllerDelegate {
            typealias Section = Category
            var removedSection: Section?
            var position: IndexSet?
            func controller(_ controller: SortedListController<CategoryTableView>, didInsertSection section: Section, atIndex indexSet: IndexSet) {
                XCTFail()
            }
            func controller(_ controller: SortedListController<CategoryTableView>, didRemoveSection section: Section, atIndex indexSet: IndexSet) {
                removedSection = section
                position = indexSet
            }
            func controller(_ controller: SortedListController<CategoryTableView>, didInsertSections sections: [Section], atIndex indexSet: IndexSet) {
                XCTFail()
            }
            func controller(_ controller: SortedListController<CategoryTableView>, didInsertRow row: Section.Row, atIndex indexPath: IndexPath) {
                XCTFail()
            }
            func controller(_ controller: SortedListController<CategoryTableView>, didRemoveRow row: Section.Row, atIndex indexPath: IndexPath) {
                XCTFail()
            }
            func controller(_ controller: SortedListController<CategoryTableView>, didInsertRows rows: [Section.Row], atPositions positions: Positions) {
                XCTFail()
            }
        }
        let tableView = CategoryTableView()
        let categories = ContentBuilder.makeCategories(range: 1...3)
        let sections = SortedSet(sorted: categories)
        let controller = SortedListController<CategoryTableView>(sections: sections)
        controller.delegate = tableView
        let category = ContentBuilder.makeCategory(name: String(1))
        controller.remove(section: category)
        XCTAssertNotNil(tableView.removedSection)
        XCTAssertEqual(tableView.removedSection, category)
        XCTAssertNotNil(tableView.position)
        XCTAssert(tableView.position?.count == 1)
        XCTAssert(tableView.position?.contains(0) == true)
        XCTAssert(controller.sections.count == 2)
    }

    func testInsertNewSections() {
        final class CategoryTableView: UITableView, SortedListControllerDelegate {
            typealias Section = Category
            var insertedSections: [Section]?
            var position: IndexSet?
            func controller(_ controller: SortedListController<CategoryTableView>, didInsertSection section: Section, atIndex indexSet: IndexSet) {
                XCTFail()
            }
            func controller(_ controller: SortedListController<CategoryTableView>, didRemoveSection section: Section, atIndex indexSet: IndexSet) {
                XCTFail()
            }
            func controller(_ controller: SortedListController<CategoryTableView>, didInsertSections sections: [Section], atIndex indexSet: IndexSet) {
                insertedSections = sections
                position = indexSet
            }
            func controller(_ controller: SortedListController<CategoryTableView>, didInsertRow row: Section.Row, atIndex indexPath: IndexPath) {
                XCTFail()
            }
            func controller(_ controller: SortedListController<CategoryTableView>, didRemoveRow row: Section.Row, atIndex indexPath: IndexPath) {
                XCTFail()
            }
            func controller(_ controller: SortedListController<CategoryTableView>, didInsertRows rows: [Section.Row], atPositions positions: Positions) {
                XCTFail()
            }
        }
        let tableView = CategoryTableView()
        let categories = ContentBuilder.makeCategories(range: 1...3)
        let sections = SortedSet(sorted: categories)
        let controller = SortedListController<CategoryTableView>(sections: sections)
        controller.delegate = tableView
        let newCategories = ContentBuilder.makeCategories(range: 4...6)
        controller.insert(sections: newCategories)
        XCTAssertNotNil(tableView.insertedSections)
        XCTAssertEqual(tableView.insertedSections, newCategories)
        XCTAssertNotNil(tableView.position)
        XCTAssert(tableView.position?.count == 3)
        XCTAssert(tableView.position?.contains(3) == true)
        XCTAssert(tableView.position?.contains(4) == true)
        XCTAssert(tableView.position?.contains(5) == true)
        XCTAssert(controller.sections.count == 6)
    }
    
    func testInsertExistingSections() {
        final class CategoryTableView: UITableView, SortedListControllerDelegate {
            typealias Section = Category
            var insertedSections: [Section]?
            var position: IndexSet?
            func controller(_ controller: SortedListController<CategoryTableView>, didInsertSection section: Section, atIndex indexSet: IndexSet) {
                XCTFail()
            }
            func controller(_ controller: SortedListController<CategoryTableView>, didRemoveSection section: Section, atIndex indexSet: IndexSet) {
                XCTFail()
            }
            func controller(_ controller: SortedListController<CategoryTableView>, didInsertSections sections: [Section], atIndex indexSet: IndexSet) {
                insertedSections = sections
                position = indexSet
            }
            func controller(_ controller: SortedListController<CategoryTableView>, didInsertRow row: Section.Row, atIndex indexPath: IndexPath) {
                XCTFail()
            }
            func controller(_ controller: SortedListController<CategoryTableView>, didRemoveRow row: Section.Row, atIndex indexPath: IndexPath) {
                XCTFail()
            }
            func controller(_ controller: SortedListController<CategoryTableView>, didInsertRows rows: [Section.Row], atPositions positions: Positions) {
                XCTFail()
            }
        }
        let tableView = CategoryTableView()
        let categories = ContentBuilder.makeCategories(range: 1...3)
        let sections = SortedSet(sorted: categories)
        let controller = SortedListController<CategoryTableView>(sections: sections)
        controller.delegate = tableView
        let existingCategories = ContentBuilder.makeCategories(range: 1...2)
        controller.insert(sections: existingCategories)
        XCTAssertNil(tableView.insertedSections)
        XCTAssertNil(tableView.position)
        XCTAssert(controller.sections.count == 3)
    }
    
    func testRemoveNewSections() {
        final class CategoryTableView: UITableView, SortedListControllerDelegate {
            typealias Section = Category
            var removedSections: [Section]?
            var position: IndexSet?
            func controller(_ controller: SortedListController<CategoryTableView>, didInsertSection section: Section, atIndex indexSet: IndexSet) {
                XCTFail()
            }
            func controller(_ controller: SortedListController<CategoryTableView>, didRemoveSection section: Section, atIndex indexSet: IndexSet) {
                XCTFail()
            }
            func controller(_ controller: SortedListController<CategoryTableView>, didInsertSections sections: [Section], atIndex indexSet: IndexSet) {
                XCTFail()
            }
            func controller(_ controller: SortedListController<CategoryTableView>, didRemoveSections sections: [Section], atIndex indexSet: IndexSet) {
                removedSections = sections
                position = indexSet
            }
            func controller(_ controller: SortedListController<CategoryTableView>, didInsertRow row: Section.Row, atIndex indexPath: IndexPath) {
                XCTFail()
            }
            func controller(_ controller: SortedListController<CategoryTableView>, didRemoveRow row: Section.Row, atIndex indexPath: IndexPath) {
                XCTFail()
            }
            func controller(_ controller: SortedListController<CategoryTableView>, didInsertRows rows: [Section.Row], atPositions positions: Positions) {
                XCTFail()
            }
        }
        let tableView = CategoryTableView()
        let categories = ContentBuilder.makeCategories(range: 1...3)
        let sections = SortedSet(sorted: categories)
        let controller = SortedListController<CategoryTableView>(sections: sections)
        controller.delegate = tableView
        let newCategories = ContentBuilder.makeCategories(range: 4...6)
        controller.remove(sections: newCategories)
        XCTAssertNil(tableView.removedSections)
        XCTAssertNil(tableView.position)
        XCTAssert(controller.sections.count == 3)
    }
    
    func testRemoveExistingSections() {
        final class CategoryTableView: UITableView, SortedListControllerDelegate {
            typealias Section = Category
            var removedSections: [Section]?
            var position: IndexSet?
            func controller(_ controller: SortedListController<CategoryTableView>, didInsertSection section: Section, atIndex indexSet: IndexSet) {
                XCTFail()
            }
            func controller(_ controller: SortedListController<CategoryTableView>, didRemoveSection section: Section, atIndex indexSet: IndexSet) {
                XCTFail()
            }
            func controller(_ controller: SortedListController<CategoryTableView>, didInsertSections sections: [Section], atIndex indexSet: IndexSet) {
                XCTFail()
            }
            func controller(_ controller: SortedListController<CategoryTableView>, didRemoveSections sections: [Section], atIndex indexSet: IndexSet) {
                removedSections = sections
                position = indexSet
            }
            func controller(_ controller: SortedListController<CategoryTableView>, didInsertRow row: Section.Row, atIndex indexPath: IndexPath) {
                XCTFail()
            }
            func controller(_ controller: SortedListController<CategoryTableView>, didRemoveRow row: Section.Row, atIndex indexPath: IndexPath) {
                XCTFail()
            }
            func controller(_ controller: SortedListController<CategoryTableView>, didInsertRows rows: [Section.Row], atPositions positions: Positions) {
                XCTFail()
            }
        }
        let tableView = CategoryTableView()
        let categories = ContentBuilder.makeCategories(range: 1...3)
        let sections = SortedSet(sorted: categories)
        let controller = SortedListController<CategoryTableView>(sections: sections)
        controller.delegate = tableView
        let newCategories = ContentBuilder.makeCategories(range: 1...2)
        controller.remove(sections: newCategories)
        XCTAssertNotNil(tableView.removedSections)
        XCTAssertEqual(tableView.removedSections, newCategories)
        XCTAssertNotNil(tableView.position)
        XCTAssert(tableView.position?.count == 2)
        XCTAssert(tableView.position?.contains(0) == true)
        XCTAssert(tableView.position?.contains(1) == true)
        XCTAssert(controller.sections.count == 1)
    }
    
    func testInsertNewRow() {
        final class CategoryTableView: UITableView, SortedListControllerDelegate {
            typealias Section = Category
            var insertedRow: Section.Row?
            var position: IndexPath?
            func controller(_ controller: SortedListController<CategoryTableView>, didInsertSection section: Section, atIndex indexSet: IndexSet) {
                XCTFail()
            }
            func controller(_ controller: SortedListController<CategoryTableView>, didRemoveSection section: Section, atIndex indexSet: IndexSet) {
                XCTFail()
            }
            func controller(_ controller: SortedListController<CategoryTableView>, didInsertSections sections: [Section], atIndex indexSet: IndexSet) {
                XCTFail()
            }
            func controller(_ controller: SortedListController<CategoryTableView>, didInsertRow row: Section.Row, atIndex indexPath: IndexPath) {
                insertedRow = row
                position = indexPath
            }
            func controller(_ controller: SortedListController<CategoryTableView>, didRemoveRow row: Section.Row, atIndex indexPath: IndexPath) {
                XCTFail()
            }
            func controller(_ controller: SortedListController<CategoryTableView>, didInsertRows rows: [Section.Row], atPositions positions: Positions) {
                XCTFail()
            }
        }
        let tableView = CategoryTableView()
        let categories = ContentBuilder.makeCategories(range: 1...3)
        let sections = SortedSet(sorted: categories)
        let controller = SortedListController<CategoryTableView>(sections: sections)
        controller.delegate = tableView
        let category = ContentBuilder.makeCategory(name: String(2))
        let item = Item(value: 4, category: category)
        controller.insert(row: item)
        XCTAssertNotNil(tableView.insertedRow)
        XCTAssertEqual(tableView.insertedRow, item)
        XCTAssertNotNil(tableView.position)
        XCTAssertEqual(tableView.position, IndexPath(row: 3, section: 1))
        XCTAssert(controller.sections[1].rows.count == 4)
    }
    
    func testInsertExistingRow() {
        final class CategoryTableView: UITableView, SortedListControllerDelegate {
            typealias Section = Category
            var insertedRow: Section.Row?
            var position: IndexPath?
            func controller(_ controller: SortedListController<CategoryTableView>, didInsertSection section: Section, atIndex indexSet: IndexSet) {
                XCTFail()
            }
            func controller(_ controller: SortedListController<CategoryTableView>, didRemoveSection section: Section, atIndex indexSet: IndexSet) {
                XCTFail()
            }
            func controller(_ controller: SortedListController<CategoryTableView>, didInsertSections sections: [Section], atIndex indexSet: IndexSet) {
                XCTFail()
            }
            func controller(_ controller: SortedListController<CategoryTableView>, didInsertRow row: Section.Row, atIndex indexPath: IndexPath) {
                insertedRow = row
                position = indexPath
            }
            func controller(_ controller: SortedListController<CategoryTableView>, didRemoveRow row: Section.Row, atIndex indexPath: IndexPath) {
                XCTFail()
            }
            func controller(_ controller: SortedListController<CategoryTableView>, didInsertRows rows: [Section.Row], atPositions positions: Positions) {
                XCTFail()
            }
        }
        let tableView = CategoryTableView()
        let categories = ContentBuilder.makeCategories(range: 1...3)
        let sections = SortedSet(sorted: categories)
        let controller = SortedListController<CategoryTableView>(sections: sections)
        controller.delegate = tableView
        let category = ContentBuilder.makeCategory(name: String(2))
        let item = Item(value: 1, category: category)
        controller.insert(row: item)
        XCTAssertNil(tableView.insertedRow)
        XCTAssertNil(tableView.position)
        XCTAssert(controller.sections[1].rows.count == 3)
    }
    
    func testRemoveNewRow() {
        final class CategoryTableView: UITableView, SortedListControllerDelegate {
            typealias Section = Category
            var removedRow: Section.Row?
            var position: IndexPath?
            func controller(_ controller: SortedListController<CategoryTableView>, didInsertSection section: Section, atIndex indexSet: IndexSet) {
                XCTFail()
            }
            func controller(_ controller: SortedListController<CategoryTableView>, didRemoveSection section: Section, atIndex indexSet: IndexSet) {
                XCTFail()
            }
            func controller(_ controller: SortedListController<CategoryTableView>, didInsertSections sections: [Section], atIndex indexSet: IndexSet) {
                XCTFail()
            }
            func controller(_ controller: SortedListController<CategoryTableView>, didInsertRow row: Section.Row, atIndex indexPath: IndexPath) {
                XCTFail()
            }
            func controller(_ controller: SortedListController<CategoryTableView>, didRemoveRow row: Section.Row, atIndex indexPath: IndexPath) {
                removedRow = row
                position = indexPath
            }
            func controller(_ controller: SortedListController<CategoryTableView>, didInsertRows rows: [Section.Row], atPositions positions: Positions) {
                XCTFail()
            }
        }
        let tableView = CategoryTableView()
        let categories = ContentBuilder.makeCategories(range: 1...3)
        let sections = SortedSet(sorted: categories)
        let controller = SortedListController<CategoryTableView>(sections: sections)
        controller.delegate = tableView
        let category = ContentBuilder.makeCategory(name: String(2))
        let item = Item(value: 4, category: category)
        controller.remove(row: item)
        XCTAssertNil(tableView.removedRow)
        XCTAssertNil(tableView.position)
        XCTAssert(controller.sections[1].rows.count == 3)
    }
    
    func testRemoveExistingRow() {
        final class CategoryTableView: UITableView, SortedListControllerDelegate {
            typealias Section = Category
            var removedRow: Section.Row?
            var position: IndexPath?
            func controller(_ controller: SortedListController<CategoryTableView>, didInsertSection section: Section, atIndex indexSet: IndexSet) {
                XCTFail()
            }
            func controller(_ controller: SortedListController<CategoryTableView>, didRemoveSection section: Section, atIndex indexSet: IndexSet) {
                XCTFail()
            }
            func controller(_ controller: SortedListController<CategoryTableView>, didInsertSections sections: [Section], atIndex indexSet: IndexSet) {
                XCTFail()
            }
            func controller(_ controller: SortedListController<CategoryTableView>, didInsertRow row: Section.Row, atIndex indexPath: IndexPath) {
                XCTFail()
            }
            func controller(_ controller: SortedListController<CategoryTableView>, didRemoveRow row: Section.Row, atIndex indexPath: IndexPath) {
                removedRow = row
                position = indexPath
            }
            func controller(_ controller: SortedListController<CategoryTableView>, didInsertRows rows: [Section.Row], atPositions positions: Positions) {
                XCTFail()
            }
        }
        let tableView = CategoryTableView()
        let categories = ContentBuilder.makeCategories(range: 1...3)
        let sections = SortedSet(sorted: categories)
        let controller = SortedListController<CategoryTableView>(sections: sections)
        controller.delegate = tableView
        let category = ContentBuilder.makeCategory(name: String(2))
        let item = Item(value: 1, category: category)
        controller.remove(row: item)
        XCTAssertNotNil(tableView.removedRow)
        XCTAssertEqual(tableView.removedRow, item)
        XCTAssertNotNil(tableView.position)
        XCTAssertEqual(tableView.position, IndexPath(row: 0, section: 1))
        XCTAssert(controller.sections[1].rows.count == 2)
    }
    
    func testInsertNewRows() {
        final class CategoryTableView: UITableView, SortedListControllerDelegate {
            typealias Section = Category
            var insertedRows: [Section.Row]?
            var indexPositions: Positions?
            func controller(_ controller: SortedListController<CategoryTableView>, didInsertSection section: Section, atIndex indexSet: IndexSet) {
                XCTFail()
            }
            func controller(_ controller: SortedListController<CategoryTableView>, didRemoveSection section: Section, atIndex indexSet: IndexSet) {
                XCTFail()
            }
            func controller(_ controller: SortedListController<CategoryTableView>, didInsertSections sections: [Section], atIndex indexSet: IndexSet) {
                XCTFail()
            }
            func controller(_ controller: SortedListController<CategoryTableView>, didInsertRow row: Section.Row, atIndex indexPath: IndexPath) {
                XCTFail()
            }
            func controller(_ controller: SortedListController<CategoryTableView>, didRemoveRow row: Section.Row, atIndex indexPath: IndexPath) {
                XCTFail()
            }
            func controller(_ controller: SortedListController<CategoryTableView>, didInsertRows rows: [Section.Row], atPositions positions: Positions) {
                insertedRows = rows
                indexPositions = positions
            }
        }
        let tableView = CategoryTableView()
        let categories = ContentBuilder.makeCategories(range: 1...3)
        let sections = SortedSet(sorted: categories)
        let controller = SortedListController<CategoryTableView>(sections: sections)
        controller.delegate = tableView
        let category = ContentBuilder.makeCategory(name: String(2))
        let items = ContentBuilder.makeItems(range: 4...6, for: category)
        controller.insert(rows: items)
        XCTAssertNotNil(tableView.insertedRows)
        XCTAssertEqual(tableView.insertedRows, items)
        XCTAssertNotNil(tableView.indexPositions)
        XCTAssert(tableView.indexPositions?.sections.count == 0)
        XCTAssert(tableView.indexPositions?.rows.count == 3)
        XCTAssertEqual(tableView.indexPositions?.rows[0], IndexPath(row: 3, section: 1))
        XCTAssertEqual(tableView.indexPositions?.rows[1], IndexPath(row: 4, section: 1))
        XCTAssertEqual(tableView.indexPositions?.rows[2], IndexPath(row: 5, section: 1))
        XCTAssert(controller.sections[1].rows.count == 6)
    }
    
    func testInsertExistingRows() {
        final class CategoryTableView: UITableView, SortedListControllerDelegate {
            typealias Section = Category
            var insertedRows: [Section.Row]?
            var indexPositions: Positions?
            func controller(_ controller: SortedListController<CategoryTableView>, didInsertSection section: Section, atIndex indexSet: IndexSet) {
                XCTFail()
            }
            func controller(_ controller: SortedListController<CategoryTableView>, didRemoveSection section: Section, atIndex indexSet: IndexSet) {
                XCTFail()
            }
            func controller(_ controller: SortedListController<CategoryTableView>, didInsertSections sections: [Section], atIndex indexSet: IndexSet) {
                XCTFail()
            }
            func controller(_ controller: SortedListController<CategoryTableView>, didInsertRow row: Section.Row, atIndex indexPath: IndexPath) {
                XCTFail()
            }
            func controller(_ controller: SortedListController<CategoryTableView>, didRemoveRow row: Section.Row, atIndex indexPath: IndexPath) {
                XCTFail()
            }
            func controller(_ controller: SortedListController<CategoryTableView>, didInsertRows rows: [Section.Row], atPositions positions: Positions) {
                insertedRows = rows
                indexPositions = positions
            }
        }
        let tableView = CategoryTableView()
        let categories = ContentBuilder.makeCategories(range: 1...3)
        let sections = SortedSet(sorted: categories)
        let controller = SortedListController<CategoryTableView>(sections: sections)
        controller.delegate = tableView
        let category = ContentBuilder.makeCategory(name: String(2))
        let items = ContentBuilder.makeItems(range: 1...2, for: category)
        controller.insert(rows: items)
        XCTAssertNil(tableView.insertedRows)
        XCTAssertNil(tableView.indexPositions)
        XCTAssert(controller.sections[1].rows.count == 3)
    }
    
    func testRemoveNewRows() {
        final class CategoryTableView: UITableView, SortedListControllerDelegate {
            typealias Section = Category
            var removedRows: [Section.Row]?
            var indexPositions: Positions?
            func controller(_ controller: SortedListController<CategoryTableView>, didInsertSection section: Section, atIndex indexSet: IndexSet) {
                XCTFail()
            }
            func controller(_ controller: SortedListController<CategoryTableView>, didRemoveSection section: Section, atIndex indexSet: IndexSet) {
                XCTFail()
            }
            func controller(_ controller: SortedListController<CategoryTableView>, didInsertSections sections: [Section], atIndex indexSet: IndexSet) {
                XCTFail()
            }
            func controller(_ controller: SortedListController<CategoryTableView>, didInsertRow row: Section.Row, atIndex indexPath: IndexPath) {
                XCTFail()
            }
            func controller(_ controller: SortedListController<CategoryTableView>, didRemoveRow row: Section.Row, atIndex indexPath: IndexPath) {
                XCTFail()
            }
            func controller(_ controller: SortedListController<CategoryTableView>, didInsertRows rows: [Section.Row], atPositions positions: Positions) {
                XCTFail()
            }
            func controller(_ controller: SortedListController<CategoryTableView>, didRemoveRows rows: [Section.Row], atPositions positions: Positions) {
                removedRows = rows
                indexPositions = positions
            }
        }
        let tableView = CategoryTableView()
        let categories = ContentBuilder.makeCategories(range: 1...3)
        let sections = SortedSet(sorted: categories)
        let controller = SortedListController<CategoryTableView>(sections: sections)
        controller.delegate = tableView
        let category = ContentBuilder.makeCategory(name: String(2))
        let items = ContentBuilder.makeItems(range: 4...6, for: category)
        controller.remove(rows: items)
        XCTAssertNil(tableView.removedRows)
        XCTAssertNil(tableView.indexPositions)
        XCTAssert(controller.sections[1].rows.count == 3)
    }
    
    func testRemoveExistingRowsButNotAllInSection() {
        final class CategoryTableView: UITableView, SortedListControllerDelegate {
            typealias Section = Category
            var removedRows: [Section.Row]?
            var indexPositions: Positions?
            func controller(_ controller: SortedListController<CategoryTableView>, didInsertSection section: Section, atIndex indexSet: IndexSet) {
                XCTFail()
            }
            func controller(_ controller: SortedListController<CategoryTableView>, didRemoveSection section: Section, atIndex indexSet: IndexSet) {
                XCTFail()
            }
            func controller(_ controller: SortedListController<CategoryTableView>, didInsertSections sections: [Section], atIndex indexSet: IndexSet) {
                XCTFail()
            }
            func controller(_ controller: SortedListController<CategoryTableView>, didInsertRow row: Section.Row, atIndex indexPath: IndexPath) {
                XCTFail()
            }
            func controller(_ controller: SortedListController<CategoryTableView>, didRemoveRow row: Section.Row, atIndex indexPath: IndexPath) {
                XCTFail()
            }
            func controller(_ controller: SortedListController<CategoryTableView>, didInsertRows rows: [Section.Row], atPositions positions: Positions) {
                XCTFail()
            }
            func controller(_ controller: SortedListController<CategoryTableView>, didRemoveRows rows: [Section.Row], atPositions positions: Positions) {
                removedRows = rows
                indexPositions = positions
            }
        }
        let tableView = CategoryTableView()
        let categories = ContentBuilder.makeCategories(range: 1...3)
        let sections = SortedSet(sorted: categories)
        let controller = SortedListController<CategoryTableView>(sections: sections)
        controller.delegate = tableView
        let category = ContentBuilder.makeCategory(name: String(2))
        let items = ContentBuilder.makeItems(range: 1...2, for: category)
        controller.remove(rows: items)
        XCTAssertNotNil(tableView.removedRows)
        XCTAssertEqual(tableView.removedRows, items)
        XCTAssertNotNil(tableView.indexPositions)
        XCTAssert(tableView.indexPositions?.sections.count == 0)
        XCTAssert(tableView.indexPositions?.rows.count == 2)
        XCTAssertEqual(tableView.indexPositions?.rows[0], IndexPath(row: 0, section: 1))
        XCTAssertEqual(tableView.indexPositions?.rows[1], IndexPath(row: 1, section: 1))
        XCTAssert(controller.sections[1].rows.count == 1)
    }
    
    func testRemoveAllExistingRowsInASection() {
        final class CategoryTableView: UITableView, SortedListControllerDelegate {
            typealias Section = Category
            var removedRows: [Section.Row]?
            var indexPositions: Positions?
            func controller(_ controller: SortedListController<CategoryTableView>, didInsertSection section: Section, atIndex indexSet: IndexSet) {
                XCTFail()
            }
            func controller(_ controller: SortedListController<CategoryTableView>, didRemoveSection section: Section, atIndex indexSet: IndexSet) {
                XCTFail()
            }
            func controller(_ controller: SortedListController<CategoryTableView>, didInsertSections sections: [Section], atIndex indexSet: IndexSet) {
                XCTFail()
            }
            func controller(_ controller: SortedListController<CategoryTableView>, didInsertRow row: Section.Row, atIndex indexPath: IndexPath) {
                XCTFail()
            }
            func controller(_ controller: SortedListController<CategoryTableView>, didRemoveRow row: Section.Row, atIndex indexPath: IndexPath) {
                XCTFail()
            }
            func controller(_ controller: SortedListController<CategoryTableView>, didInsertRows rows: [Section.Row], atPositions positions: Positions) {
                XCTFail()
            }
            func controller(_ controller: SortedListController<CategoryTableView>, didRemoveRows rows: [Section.Row], atPositions positions: Positions) {
                removedRows = rows
                indexPositions = positions
            }
        }
        let tableView = CategoryTableView()
        let categories = ContentBuilder.makeCategories(range: 1...3)
        let sections = SortedSet(sorted: categories)
        let controller = SortedListController<CategoryTableView>(sections: sections)
        controller.delegate = tableView
        let category = ContentBuilder.makeCategory(name: String(2))
        let items = ContentBuilder.makeItems(range: 1...3, for: category)
        controller.remove(rows: items)
        XCTAssertNotNil(tableView.removedRows)
        XCTAssertEqual(tableView.removedRows, items)
        XCTAssertNotNil(tableView.indexPositions)
        XCTAssert(tableView.indexPositions?.sections.count == 1)
        XCTAssert(tableView.indexPositions?.rows.count == 0)
    }
}
