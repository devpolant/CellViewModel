[![Swift](https://img.shields.io/badge/Swift-4.2-orange.svg)](https://swift.org)
[![Xcode](https://img.shields.io/badge/Xcode-10.0-blue.svg)](https://developer.apple.com/xcode)
[![MIT](https://img.shields.io/badge/License-MIT-red.svg)](https://opensource.org/licenses/MIT)
[![CocoaPods Compatible](https://img.shields.io/cocoapods/v/CellViewModel.svg)](https://cocoapods.org/pods/CellViewModel)

# CellViewModel

Using CellViewModel to configure you UITableViewCell or UICollectionViewCell is just a one possible approach of work with UIKit's collections.

## Requirements:
- iOS 9.0+
- Xcode 10.0+
- Swift 4.2+

## Installation

#### CocoaPods

```ruby
target 'MyApp' do
  pod 'CellViewModel', '~> 1.7.5'
end
```

#### Carthage

```ogdl
github "AntonPoltoratskyi/CellViewModel" "master"
```

## Usage

**Works with UITableView & UICollectionView** - one possible approach, inspired by **CocoaHeads**:

You can move configuration logic for **UITableViewCell** or **UICollectionViewCell** from **-cellForRowAtIndexPath:** to separate types.

### Native setup

1) Create cell class and appropriate type that conforms to **CellViewModel** type:

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

2) Register created model type:
```Swift
tableView.register(UserCellModel.self)
```

By registering model type it will be checked if cell class conforms to XibInitializable or not in order to register `UINib` or just cell's class type.

3) Then store your models in array (or your custom datasource type):

```Swift
private var users: [AnyCellViewModel] = []
```

**AnyCellViewModel** is a base protocol of **CellViewModel**. 
It's needed only in order to fix compiler limitation as **you can use protocols with associatedtype only as generic constraints** and can't write something like this:

```Swift
private var users: [CellViewModel] = [] // won't compile
```

4) **UITableViewDataSource** implementation is very easy, even if you have multiple cell types, because all 'cellForRow' logic is contained in our view models:

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
        return tableView.dequeueReusableCell(with: tableModel(at: indexPath), for: indexPath)
    }
    
    private func tableModel(at indexPath: IndexPath) -> AnyCellViewModel {
        return users[indexPath.row]
    }
}
```

### Quick Setup

Use existed adapters in order to perform quick setup. 

1. For `UITableView` - **TableViewDataAdapter**

```swift
private lazy var adapter = TableViewDataAdapter(tableView: self.tableView)

// ...

func setup(users: [AnyCellViewModel]) {
    adapter.data = users
}
```

Updating `data` property will call `reloadData()`.

2. For `UICollectionView` - **CollectionViewDataAdapter**:

```swift
private lazy var adapter = CollectionViewDataAdapter(tableView: self.collectionView)

// ...

func setup(users: [AnyCellViewModel]) {
    adapter.data = users
}
```

Both adapters already conform to appropriate datasource protocol: `UICollectionViewDataSource` and `UITableViewDataSource`.

### Base View Controller

The most simplier way to set up is to inherit from `BaseCollectionViewController`.

Sometimes you need a table UI, but with some unique section insets or interitem spacing. For this case `BaseCollectionViewController` provides default implementation of `UICollectionViewDelegateFlowLayout` protocol to match the  table UI for you.

#### Usage

```swift

final class UsersViewController: BaseCollectionViewController {

    @IBOutlet weak var collectionView: UICollectionView {
        didSet {
            // initialize reference in base class
            _collectionView = collectionView
        }
    }
    
    override var viewModels: [AnyCellViewModel.Type] {
        return [
            UserCellModel.self,
            // ... add more
        ]
    }
    
    override var supplementaryModels: [AnySupplementaryViewModel.Type] {
        return [
            UserHeaderModel.self,
            /// ... add more
        ]
    }
    
    // ... your domain code
```

`BaseCollectionViewController` is a wrapper for `CollectionViewDataAdapter`, so it is already have setup method:

```swift
    open func setup(_ sections: [Section]) {
        adapter.data = sections
    }
```

`Section` type is a container for header, footer, items models and layout information like spacings etc.

```swift
public final class Section {
    
    public var insets: UIEdgeInsets?
    public var lineSpacing: CGFloat?
    public var header: AnySupplementaryViewModel?
    public var footer: AnySupplementaryViewModel?
    public var items: [AnyCellViewModel]
    
    /// ...
}
```

Override `automaticallyInferCellViewModelTypes` in order to allow to automatically infer type of used view models instead of explicitly declare them in `viewModels` and `supplementaryModels` properties.

```swift
override var automaticallyInferCellViewModelTypes: Bool {
    return true
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
