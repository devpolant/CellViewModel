//
//  SectionAdapter.swift
//  CellViewModel
//
//  Created by Anton Poltoratskyi on 1/27/20.
//  Copyright © 2020 Anton Poltoratskyi. All rights reserved.
//

import Foundation

public protocol SectionAdapter {
    var data: [Section] { get }
    
    func sectionModel(at index: Int) -> Section
    func headerModel(in section: Int) -> AnySupplementaryViewModel?
    func footerModel(in section: Int) -> AnySupplementaryViewModel?
    func itemModel(at indexPath: IndexPath) -> AnyCellViewModel
    
    func contains(section: Int) -> Bool
    func containsModel(at indexPath: IndexPath) -> Bool
}

extension SectionAdapter {
    
    public func sectionModel(at index: Int) -> Section {
        return data[index]
    }
    
    public func headerModel(in section: Int) -> AnySupplementaryViewModel? {
        return data[section].header
    }
    
    public func footerModel(in section: Int) -> AnySupplementaryViewModel? {
        return data[section].footer
    }
    
    public func itemModel(at indexPath: IndexPath) -> AnyCellViewModel {
        return data[indexPath.section].items[indexPath.item]
    }
    
    public func contains(section: Int) -> Bool {
        return data.indices.contains(section)
    }
    
    public func containsModel(at indexPath: IndexPath) -> Bool {
        return contains(section: indexPath.section)
            && data[indexPath.section].items.indices.contains(indexPath.row)
    }
}
