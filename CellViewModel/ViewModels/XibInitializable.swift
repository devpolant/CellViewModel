//
//  XibInitializable.swift
//  CellViewModel
//
//  Created by Anton Poltoratskyi on 02.02.2019.
//  Copyright © 2019 Anton Poltoratskyi. All rights reserved.
//

import UIKit

public protocol XibInitializable: class {
    static var xibFileName: String { get }
}

extension XibInitializable where Self: UIView {
    public static var xibFileName: String {
        return String(describing: self)
    }
}

 extension XibInitializable where Self: UIViewController {
    public static var xibFileName: String {
        return String(describing: self)
    }
    
    public static func instantiateFromXib() -> Self {
        return Self(nibName: xibFileName, bundle: nil)
    }
}
