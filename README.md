<p align="center">
    <img src="Logo.png" width="480" max-width="90%" alt="Inbound" />
</p>

<p align="center">
    <a href="https://app.bitrise.io/app/9bdab7792cb297b7">
        <img src="https://app.bitrise.io/app/9bdab7792cb297b7/status.svg?token=yCTYlgBCizaQWaVBcMoaGA" alt="Bitrise"/>
    </a>
    <a href="https://img.shields.io/badge/carthage-compatible-brightgreen.svg">
        <img src="https://img.shields.io/badge/carthage-compatible-brightgreen.svg" alt="Carthage"/>
    </a>
    <a href="https://swift.org/blog/swift-5-released/">
        <img src="https://img.shields.io/badge/swift-5.0-orange.svg" alt="Swift"/>
    </a>
</p>

<p align="center">
    <a href="https://developer.apple.com/documentation/uikit/uitableview">
        <img src="https://user-images.githubusercontent.com/51816980/60034673-1785ef80-96a3-11e9-90b1-d370527fcd36.gif" alt="Preview"/>
    </a>
</p>

## Usage

If a `Category` represents a table view section and an `Item` represents a row within a category, then the following is how you would create a section named `1` that has 3 rows, named `1`, `2` and `3` respectively.


```swift
let section = Category(name: String(1))
let rows = (1...3).map {
    Item(name: String($0), category: category)
}
section.rows = SortedSet(sorted: rows) // we know they are already sorted (otherwise use SortedSet(unsorted:))
tableController.insert(section: section) // immediately updates UI here. see below about settings up a SortedListController
```

> Additional data added to your `tableController` will update the UI automatically, but only if the data is unique (as defined by your `Hashable` implementation). If the data is not unique, it is discarded. See [demo model](#demo-model) below.

### SortedListController

```swift
final class ViewController: UIViewController, UITableViewDataSource {

    private let tableController = SortedListController<FooTableView>()
    private let tableView = FooTableView()

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableController.delegate = tableView
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return tableController.sections.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableController.sections[section].rows.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let row = tableController.sections[indexPath.section].rows[indexPath.row]
        ...
        etc
    }
}
```

> Don't insert or remove a single section or row in a for loop as UIKit will get upset. Instead use `insert(rows:)` or `remove(rows:)` etc.

### SortedListControllerDelegate

The `SortedListControllerDelegate` protocol only needs to know the type that represents any given section.

```swift
extension FooTableView: SortedListControllerDelegate {
    typealias Section = Category
}
```

### Demo Model

```swift
// represents a table view section
final class Category: ListSection {
    
    let name: String
    
    // represents the rows in this section
    var items = SortedSet<Item>()
    
    init(name: String) {
        self.name = name
    }

    static func ==(lhs: Category, rhs: Category) -> Bool {
        return lhs.name == rhs.name
    }
    
    static func <(lhs: Category, rhs: Category) -> Bool {
        return lhs.name.compare(rhs.name) == .orderedAscending
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(name)
    }
}

// represents a table view row
final class Item: ListRow {
    
    let name: String
    
    // the section this row belongs to
    unowned let category: Category
    
    init(name: String, category: Category) {
        self.name = name
        self.category = category
    }

    static func ==(lhs: Item, rhs: Item) -> Bool {
        return lhs.name == rhs.name
    }
    
    static func <(lhs: Item, rhs: Item) -> Bool {
        return lhs.name.compare(rhs.name) == .orderedAscending
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(name)
    }
}
```
> The ordering of your data is defined by your `Comparable` implementation.

## Installation

1. Fetch with [Carthage](https://github.com/Carthage/Carthage).
2. Embedd the `Inbound` framework.
3. Embedd the [SortedSet](https://github.com/BowdusBrown/SortedSet) framework (downstream dependency).

## Demo

1. Bootstrap with [Carthage](https://github.com/Carthage/Carthage).
2. Run the Xcode scheme named `Demo`.
