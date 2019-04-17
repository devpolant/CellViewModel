//
//  InteractiveCellViewModel.swift
//  CellViewModel
//
//  Created by Anton Poltoratskyi on 03.04.2019.
//  Copyright © 2019 Anton Poltoratskyi. All rights reserved.
//

protocol InteractiveCellViewModel {
    var selectionHandler: (() -> Void)? { get }
}
