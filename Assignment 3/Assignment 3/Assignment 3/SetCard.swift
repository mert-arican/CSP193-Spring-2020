//
//  SetCard.swift
//  Assignment 3
//
//  Created by Mert Arıcan on 2.07.2020.
//  Copyright © 2020 Mert Arıcan. All rights reserved.
//

import Foundation

struct SetCard: Identifiable, CustomStringConvertible, Equatable {
    
    // MARK: - Protocol Conformances
    
    static func == (lhs: SetCard, rhs: SetCard) -> Bool {
        return lhs.id == rhs.id
    }
    
    var id: Int
    
    var description: String {
        return "Card(\(self.shape) \(self.shading) \(self.color) \(self.numberOfShapes) || ID: \(self.id))"
    }
    
    // MARK: - State of the card
    
    var isSelected = false
    var matchState = MatchState.normal
    
    // MARK: - Features of a card
    
    static let numberOfFeatures = 4;
    
    private let numberOfShapes: NumberOfShapes
    private let shape: CardShape
    private let shading: Shading
    private let color: CardColor
    
    var allFeaturesAsRawValues: [Int] {
        return [numberOfShapes.rawValue, shape.rawValue, shading.rawValue, color.rawValue]
    }
    
    var allFeaturesAsEnums: (NumberOfShapes, CardShape, Shading, CardColor) {
        return (numberOfShapes, shape, shading, color)
    }
        
    init(numberOfShapes: NumberOfShapes, shape: CardShape, shading: Shading, color: CardColor, id: Int) {
        self.numberOfShapes = numberOfShapes
        self.shape = shape
        self.shading = shading
        self.color = color
        self.id = id
    }

}
