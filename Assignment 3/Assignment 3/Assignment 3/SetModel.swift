//
//  SetModel.swift
//  Assignment 3
//
//  Created by Mert Arıcan on 2.07.2020.
//  Copyright © 2020 Mert Arıcan. All rights reserved.
//

import Foundation

struct SetModel {
    
    private(set) var cardsOnTheDeck = [SetCard]()
    private(set) var cardsOnTheTable = [SetCard]()
    
    var selectedCards: [SetCard] {
        return cardsOnTheTable.filter { $0.isSelected }
    }
    
    var matchState: MatchState {
        if selectedCards.count != 3 { return .normal }
        for index in 0..<SetCard.numberOfFeatures {
            var featureSet = Set<Int>()
            selectedCards.forEach { featureSet.insert($0.allFeaturesAsRawValues[index]) }
            if featureSet.count == 2 { return .mismatch }
        }
        return .match
    }
    
    init() {
        cardsOnTheDeck = SetCardDeck().deck
        for _ in 1...12 {
            cardsOnTheTable.append(cardsOnTheDeck.popRandomElement()!)
        }
    }
    
    mutating func dealThreeMoreCards() {
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
    
    mutating func select(card: SetCard) {
        // If it's a match and new card is selected...
        if matchState == .match {
            if card.matchState == .match { dealThreeMoreCards() }
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
        
        cardsOnTheTable.indices.forEach { cardsOnTheTable[$0].matchState = .normal }
        selectedCards.forEach { cardsOnTheTable[cardsOnTheTable.firstIndex(matching: $0)!].matchState = matchState }
    }
    
}
