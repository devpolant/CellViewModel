//
//  LazyCollectionViewDataAdapter.swift
//  CellViewModel
//
//  Created by Anton Poltoratskyi on 02.02.2019.
//  Copyright © 2019 Anton Poltoratskyi. All rights reserved.
//

import UIKit

open class LazyCollectionViewDataAdapter<T>: NSObject, UICollectionViewDataSource {
    
    public typealias DataProvider = (LazyCollectionViewDataAdapter<T>, IndexPath) -> AnyCellViewModel
    
    open var data: [T] = [] {
        didSet {
            if automaticallyReloadData {            
                collectionView?.reloadData()
            }
        }
    }
    
    private let dataProvider: DataProvider
    
    private let automaticallyReloadData: Bool
    
    private weak var collectionView: UICollectionView?
    
    public init(collectionView: UICollectionView, automaticallyReloadData: Bool = true, dataProvider: @escaping DataProvider) {
        self.collectionView = collectionView
        self.dataProvider = dataProvider
        self.automaticallyReloadData = automaticallyReloadData
        super.init()
        collectionView.dataSource = self
    }
    
    open func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard data.indices.contains(section) else {
            return 0
        }
        return data.count
    }
    
    open func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return collectionView.dequeueReusableCell(with: itemModel(at: indexPath), for: indexPath)
    }
    
    open func itemModel(at indexPath: IndexPath) -> AnyCellViewModel {
        return dataProvider(self, indexPath)
    }
}

extension LazyCollectionViewDataAdapter where T == AnyCellViewModel {
    
    public convenience init(collectionView: UICollectionView) {
        self.init(collectionView: collectionView) { dataSource, indexPath in
            dataSource.data[indexPath.row]
        }
    }
}

extension LazyCollectionViewDataAdapter where T: AnyCellViewModel {
    
    public convenience init(collectionView: UICollectionView) {
        self.init(collectionView: collectionView) { dataSource, indexPath in
            dataSource.data[indexPath.row]
        }
    }
}
