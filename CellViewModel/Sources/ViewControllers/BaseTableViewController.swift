//
//  BaseTableViewController.swift
//  CellViewModel
//
//  Created by Anton Poltoratskyi on 09.05.2019.
//  Copyright © 2019 Anton Poltoratskyi. All rights reserved.
//

import UIKit

open class BaseTableViewController: UIViewController, UITableViewDelegate {
    
    private(set) open lazy var adapter = TableViewDataAdapter(tableView: self._tableView, inferModelTypes: self.automaticallyInferCellViewModelTypes)
    
    open var automaticallyInferCellViewModelTypes: Bool {
        return false
    }
    
    open var viewModels: [AnyCellViewModel.Type] {
        // must be implemented in subclasses
        return []
    }
    
    // MARK: - Views
    
    // must be set in subclasses
    open var _tableView: UITableView!
    
    // MARK: - Life Cycle
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    // MARK: - UI Setup
    
    open func setupUI() {
        _tableView.register(viewModels)
    }
    
    // MARK: - View Input
    
    open func setup(_ sections: [Section]) {
        adapter.data = sections
    }
    
    // MARK: - Table View Delegate
    
    open func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let item = adapter.itemModel(at: indexPath) as? InteractiveCellViewModel else {
            return
        }
        item.selectionHandler?()
    }
    
    open func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return adapter.itemModel(at: indexPath).height(constrainedBy: tableView.bounds.width) ?? tableView.rowHeight
    }
}
