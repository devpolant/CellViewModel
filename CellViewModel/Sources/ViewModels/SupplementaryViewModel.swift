//
//  SupplementaryViewModel.swift
//  CellViewModel
//
//  Created by Anton Poltoratskyi on 02.02.2019.
//  Copyright © 2019 Anton Poltoratskyi. All rights reserved.
//

import UIKit

public typealias AnySupplementaryView = UICollectionReusableView

public protocol AnySupplementaryViewModel: Reusable, Accessible {
    static var supplementaryKind: String { get }
    var height: CGFloat? { get }
    func setup(view: AnySupplementaryView)
}

extension AnySupplementaryViewModel {
    public static var supplementaryKind: String {
        return UICollectionView.elementKindSectionHeader
    }
    public var height: CGFloat? {
        return nil
    }
}

public protocol SupplementaryViewModel: AnySupplementaryViewModel {
    associatedtype View: AnySupplementaryView
    func setup(view: View)
}

extension SupplementaryViewModel {
    public func setup(view: AnySupplementaryView) {
        setup(view: view as! View)
    }
}
