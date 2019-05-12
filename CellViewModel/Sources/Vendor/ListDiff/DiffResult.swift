//
//  DiffResult.swift
//  CellViewModel
//
//  Created by Anton Poltoratskyi on 14.04.2019.
//  Copyright © 2019 Anton Poltoratskyi. All rights reserved.
//

import Foundation

public struct DiffResult {
    public let inserts: IndexSet
    public let deletes: IndexSet
    public let moves: [List.MoveIndex]
    
    public var hasChanges: Bool {
        return changeCount > 0
    }
    
    public var changeCount: Int {
        return inserts.count + deletes.count + moves.count
    }
    
    init(result: List.Result.Batch) {
        inserts = result.inserts
        deletes = result.deletes
        moves = result.moves
    }
}
