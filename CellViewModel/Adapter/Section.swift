//
//  Section.swift
//  CellViewModel
//
//  Created by Anton Poltoratskyi on 02.02.2019.
//  Copyright © 2019 Anton Poltoratskyi. All rights reserved.
//

public final class Section {
    public var header: AnySupplementaryViewModel?
    public var footer: AnySupplementaryViewModel?
    public var items: [AnyCellViewModel]
    
    public init(header: AnySupplementaryViewModel? = nil, footer: AnySupplementaryViewModel? = nil, items: [AnyCellViewModel]) {
        self.header = header
        self.footer = footer
        self.items = items
    }
}
