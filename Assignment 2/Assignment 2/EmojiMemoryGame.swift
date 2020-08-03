//
//  EmojiMemoryGame.swift
//  Lecture 2
//
//  Created by Mert Arıcan on 25.06.2020.
//  Copyright © 2020 Mert Arıcan. All rights reserved.
//

import SwiftUI

class EmojiMemoryGame: ObservableObject {
    
    @Published private var model: MemoryGame<String>
    
    private(set) var theme: Theme
    
    init() {
        self.theme = EmojiMemoryGame.allThemes.randomElement()!
        self.model = EmojiMemoryGame.createMemoryGame(for: theme)
    }
    
    static func createMemoryGame(for theme: Theme) -> MemoryGame<String> {
        let emojis = theme.emojis
        return MemoryGame<String>(numberOfPairsOfCards: theme.numberOfPairsOfCardsToShow) { pairIndex in
            return emojis[pairIndex]
        }
    }
    
    //MARK: - Access to the Model
    
    var cards: Array<MemoryGame<String>.Card> {
        model.cards
    }
    
    var score: Int { model.score }
    
    // MARK: - Intent(s)
    
    func choose(card: MemoryGame<String>.Card) {
        model.choose(card: card)
    }
    
    func newGame() {
        theme = EmojiMemoryGame.allThemes.randomElement()!
        self.model = EmojiMemoryGame.createMemoryGame(for: theme)
    }
    
    // MARK: - Themes
    
    private static let allThemes: [Theme] = [
        Theme(name: "Moon", emojis: ["🌑", "🌒", "🌓", "🌔", "🌕", "🌖", "🌗", "🌘"], color: .yellow),
        Theme(name: "Halloween", emojis: ["🎃", "👻", "😈", "🧛", "🧡"], color: .orange),
        Theme(name: "Animals", emojis: ["🦓", "🦌", "🦘", "🦒", "🐌"], color: .brown),
        Theme(name: "Green", emojis: ["🦎", "🍀", "🐍", "🛶"], color: .green),
        Theme(name: "Flowers", emojis: ["🌷", "🌹", "🌺"], color: .red),
        Theme(name: "Sea", emojis: ["🛳", "🐳", "⚓️"], color: .blue)
    ]
    
}
