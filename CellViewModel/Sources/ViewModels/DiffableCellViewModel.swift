//
//  DiffableCellViewModel.swift
//  CellViewModel
//
//  Created by Anton Poltoratskyi on 14.04.2019.
//  Copyright © 2019 Anton Poltoratskyi. All rights reserved.
//

public protocol DiffableCellViewModel: AnyCellViewModel, Diffable {
    func isEqual(to model: DiffableCellViewModel) -> Bool
}

extension DiffableCellViewModel {
    var diffIdentifier: AnyHashable {
        return String(describing: type(of: self))
    }
    
    func isEqual(to model: DiffableCellViewModel) -> Bool {
        return model is Self
    }
}
