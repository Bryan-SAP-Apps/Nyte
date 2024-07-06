//
//  Item.swift
//  4May2024
//
//  Created by Bryan Nguyen on 4/5/24.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
