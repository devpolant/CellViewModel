//
//  Reusable.swift
//  CellViewModel
//
//  Created by Anton Poltoratskyi on 02.02.2019.
//  Copyright © 2019 Anton Poltoratskyi. All rights reserved.
//

import Foundation

public protocol Reusable {
    static var uniqueIdentifier: String { get }
}

extension Reusable {
    public static var uniqueIdentifier: String {
        return String(describing: self)
    }
}
