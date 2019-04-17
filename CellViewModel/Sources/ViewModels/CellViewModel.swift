//
//  Cell+ViewModel.swift
//  CellViewModel
//
//  Created by Anton Poltoratskyi on 02.02.2019.
//  Copyright © 2019 Anton Poltoratskyi. All rights reserved.
//

import UIKit

public typealias AnyViewCell = UIView

public protocol AnyCellViewModel: Reusable, Accessible {
    static var cellClass: AnyClass { get }
    func setup(cell: AnyViewCell)
    func height(constrainedBy maxWidth: CGFloat) -> CGFloat?
}

extension AnyCellViewModel {
    public func height(constrainedBy maxWidth: CGFloat) -> CGFloat? {
        return nil
    }
}

public protocol CellViewModel: AnyCellViewModel {
    associatedtype Cell: AnyViewCell
    func setup(cell: Cell)
}

extension CellViewModel {
    public static var cellClass: AnyClass {
        return Cell.self
    }
    
    public func setup(cell: AnyViewCell) {
        // swiftlint:disable force_cast
        setup(cell: cell as! Cell)
        // swiftlint:enable force_cast
    }
}
