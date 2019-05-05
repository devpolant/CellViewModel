//
//  UITableView+ViewModels.swift
//  CellViewModel
//
//  Created by Anton Poltoratskyi on 02.02.2019.
//  Copyright © 2019 Anton Poltoratskyi. All rights reserved.
//

import UIKit

// MARK: - Cell

extension UITableView {
    
    public func dequeueReusableCell(with viewModel: AnyCellViewModel, for indexPath: IndexPath) -> UITableViewCell {
        let identifier = type(of: viewModel).uniqueIdentifier
        let cell = dequeueReusableCell(withIdentifier: identifier, for: indexPath)
        cell.accessibilityIdentifier = viewModel.accessibilityIdentifier(for: indexPath)
        viewModel.setup(cell: cell)
        return cell
    }
    
    public func register(_ modelType: AnyCellViewModel.Type) {
        if let xibFileName = (modelType.cellClass as? XibInitializable.Type)?.xibFileName {
            let nib = UINib(nibName: xibFileName, bundle: Bundle(for: modelType.cellClass))
            register(nib, forCellReuseIdentifier: modelType.uniqueIdentifier)
            
        } else {
            register(modelType.cellClass, forCellReuseIdentifier: modelType.uniqueIdentifier)
        }
    }
    
    public func register(_ models: [AnyCellViewModel.Type]) {
        models.forEach { register($0) }
    }
    
    public func register(_ models: AnyCellViewModel.Type...) {
        models.forEach { register($0) }
    }
    
    public func register<T: CellViewModel>(_ viewModel: T.Type) where T.Cell: UITableViewCell {
        register(T.Cell.self, forCellReuseIdentifier: T.uniqueIdentifier)
    }
    
    public func register<T: CellViewModel>(_ viewModel: T.Type) where T.Cell: UITableViewCell, T.Cell: XibInitializable {
        let nib = UINib(nibName: T.Cell.xibFileName, bundle: Bundle(for: T.Cell.self))
        register(nib, forCellReuseIdentifier: T.uniqueIdentifier)
    }
}

// MARK: - Header / Footer

extension UITableView {
    
    public func dequeueReusableHeaderFooterView<T: UITableViewHeaderFooterView & Reusable>(ofType type: T.Type) -> T {
        return dequeueReusableHeaderFooterView(withIdentifier: T.uniqueIdentifier) as! T
    }
    
    public func register<T: UITableViewHeaderFooterView & Reusable>(headerFooter: T.Type) {
        register(T.self, forHeaderFooterViewReuseIdentifier: T.uniqueIdentifier)
    }
}
