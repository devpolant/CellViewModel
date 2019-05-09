//
//  Section.swift
//  CellViewModel
//
//  Created by Anton Poltoratskyi on 02.02.2019.
//  Copyright © 2019 Anton Poltoratskyi. All rights reserved.
//

import UIKit

public final class Section {
    
    /// Supported only for UICollectionView. Unsupported for UITableView.
    public var insets: UIEdgeInsets?
    /// Supported only for UICollectionView. Unsupported for UITableView.
    public var lineSpacing: CGFloat?
    /// Supported only for UICollectionView. Unsupported for UITableView.
    public var header: AnySupplementaryViewModel?
    /// Supported only for UICollectionView. Unsupported for UITableView.
    public var footer: AnySupplementaryViewModel?
    
    public var items: [AnyCellViewModel]
    
    public init(insets: UIEdgeInsets? = nil,
                lineSpacing: CGFloat? = nil,
                header: AnySupplementaryViewModel? = nil,
                footer: AnySupplementaryViewModel? = nil,
                items: [AnyCellViewModel]) {
        self.insets = insets
        self.lineSpacing = lineSpacing
        self.header = header
        self.footer = footer
        self.items = items
    }
}
