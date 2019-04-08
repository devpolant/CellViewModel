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
    
    public func loadFromXib() {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: type(of: self).xibFileName, bundle: bundle)
        guard let contentView = nib.instantiate(withOwner: self, options: nil).first as? UIView else {
            fatalError("object not found")
        }
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(contentView)
        NSLayoutConstraint.activate([
            contentView.leadingAnchor.constraint(equalTo: leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: trailingAnchor),
            contentView.topAnchor.constraint(equalTo: topAnchor),
            contentView.bottomAnchor.constraint(equalTo: bottomAnchor)]
        )
    }
}

extension XibInitializable where Self: UIViewController {
    public static var xibFileName: String {
        return String(describing: self)
    }
    
    public static func instantiateFromXib() -> Self {
        return Self(nibName: xibFileName, bundle: Bundle(for: self))
    }
}
