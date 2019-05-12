import Foundation

extension List.Result {
    
    public struct Batch {
        public let inserts: IndexSet
        public let deletes: IndexSet
        public let moves: [List.MoveIndex]
        
        public var hasChanges: Bool {
            return changeCount > 0
        }
        
        public var changeCount: Int {
            return inserts.count + deletes.count + moves.count
        }
        
        fileprivate init(result: List.Result) {
            self.inserts = result.inserts
            self.deletes = result.deletes
            self.moves = result.moves
        }
    }
    
    public func forBatchUpdates() -> Batch {
        return Batch(result: preparedForBatchUpdates())
    }
    
    private func preparedForBatchUpdates() -> List.Result {
        var result = self
        result.prepareForBatchUpdates()
        return result
    }
    
    private mutating func prepareForBatchUpdates() {
        // convert move+update to delete+insert, respecting the from/to of the move
        for (index, move) in moves.enumerated().reversed() {
            if updates.remove(move.from) != nil {
                moves.remove(at: index)
                deletes.insert(move.from)
                inserts.insert(move.to)
            }
        }
        
        // iterate all new identifiers. if its index is updated, delete from the old index and insert the new index
        for (key, oldIndex) in oldMap {
            if updates.contains(oldIndex), let newIndex = newMap[key] {
                deletes.insert(oldIndex)
                inserts.insert(newIndex)
            }
        }
        
        updates.removeAll()
    }
}
