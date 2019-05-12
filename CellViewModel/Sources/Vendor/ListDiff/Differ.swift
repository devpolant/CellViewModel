//
//  Differ.swift
//  CellViewModel
//
//  Created by Anton Poltoratskyi on 14.04.2019.
//  Copyright © 2019 Anton Poltoratskyi. All rights reserved.
//

public protocol Differ {
    func diffBetween<T: Diffable & Equatable>(old: [T], new: [T]) -> DiffResult
}

public final class ListDiffer: Differ {
    
    public init() { }
    
    public func diffBetween<T: Diffable & Equatable>(old: [T], new: [T]) -> DiffResult {
        let diff = List.diffing(old: old, new: new).forBatchUpdates()
        return DiffResult(result: diff)
    }
}
