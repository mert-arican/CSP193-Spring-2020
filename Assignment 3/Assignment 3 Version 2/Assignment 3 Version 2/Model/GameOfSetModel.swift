//
//  GameOfSetModel.swift
//  Assignment 3 Version 2
//
//  Created by Mert Arıcan on 9.07.2020.
//  Copyright © 2020 Mert Arıcan. All rights reserved.
//

import Foundation

// Little enum for holding the match state
enum MatchState { case match, mismatch, normal }

struct SetModel {
    
    private(set) var cardsOnTheDeck = [Card]()
    private(set) var cardsOnTheTable = [Card]()
    
    var selectedCards: [Card] {
        return cardsOnTheTable.filter { $0.isSelected }
    }
    
    var matchState: MatchState {
        // If less than three cards are selected then return .normal
        // else return whether those three are match or a mismatch
        if selectedCards.count != 3 { return .normal }
        for featureLabel in FeatureLabels.all {
            var featureSet = Set<AnyHashable>()
            selectedCards.forEach { featureSet.insert($0.getFeatureOfACard(with: featureLabel)) }
            if featureSet.count == 2 { return .mismatch }
        }
        return .match
    }
    
    init(allCards: [Card]) {
        cardsOnTheDeck = allCards
        for _ in 1...12 {
            cardsOnTheTable.append(cardsOnTheDeck.popRandomElement()!)
        }
    }
    
    mutating func dealThreeMoreCards() {
        // If there is a match then replace matched cards with three new cards
        // If not then add three new cards onto the screen
        if matchState == .match {
            selectedCards.forEach {
                let index = cardsOnTheTable.firstIndex(matching: $0)!
                if let randomNewCard = cardsOnTheDeck.popRandomElement() {
                    cardsOnTheTable[index] = randomNewCard
                } else {
                    cardsOnTheTable.remove(at: index)
                }
            }
        } else {
            for _ in 1...3 {
                if let newRandomCard = cardsOnTheDeck.popRandomElement() {
                    cardsOnTheTable.append(newRandomCard)
                }
            }
        }
    }
    
    mutating func select(card: Card) {
        // If it's a match and new card is selected...
        if matchState == .match {
            if card.isMatch == .match { dealThreeMoreCards() }
            else { dealThreeMoreCards(); select(card: card) }
        }
            
        // If less than 3 cards are selected...
        else if matchState == .normal, let index = cardsOnTheTable.firstIndex(matching: card) {
            cardsOnTheTable[index].isSelected = !cardsOnTheTable[index].isSelected
        }
            
        // If 3 cards are selected but they are not a match...
        else {
            cardsOnTheTable.indices.forEach { cardsOnTheTable[$0].isSelected = false }
            if let index = cardsOnTheTable.firstIndex(matching: card) {
                cardsOnTheTable[index].isSelected = true
            }
        }
        
        // Determine the selection state of each card on the table
        cardsOnTheTable.indices.forEach { cardsOnTheTable[$0].isMatch = .normal }
        selectedCards.forEach { cardsOnTheTable[cardsOnTheTable.firstIndex(matching: $0)!].isMatch = matchState }
    }
    
}
