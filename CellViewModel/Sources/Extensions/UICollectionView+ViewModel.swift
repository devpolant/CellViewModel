//
//  UICollectionView+ViewModel.swift
//  CellViewModel
//
//  Created by Anton Poltoratskyi on 02.02.2019.
//  Copyright © 2019 Anton Poltoratskyi. All rights reserved.
//

import UIKit

// MARK: - Cell

extension UICollectionView {
    
    public func dequeueReusableCell(with viewModel: AnyCellViewModel, for indexPath: IndexPath) -> UICollectionViewCell {
        let identifier = type(of: viewModel).uniqueIdentifier
        let cell = dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath)
        cell.accessibilityIdentifier = viewModel.accessibilityIdentifier(for: indexPath)
        viewModel.setup(cell: cell)
        return cell
    }
    
    public func register(_ modelType: AnyCellViewModel.Type) {
        if let xibFileName = (modelType.cellClass as? XibInitializable.Type)?.xibFileName {
            let nib = UINib(nibName: xibFileName, bundle: Bundle(for: modelType.cellClass))
            register(nib, forCellWithReuseIdentifier: modelType.uniqueIdentifier)
            
        } else {
            register(modelType.cellClass, forCellWithReuseIdentifier: modelType.uniqueIdentifier)
        }
    }
    
    public func register(_ models: [AnyCellViewModel.Type]) {
        models.forEach { register($0) }
    }
    
    public func register(_ models: AnyCellViewModel.Type...) {
        models.forEach { register($0) }
    }
    
    public func register<T: CellViewModel>(_ viewModel: T.Type) where T.Cell: UICollectionViewCell {
        register(T.Cell.self, forCellWithReuseIdentifier: T.uniqueIdentifier)
    }
    
    public func register<T: CellViewModel>(_ viewModel: T.Type) where T.Cell: UICollectionViewCell, T.Cell: XibInitializable {
        let nib = UINib(nibName: T.Cell.xibFileName, bundle: Bundle(for: T.Cell.self))
        register(nib, forCellWithReuseIdentifier: T.uniqueIdentifier)
    }
}

// MARK: - SupplementaryView

extension UICollectionView {
    
    public func dequeueReusableSupplementaryView(with viewModel: AnySupplementaryViewModel, for indexPath: IndexPath) -> UICollectionReusableView {
        let identifier = type(of: viewModel).uniqueIdentifier
        let kind = type(of: viewModel).supplementaryKind
        let view = dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: identifier, for: indexPath)
        view.accessibilityIdentifier = viewModel.accessibilityIdentifier(for: indexPath)
        viewModel.setup(view: view)
        return view
    }
    
    public func register(_ modelType: AnySupplementaryViewModel.Type) {
        if let xibFileName = (modelType.supplementaryViewClass as? XibInitializable.Type)?.xibFileName {
            let nib = UINib(nibName: xibFileName, bundle: Bundle(for: modelType.supplementaryViewClass))
            register(nib, forSupplementaryViewOfKind: modelType.supplementaryKind, withReuseIdentifier: modelType.uniqueIdentifier)
            
        } else {
            register(modelType.supplementaryViewClass,
                     forSupplementaryViewOfKind: modelType.supplementaryKind,
                     withReuseIdentifier: modelType.uniqueIdentifier)
        }
    }
    
    public func register(_ models: [AnySupplementaryViewModel.Type]) {
        models.forEach { register($0) }
    }
    
    public func register(_ models: AnySupplementaryViewModel.Type...) {
        models.forEach { register($0) }
    }
    
    public func register<T: SupplementaryViewModel>(_ supplementaryModel: T.Type) {
        register(T.View.self, forSupplementaryViewOfKind: T.supplementaryKind, withReuseIdentifier: T.uniqueIdentifier)
    }
    
    public func register<T: SupplementaryViewModel>(_ supplementaryModel: T.Type) where T.View: XibInitializable {
        let nib = UINib(nibName: T.View.xibFileName, bundle: Bundle(for: T.View.self))
        register(nib, forSupplementaryViewOfKind: T.supplementaryKind, withReuseIdentifier: T.uniqueIdentifier)
    }
}
