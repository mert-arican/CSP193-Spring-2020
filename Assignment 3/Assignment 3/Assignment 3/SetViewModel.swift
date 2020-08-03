//
//  SetViewModel.swift
//  Assignment 3
//
//  Created by Mert Arıcan on 2.07.2020.
//  Copyright © 2020 Mert Arıcan. All rights reserved.
//

import Foundation

class SetViewModel: ObservableObject {
    
    @Published private var model = SetModel()
    
    var cardsOnTheTable: [SetCard] {
        return model.cardsOnTheTable
    }
    
    var deckIsEmpty: Bool {
        return model.cardsOnTheDeck.count == 0
    }
    
    // MARK: - Intents
    
    func select(card: SetCard) {
        model.select(card: card)
    }
    
    func dealThreeMoreCards() {
        model.dealThreeMoreCards()
    }
    
    func newGame() {
        self.model = SetModel()
    }
    
}
