//
//  EmojiMemoryGame.swift
//  Assignment 1
//
//  Created by Mert Arıcan on 26.06.2020.
//  Copyright © 2020 Mert Arıcan. All rights reserved.
//

import SwiftUI

class EmojiMemoryGame {
    
    private var model: MemoryGame<String> = EmojiMemoryGame.createMemoryGame()
    
    // MARK: - Extra Credit
    static func createMemoryGame() -> MemoryGame<String> {
        let emojis: Array<String> = ["👻", "🎃", "🕷", "🦋", "🦄", "🦕", "🐆", "🦓", "🦌", "🐐", "🐿", "🦔"].shuffled()
        return MemoryGame<String>(numberOfPairsOfCards: (2...5).randomElement()!) { pairIndex in
            return emojis[pairIndex]
        }
    }
    
    //MARK: - Access to the Model
    
    var cards: Array<MemoryGame<String>.Card> {
        model.cards
    }
    
    // MARK: - Intent(s)
    
    func choose(card: MemoryGame<String>.Card) {
        model.choose(card: card)
    }
}
