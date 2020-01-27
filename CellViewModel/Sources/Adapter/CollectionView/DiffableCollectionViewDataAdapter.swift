//
//  DiffableCollectionViewDataAdapter.swift
//  CellViewModel
//
//  Created by Anton Poltoratskyi on 14.04.2019.
//  Copyright © 2019 Anton Poltoratskyi. All rights reserved.
//

import UIKit

open class DiffableCollectionViewDataAdapter: NSObject, UICollectionViewDataSource {
    
    public private(set) var data: [DiffableSection] = []
    
    private let differ: Differ = ListDiffer()
    
    private weak var collectionView: UICollectionView?
    
    private let inferModelTypes: Bool
    
    public init(collectionView: UICollectionView, inferModelTypes: Bool = false) {
        self.collectionView = collectionView
        self.inferModelTypes = inferModelTypes
        super.init()
        collectionView.dataSource = self
    }
    
    // MARK: - UICollectionViewDataSource
    
    open func numberOfSections(in collectionView: UICollectionView) -> Int {
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
        return collectionView.dequeueReusableSupplementaryView(with: model, for: indexPath)
    }
    
    open func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return collectionView.dequeueReusableCell(with: itemModel(at: indexPath), for: indexPath)
    }
    
    // MARK: - Adapter
    
    open func sectionModel(at index: Int) -> DiffableSection {
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
    
    open func contains(section: Int) -> Bool {
        return data.indices.contains(section)
    }
    
    open func containsModel(at indexPath: IndexPath) -> Bool {
        return contains(section: indexPath.section) && data[indexPath.section].items.indices.contains(indexPath.row)
    }
    
    open func update(data: [DiffableSection], animated: Bool) {
        collectionView?.performUpdate(animated: animated, updates: {
            self.update(data: data)
        })
    }
    
    // MARK: - Diffs
    
    private func update(data: [DiffableSection]) {
        defer { self.data = data }
        
        if inferModelTypes {
            register(data)
        }
        updateSections(with: data)
        
        guard self.data.count == data.count else {
            assertionFailure("Mistake in diff processing logic")
            return
        }
        updateItems(with: data)
    }
    
    private func updateSections(with data: [DiffableSection]) {
        let oldSectionIds = self.data.map { $0.identifier }
        let newSectionIds = data.map { $0.identifier }
        
        let sectionDiff = differ.diffBetween(old: oldSectionIds, new: newSectionIds)
        
        guard sectionDiff.hasChanges else {
            return
        }
        
        if !sectionDiff.deletes.isEmpty {
            for section in sectionDiff.deletes.reversed() {
                self.data.remove(at: section)
            }
            collectionView?.deleteSections(sectionDiff.deletes)
        }
        if !sectionDiff.inserts.isEmpty {
            for sectionIndex in sectionDiff.inserts {
                let section = data.first { section in
                    !self.data.contains { $0.identifier == section.identifier }
                }
                if let section = section {
                    self.data.insert(section, at: sectionIndex)
                } else {
                    assertionFailure("Mistake in diff processing logic")
                }
            }
            collectionView?.insertSections(sectionDiff.inserts)
        }
        
        for move in sectionDiff.moves {
            self.data.move(at: move.from, to: move.to)
            collectionView?.moveSection(move.from, toSection: move.to)
        }
    }
    
    private func updateItems(with data: [DiffableSection]) {
        var section: Int = 0
        for (old, new) in zip(self.data, data) {
            defer { section += 1 }
            
            let diff = differ.diffBetween(old: old.items.map { EquatableItem($0) },
                                          new: new.items.map { EquatableItem($0) })
            
            collectionView?.apply(diff, section: section)
        }
    }
    
    // MARK: - Type Registration
    
    private func register(_ data: [DiffableSection]) {
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

private final class EquatableItem: Diffable, Equatable {
    
    private let model: DiffableCellViewModel
    
    init(_ model: DiffableCellViewModel) {
        self.model = model
    }
    
    static func == (lhs: EquatableItem, rhs: EquatableItem) -> Bool {
        return lhs.model.isEqual(to: rhs.model)
    }
    
    var diffIdentifier: AnyHashable {
        return model.diffIdentifier
    }
}
