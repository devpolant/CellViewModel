//
//  UITableView+ViewModels.swift
//  CellViewModel
//
//  Created by Anton Poltoratskyi on 02.02.2019.
//  Copyright © 2019 Anton Poltoratskyi. All rights reserved.
//

import UIKit

// MARK: - Cell

public extension UITableView {
    
    func dequeueReusableCell(withModel viewModel: AnyCellViewModel, for indexPath: IndexPath) -> UITableViewCell {
        let identifier = type(of: viewModel).uniqueIdentifier
        let cell = dequeueReusableCell(withIdentifier: identifier, for: indexPath)
        cell.accessibilityIdentifier = viewModel.accessibilityIdentifier(for: indexPath)
        viewModel.setup(cell: cell)
        return cell
    }
    
    func register(anyViewModel viewModel: AnyCellViewModel) {
        if let viewModel = viewModel as? AnyCellViewModel & XibInitializable, case let modelType = type(of: viewModel) {
            let nib = UINib(nibName: modelType.xibFileName, bundle: Bundle(for: modelType.cellClass))
            register(nib, forCellReuseIdentifier: modelType.uniqueIdentifier)
            
        } else {
            let modelType = type(of: viewModel)
            register(modelType.cellClass, forCellReuseIdentifier: modelType.uniqueIdentifier)
        }
    }
    
    func register<T: CellViewModel>(viewModel: T.Type) where T.Cell: UITableViewCell {
        register(T.Cell.self, forCellReuseIdentifier: T.uniqueIdentifier)
    }
    
    func register<T: CellViewModel>(nibModel: T.Type) where T.Cell: UITableViewCell, T.Cell: XibInitializable {
        let nib = UINib(nibName: T.Cell.xibFileName, bundle: Bundle(for: T.Cell.self))
        register(nib, forCellReuseIdentifier: T.uniqueIdentifier)
    }
}

// MARK: - Header / Footer

public extension UITableView {
    
    func dequeueReusableHeaderFooterView<T: UITableViewHeaderFooterView & Reusable>(ofType type: T.Type) -> T {
        return dequeueReusableHeaderFooterView(withIdentifier: T.uniqueIdentifier) as! T
    }
    
    func register<T: UITableViewHeaderFooterView & Reusable>(headerFooter: T.Type) {
        register(T.self, forHeaderFooterViewReuseIdentifier: T.uniqueIdentifier)
    }
}
