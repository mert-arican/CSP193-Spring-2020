//
//  Theme.swift
//  Assignment 2
//
//  Created by Mert Arıcan on 27.06.2020.
//  Copyright © 2020 Mert Arıcan. All rights reserved.
//

import Foundation

struct Theme {
    
    let name: String
    let emojis: [String]
    let numberOfPairsOfCardsToShow: Int
    let color: Color
    
    static func determineNumberOfPairsOfCardsToShow(for emojis: [String]) -> Int {
        let count = emojis.count
        return (count <= 3) ? count : Int.random(in: 3...(min(count, 5)))
    }
    
    init(name: String, emojis: [String], color: Theme.Color) {
        self.name = name
        self.emojis = emojis
        self.numberOfPairsOfCardsToShow = Theme.determineNumberOfPairsOfCardsToShow(for: emojis)
        self.color = color
    }
    
    enum Color {
        case orange
        case brown
        case red
        case blue
        case yellow
        case green
    }
    
}
