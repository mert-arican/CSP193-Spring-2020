//
//  Theme.swift
//  Assignment 2
//
//  Created by Mert Arıcan on 27.06.2020.
//  Copyright © 2020 Mert Arıcan. All rights reserved.
//

import SwiftUI

struct Theme: Codable {
    
    let name: String
    let emojis: [String]
    let numberOfPairsOfCardsToShow: Int
    let color: ThemeColor
    
    init(name: String, emojis: [String], color: Theme.ThemeColor) {
        self.name = name
        self.emojis = emojis
        self.numberOfPairsOfCardsToShow = emojis.count
        self.color = color
    }
    
    var json: Data? {
        return try? JSONEncoder().encode(self)
    }
    
    // MARK: - Make enum String (or Int etc.) to conform Codable protocol.
    enum ThemeColor: String, Codable {
        case orange
        case brown
        case red
        case blue
        case yellow
        case green
    }
    
}

extension Data {
    // just a simple converter from a Data to a String
    var utf8: String? { String(data: self, encoding: .utf8 ) }
}
