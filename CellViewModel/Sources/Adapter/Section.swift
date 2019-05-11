//
//  Section.swift
//  CellViewModel
//
//  Created by Anton Poltoratskyi on 02.02.2019.
//  Copyright © 2019 Anton Poltoratskyi. All rights reserved.
//

import UIKit

public final class Section {
    
    public let identifier: String?
    
    /// Supported only for UICollectionView. NOT supported for UITableView.
    public var insets: UIEdgeInsets?
    /// Supported only for UICollectionView. NOT Unsupported for UITableView.
    public var lineSpacing: CGFloat?
    
    public var header: AnySupplementaryViewModel?
    
    public var footer: AnySupplementaryViewModel?
    
    public var items: [AnyCellViewModel]
    
    public init(identifier: String? = nil,
                insets: UIEdgeInsets? = nil,
                lineSpacing: CGFloat? = nil,
                header: AnySupplementaryViewModel? = nil,
                footer: AnySupplementaryViewModel? = nil,
                items: [AnyCellViewModel]) {
        self.identifier = identifier
        self.insets = insets
        self.lineSpacing = lineSpacing
        self.header = header
        self.footer = footer
        self.items = items
    }
}
