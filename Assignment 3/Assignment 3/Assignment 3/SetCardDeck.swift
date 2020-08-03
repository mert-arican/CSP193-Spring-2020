//
//  SetCardDeck.swift
//  Assignment 3
//
//  Created by Mert Arıcan on 2.07.2020.
//  Copyright © 2020 Mert Arıcan. All rights reserved.
//

import Foundation

struct SetCardDeck {
    
    private(set) var deck = [SetCard]()
    
    init() {
        for number in NumberOfShapes.allCases {
            for shape in CardShape.allCases {
                for shading in Shading.allCases {
                    for color in CardColor.allCases {
                        let card = SetCard(numberOfShapes: number, shape: shape, shading: shading, color: color, id: deck.count)
                        deck.append(card)
                    }
                }
            }
        }
        deck.shuffle()
    }
    
}

enum MatchState {
    case match, mismatch, normal
}
