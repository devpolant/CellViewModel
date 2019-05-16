//
//  LazyTableViewDataAdapter.swift
//  CellViewModel
//
//  Created by Anton Poltoratskyi on 09.05.2019.
//  Copyright © 2019 Anton Poltoratskyi. All rights reserved.
//

import UIKit

open class LazyTableViewDataAdapter<T>: NSObject, UITableViewDataSource {
    
    public typealias DataProvider = (LazyTableViewDataAdapter<T>, IndexPath) -> AnyCellViewModel
    
    open var data: [T] = [] {
        didSet {
            if automaticallyReloadData {
                tableView?.reloadData()
            }
        }
    }
    
    private let dataProvider: DataProvider
    
    private let automaticallyReloadData: Bool
    
    private weak var tableView: UITableView?
    
    public init(tableView: UITableView, automaticallyReloadData: Bool = true, dataProvider: @escaping DataProvider) {
        self.tableView = tableView
        self.dataProvider = dataProvider
        self.automaticallyReloadData = automaticallyReloadData
        super.init()
        tableView.dataSource = self
    }
    
    open func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    open func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return tableView.dequeueReusableCell(with: itemModel(at: indexPath), for: indexPath)
    }
    
    open func itemModel(at indexPath: IndexPath) -> AnyCellViewModel {
        return dataProvider(self, indexPath)
    }
}

extension LazyTableViewDataAdapter where T == AnyCellViewModel {
    
    public convenience init(tableView: UITableView) {
        self.init(tableView: tableView) { dataSource, indexPath in
            dataSource.data[indexPath.row]
        }
    }
}

extension LazyTableViewDataAdapter where T: AnyCellViewModel {
    
    public convenience init(tableView: UITableView) {
        self.init(tableView: tableView) { dataSource, indexPath in
            dataSource.data[indexPath.row]
        }
    }
}
