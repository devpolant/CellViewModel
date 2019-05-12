//
//  DiffableSection.swift
//  CellViewModel
//
//  Created by Anton Poltoratskyi on 14.04.2019.
//  Copyright © 2019 Anton Poltoratskyi. All rights reserved.
//

import UIKit

/// Supported only for UICollectionView for now
public final class DiffableSection {
    
    public let identifier: String
    
    public let insets: UIEdgeInsets?
    
    public let lineSpacing: CGFloat?
    
    public var header: AnySupplementaryViewModel?
    
    public var footer: AnySupplementaryViewModel?
    
    public var items: [DiffableCellViewModel]
    
    public init(identifier: String,
                insets: UIEdgeInsets? = nil,
                lineSpacing: CGFloat? = nil,
                header: AnySupplementaryViewModel? = nil,
                footer: AnySupplementaryViewModel? = nil,
                items: [DiffableCellViewModel]) {
        self.identifier = identifier
        self.insets = insets
        self.lineSpacing = lineSpacing
        self.items = items
    }
}
