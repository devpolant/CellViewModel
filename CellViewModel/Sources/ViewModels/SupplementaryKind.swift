//
//  SupplementaryKind.swift
//  CellViewModel
//
//  Created by Anton Poltoratskyi on 09.05.2019.
//  Copyright © 2019 Anton Poltoratskyi. All rights reserved.
//

public enum SupplementaryKind {
    case header
    case footer
    
    var rawValue: String {
        switch self {
        case .header:
            return collectionSectionHeaderType
        case .footer:
            return collectionSectionFooterType
        }
    }
}
