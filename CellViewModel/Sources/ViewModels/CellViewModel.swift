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
}

public protocol CellViewModel: AnyCellViewModel {
    associatedtype Cell: AnyViewCell
    func setup(cell: Cell)
}

public extension CellViewModel {
    static var cellClass: AnyClass {
        return Cell.self
    }
    
    func setup(cell: AnyViewCell) {
        setup(cell: cell as! Cell)
    }
}
