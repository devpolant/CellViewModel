//
//  UICollectionView+ListDiff.swift
//  CellViewModel
//
//  Created by Anton Poltoratskyi on 14.04.2019.
//  Copyright © 2019 Anton Poltoratskyi. All rights reserved.
//

import UIKit

extension UICollectionView {
    
    public func performUpdate(animated: Bool, updates: (() -> Void)?, completion: ((Bool) -> Void)? = nil) {
        func applyUpdates() {
            performBatchUpdates(updates, completion: completion)
        }
        if animated {
            applyUpdates()
        } else {
            UIView.performWithoutAnimation(applyUpdates)
        }
    }
    
    public func apply(_ diff: DiffResult, section: Int = 0) {
        if !diff.deletes.isEmpty {
            deleteItems(
                at: diff.deletes.map {
                    IndexPath(item: $0, section: section)
                }
            )
        }
        if !diff.inserts.isEmpty {
            insertItems(
                at: diff.inserts.map {
                    IndexPath(item: $0, section: section)
                }
            )
        }
        for move in diff.moves {
            moveItem(
                at: IndexPath(item: move.from, section: section),
                to: IndexPath(item: move.to, section: section)
            )
        }
    }
}
