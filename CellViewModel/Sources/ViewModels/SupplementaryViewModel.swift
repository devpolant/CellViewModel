//
//  SupplementaryViewModel.swift
//  CellViewModel
//
//  Created by Anton Poltoratskyi on 02.02.2019.
//  Copyright © 2019 Anton Poltoratskyi. All rights reserved.
//

import UIKit
public typealias AnySupplementaryView = UIView

public protocol AnySupplementaryViewModel: Reusable, Accessible {
    static var supplementaryKind: SupplementaryKind { get }
    static var supplementaryViewClass: AnyClass { get }
    func setup(view: AnySupplementaryView)
    func height(constrainedBy maxWidth: CGFloat) -> CGFloat?
}

extension AnySupplementaryViewModel {
    public static var supplementaryKind: SupplementaryKind {
        return .header
    }
    public func height(constrainedBy maxWidth: CGFloat) -> CGFloat? {
        return nil
    }
}

public protocol SupplementaryViewModel: AnySupplementaryViewModel {
    associatedtype View: AnySupplementaryView
    func setup(view: View)
}

extension SupplementaryViewModel {
    public static var supplementaryViewClass: AnyClass {
        return View.self
    }
    
    public func setup(view: AnySupplementaryView) {
        // swiftlint:disable force_cast
        setup(view: view as! View)
        // swiftlint:enable force_cast
    }
}
