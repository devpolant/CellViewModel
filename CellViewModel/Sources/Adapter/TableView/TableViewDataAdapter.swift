//
//  TableViewDataAdapter.swift
//  CellViewModel
//
//  Created by Anton Poltoratskyi on 02.02.2019.
//  Copyright © 2019 Anton Poltoratskyi. All rights reserved.
//

import UIKit

open class TableViewDataAdapter: NSObject, UITableViewDataSource {
    
    open var data: [Section] = [] {
        didSet {
            if inferModelTypes {
                register(data)
            }
            if automaticallyReloadData {
                tableView?.reloadData()
            }
        }
    }
    
    private weak var tableView: UITableView?
    
    private let inferModelTypes: Bool
    
    private let automaticallyReloadData: Bool
    
    public init(tableView: UITableView, inferModelTypes: Bool = false, automaticallyReloadData: Bool = true) {
        self.tableView = tableView
        self.inferModelTypes = inferModelTypes
        self.automaticallyReloadData = automaticallyReloadData
        super.init()
        tableView.dataSource = self
    }
    
    // MARK: - UICollectionViewDataSource
    
    open func numberOfSections(in tableView: UITableView) -> Int {
        return data.count
    }
    
    open func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data[section].items.count
    }
    
    open func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return tableView.dequeueReusableCell(with: itemModel(at: indexPath), for: indexPath)
    }
    
    // MARK: - Adapter
    
    open func sectionModel(at index: Int) -> Section {
        return data[index]
    }
    
    open func itemModel(at indexPath: IndexPath) -> AnyCellViewModel {
        return data[indexPath.section].items[indexPath.item]
    }
    
    // MARK: - Type Registration
    
    private func register(_ data: [Section]) {
        for section in data {
            if let header = section.header {
                tableView?.register(type(of: header))
            }
            if let footer = section.footer {
                tableView?.register(type(of: footer))
            }
            for item in section.items {
                tableView?.register(type(of: item))
            }
        }
    }
}
