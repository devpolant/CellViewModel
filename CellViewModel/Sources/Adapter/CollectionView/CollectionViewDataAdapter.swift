//
//  GroupedCollectionViewDataAdapter.swift
//  CellViewModel
//
//  Created by Anton Poltoratskyi on 02.02.2019.
//  Copyright © 2019 Anton Poltoratskyi. All rights reserved.
//

import UIKit

open class CollectionViewDataAdapter: NSObject, UICollectionViewDataSource {
    
    open var data: [Section] = [] {
        didSet {
            if inferModelTypes {
                register(data)
            }
            if automaticallyReloadData {
                collectionView?.reloadData()
            }
        }
    }
    
    private weak var collectionView: UICollectionView?
    
    private let inferModelTypes: Bool
    
    private let automaticallyReloadData: Bool
    
    public init(collectionView: UICollectionView, inferModelTypes: Bool = false, automaticallyReloadData: Bool = true) {
        self.collectionView = collectionView
        self.inferModelTypes = inferModelTypes
        self.automaticallyReloadData = automaticallyReloadData
        super.init()
        collectionView.dataSource = self
    }
    
    // MARK: - UICollectionViewDataSource
    
    open func numberOfSections(in collectionView: UICollectionView) -> Int {
        return data.count
    }
    
    open func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard contains(section: section) else {
            return 0
        }
        return data[section].items.count
    }
    
    open func collectionView(_ collectionView: UICollectionView,
                             viewForSupplementaryElementOfKind kind: String,
                             at indexPath: IndexPath) -> UICollectionReusableView {
        guard let model = supplementaryModel(ofKind: kind, at: indexPath) else {
            fatalError("supplementary model = nil, at indexPath = \(indexPath)")
        }
        return collectionView.dequeueReusableSupplementaryView(with: model, for: indexPath)
    }
    
    open func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return collectionView.dequeueReusableCell(with: itemModel(at: indexPath), for: indexPath)
    }
    
    // MARK: - Adapter
    
    open func sectionModel(at index: Int) -> Section {
        return data[index]
    }
    
    open func supplementaryModel(ofKind kind: String, at indexPath: IndexPath) -> AnySupplementaryViewModel? {
        let section = data[indexPath.section]
        
        switch kind {
        case collectionSectionHeaderType:
            return section.header
        case collectionSectionFooterType:
            return section.footer
        default:
            return nil
        }
    }
    
    open func supplementaryModel(ofKind kind: String, in section: Int) -> AnySupplementaryViewModel? {
        let indexPath = IndexPath(item: 0, section: section)
        return supplementaryModel(ofKind: kind, at: indexPath)
    }
    
    open func headerModel(in section: Int) -> AnySupplementaryViewModel? {
        let indexPath = IndexPath(item: 0, section: section)
        return supplementaryModel(ofKind: collectionSectionHeaderType, at: indexPath)
    }
    
    open func footerModel(in section: Int) -> AnySupplementaryViewModel? {
        let indexPath = IndexPath(item: 0, section: section)
        return supplementaryModel(ofKind: collectionSectionFooterType, at: indexPath)
    }
    
    open func itemModel(at indexPath: IndexPath) -> AnyCellViewModel {
        return data[indexPath.section].items[indexPath.item]
    }
    
    open func containsModel(at indexPath: IndexPath) -> Bool {
        return contains(section: indexPath.section) && data[indexPath.section].items.indices.contains(indexPath.item)
    }
    
    open func contains(section: Int) -> Bool {
        return data.indices.contains(section)
    }
    
    // MARK: - Type Registration
    
    private func register(_ data: [Section]) {
        for section in data {
            if let header = section.header {
                collectionView?.register(type(of: header))
            }
            if let footer = section.footer {
                collectionView?.register(type(of: footer))
            }
            for item in section.items {
                collectionView?.register(type(of: item))
            }
        }
    }
}
