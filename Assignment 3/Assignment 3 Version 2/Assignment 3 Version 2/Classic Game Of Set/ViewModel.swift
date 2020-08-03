//
//  ViewModel.swift
//  Assignment 3 Version 2
//
//  Created by Mert Arıcan on 9.07.2020.
//  Copyright © 2020 Mert Arıcan. All rights reserved.
//

import Foundation

class ViewModel: ObservableObject {
    
    @Published private var model = SetModel(allCards: ClassicGameOfSetCardDeck().deck)
    
    var cardsOnTheTable: [Card] {
        return model.cardsOnTheTable
    }
    
    var deckIsEmpty: Bool {
        return model.cardsOnTheDeck.count == 0
    }
    
    // MARK: - Intents
    
    func select(card: Card) {
        model.select(card: card)
    }
    
    func dealThreeMoreCards() {
        model.dealThreeMoreCards()
    }
    
    func newGame() {
        self.model = SetModel(allCards: ClassicGameOfSetCardDeck().deck)
    }
    
}

// MARK: - Data types for features of a set card, each conforming to the FeatureProtocol

enum CardShading: FeatureProtocol, CaseIterable {
    typealias Feature = CardShading
    
    var feature: CardShading {
        return self
    }
    
    var featureLabel: String {
        return FeatureLabels.shading
    }
    
    case open, straped, solid
}

enum CardShape: FeatureProtocol, CaseIterable {
    typealias Feature = CardShape
    
    var feature: CardShape {
        return self
    }
    
    var featureLabel: String {
        return FeatureLabels.shape
    }
    
    case diamond, oval, squiggle
}

enum CardColor: FeatureProtocol, CaseIterable {
    typealias Feature = CardColor
    
    var feature: CardColor {
        return self
    }
    
    var featureLabel: String {
        return FeatureLabels.color
    }
    
    case red, green, purple
}

enum NumberOfShapes: Int, FeatureProtocol, CaseIterable {
    typealias Feature = NumberOfShapes
    
    var feature: NumberOfShapes {
        return self
    }
    
    var featureLabel: String {
        return FeatureLabels.numberOfShapes
    }
    
    case one=1, two, three
}

// MARK: - Struct that creates a deck of set cards with given features

struct ClassicGameOfSetCardDeck {
    private(set) var deck: [Card] = []
    init() {
        for color in CardColor.allCases {
            for shape in CardShape.allCases {
                for shading in CardShading.allCases {
                    for number in NumberOfShapes.allCases {
                        let allFeatures: [String:AnyHashable] = [
                            shape.featureLabel : shape.feature,
                            color.featureLabel : color.feature,
                            number.featureLabel : number.feature,
                            shading.featureLabel : shading.feature
                        ]
                        let card = Card(allFeatures: allFeatures, id: deck.count)
                        deck.append(card)
                    }
                }
            }
        }
        deck.shuffle()
    }
}

// MARK: - Constants struct for holding labels of features

struct FeatureLabels {
    // This struct is going to be used while cards are getting drawn on screen
    // Each feature of a card has to have a string value that identifies it
    // All feature properties below must be added to the 'all' array
    static let color = "color"
    static let shading = "shading"
    static let shape = "shape"
    static let numberOfShapes = "number"
    static let all = [color, shading, shape, numberOfShapes]
    static let featureCount = all.count
}
