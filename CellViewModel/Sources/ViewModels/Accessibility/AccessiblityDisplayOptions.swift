//
//  AccessiblityDisplayOptions.swift
//  CellViewModel
//
//  Created by Anton Poltoratskyi on 02.02.2019.
//  Copyright © 2019 Anton Poltoratskyi. All rights reserved.
//

public struct AccessibilityDisplayOptions: OptionSet {
    public let rawValue: Int
    
    public init(rawValue: Int) {
        self.rawValue = rawValue
    }
    
    public static let none      = AccessibilityDisplayOptions([])
    public static let section   = AccessibilityDisplayOptions(rawValue: 1 << 0)
    public static let row       = AccessibilityDisplayOptions(rawValue: 1 << 1)
    public static let all       = AccessibilityDisplayOptions(rawValue: Int.max)
}
