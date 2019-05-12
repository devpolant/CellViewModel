//
//  String+Diffable.swift
//  CellViewModel
//
//  Created by Anton Poltoratskyi on 14.04.2019.
//  Copyright © 2019 Anton Poltoratskyi. All rights reserved.
//

extension String: Diffable {
    
    public var diffIdentifier: AnyHashable {
        return self
    }
}
