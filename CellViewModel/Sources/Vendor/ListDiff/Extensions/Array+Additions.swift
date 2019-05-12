//
//  Array+Additions.swift
//  CellViewModel
//
//  Created by Anton Poltoratskyi on 5/12/19.
//  Copyright © 2019 Anton Poltoratskyi. All rights reserved.
//

extension Array {
    
    mutating func move(at index: Int, to newIndex: Int) {
        let element = remove(at: index)
        insert(element, at: newIndex)
    }
}
