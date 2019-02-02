//
//  GroupedCollectionViewDataAdapter.swift
//  CellViewModel
//
//  Created by Anton Poltoratskyi on 02.02.2019.
//  Copyright © 2019 Anton Poltoratskyi. All rights reserved.
//

import UIKit

open class GroupCollectionViewDataAdapter: NSObject, UICollectionViewDataSource {
    
    open var data: [Section] = [] {
        didSet {
            collectionView?.reloadData()
        }
    }
    
    private weak var collectionView: UICollectionView?
    
    public init(collectionView: UICollectionView) {
        self.collectionView = collectionView
        super.init()
    }
    
    public func numberOfSections(in collectionView: UICollectionView) -> Int {
        return data.count
    }
    
    open func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data[section].items.count
    }
    
    open func collectionView(_ collectionView: UICollectionView,
                             viewForSupplementaryElementOfKind kind: String,
                             at indexPath: IndexPath) -> UICollectionReusableView {
        guard let model = supplementaryModel(ofKind: kind, at: indexPath) else {
            fatalError("supplementary model = nil, at indexPath = \(indexPath)")
        }
        return collectionView.dequeueReusableSupplementaryView(withModel: model, for: indexPath)
    }
    
    open func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return collectionView.dequeueReusableCell(withModel: itemModel(at: indexPath), for: indexPath)
    }
    
    open func supplementaryModel(ofKind kind: String, at indexPath: IndexPath) -> AnySupplementaryViewModel? {
        let section = data[indexPath.section]
        
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            return section.header
        case UICollectionView.elementKindSectionFooter:
            return section.footer
        default:
            return nil
        }
    }
    
    open func supplementaryModel(ofKind kind: String, in section: Int) -> AnySupplementaryViewModel? {
        let indexPath = IndexPath(item: 0, section: section)
        return supplementaryModel(ofKind: kind, at: indexPath)
    }
    
    open func itemModel(at indexPath: IndexPath) -> AnyCellViewModel {
        return data[indexPath.section].items[indexPath.item]
    }
}
