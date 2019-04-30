//
//  CollectionViewDataAdapter.swift
//  CellViewModel
//
//  Created by Anton Poltoratskyi on 02.02.2019.
//  Copyright © 2019 Anton Poltoratskyi. All rights reserved.
//

import UIKit

open class CollectionViewDataAdapter<T>: NSObject, UICollectionViewDataSource {
    
    public typealias DataProvider = (CollectionViewDataAdapter<T>, IndexPath) -> AnyCellViewModel
    
    open var data: [T] = [] {
        didSet {
            collectionView?.reloadData()
        }
    }
    
    private let dataProvider: DataProvider
    
    private weak var collectionView: UICollectionView?
    
    public init(collectionView: UICollectionView, dataProvider: @escaping DataProvider) {
        self.collectionView = collectionView
        self.dataProvider = dataProvider
        super.init()
        collectionView.dataSource = self
    }
    
    open func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    
    open func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return collectionView.dequeueReusableCell(with: itemModel(at: indexPath), for: indexPath)
    }
    
    open func itemModel(at indexPath: IndexPath) -> AnyCellViewModel {
        return dataProvider(self, indexPath)
    }
}

extension CollectionViewDataAdapter where T == AnyCellViewModel {
    
    public convenience init(collectionView: UICollectionView) {
        self.init(collectionView: collectionView) { dataSource, indexPath in
            dataSource.data[indexPath.row]
        }
    }
}

extension CollectionViewDataAdapter where T: AnyCellViewModel {
    
    public convenience init(collectionView: UICollectionView) {
        self.init(collectionView: collectionView) { dataSource, indexPath in
            dataSource.data[indexPath.row]
        }
    }
}
