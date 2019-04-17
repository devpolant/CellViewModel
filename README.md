[![Swift](https://img.shields.io/badge/Swift-4.2-orange.svg)](https://swift.org)
[![Xcode](https://img.shields.io/badge/Xcode-10.0-blue.svg)](https://developer.apple.com/xcode)
[![MIT](https://img.shields.io/badge/License-MIT-red.svg)](https://opensource.org/licenses/MIT)
[![CocoaPods Compatible](https://img.shields.io/cocoapods/v/CellViewModel.svg)](https://cocoapods.org/pods/CellViewModel)

# CellViewModel

Using CellViewModel to configure you UITableViewCell or UICollectionViewCell is just a one possible approach of work with UIKit's collections.

## Requirements:
- iOS 10.0+
- Xcode 10.0+
- Swift 4.2+

## Installation

#### CocoaPods

```ruby
target 'MyApp' do
  pod 'CellViewModel', '~> 1.3'
end
```

#### Carthage

```ogdl
github "AntonPoltoratskyi/CellViewModel" "master"
```

## Usage

**Works with UITableView & UICollectionView** - one possible approach, inspired by **CocoaHeads**:

You can move configuration logic for **UITableViewCell** or **UICollectionViewCell** from **-cellForRowAtIndexPath:** to separate types.

1) You need to create cell class and appropriate type that conforms to **CellViewModel** type:

```Swift
public typealias AnyViewCell = UIView

public protocol CellViewModel: AnyCellViewModel {
    associatedtype Cell: AnyViewCell
    func setup(cell: Cell)
}
```

> **UserTableViewCell.swift**

```Swift
import CellViewModel

// MARK: - View Model

struct UserCellModel: CellViewModel {
    var user: User
    
    func setup(cell: UserTableViewCell) {
        cell.nameLabel.text = user.name
    }
}

// MARK: - Cell

final class UserTableViewCell: UITableViewCell, XibInitializable {
    @IBOutlet weak var nameLabel: UILabel!
}
```

2) After that you need to register created model type:

There are 2 options:
- use `register(nibModel:)` if appropriate `CellViewModel`'s `Cell` conforms to `XibInitializable`:
```Swift
tableView.register(nibModel: UserCellModel.self)
```

- otherwise use `register(viewModel:)`:
```Swift
tableView.register(viewModel: UserCellModel.self)
```

3) Then store your models in array (or your custom datasource type):

```Swift
private var users: [AnyCellViewModel] = []
```

**AnyCellViewModel** is a base protocol of **CellViewModel**. 
It's needed only in order to fix compiler limitation as **you can use protocols with associatedtype only as generic constraints** and can't write something like this:

```Swift
private var users: [CellViewModel] = [] // won't compile
```

4) **UITableViewDataSource** implementation is very easy, even if you have multiple cell types, because all logic are contained in our view models:

```Swift
import CellViewModel

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    private var users: [AnyCellViewModel] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        users = User.testDataSource.map { UserCellModel(user: $0) }
        tableView.register(nibModel: UserCellModel.self)
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return tableView.dequeueReusableCell(withModel: tableModel(at: indexPath), for: indexPath)
    }
    
    private func tableModel(at indexPath: IndexPath) -> AnyCellViewModel {
        return users[indexPath.row]
    }
}
```

5) Or use **TableViewDataAdapter**:

```swift
private lazy var adapter = TableViewDataAdapter(tableView: self.tableView)
```

assign it as UITableView's dataSource:

```swift
override func viewDidLoad() {
    super.viewDidLoad()
    self.tableView.dataSource = adapter
}
```

updating `data` property will cause `reloadData()`

```swift
func setup(users: [AnyCellViewModel]) {
    adapter.data = users
}
```


### Accessibility

Sometimes there is a need to define `accessibilityIdentifier` for UI testing purposes.

There is [Accessible](https://github.com/AntonPoltoratskyi/CellViewModel/blob/master/CellViewModel/Sources/ViewModels/Accessibility/Accessible.swift) protocol that is conformed by CellViewModel protocol.

```swift
public protocol Accessible {
    var accessibilityIdentifier: String? { get }
    var accessibilityOptions: AccessibilityDisplayOptions { get }
}
```

So you need to define `accessibilityIdentifier` property in your model type implementation:

```swift
struct UserCellModel: CellViewModel {

    var accessibilityIdentifier: String? {
        return "user_cell"
    }

    // ...
}
```

And define `accessibilityOptions` if needed to add index path as suffix in the end of `accessibilityIdentifier`:

```swift
struct UserCellModel: CellViewModel {

    var accessibilityIdentifier: String? {
        return "user_cell"
    }
    
    var accessibilityOptions: AccessibilityDisplayOptions {
        return [.row, .section]
    }

    // ...
}
```

## License

**CellViewModel** is available under the MIT license. See the [LICENSE](https://github.com/AntonPoltoratskyi/CellViewModel/blob/master/LICENSE) file for more info.
