//
//  FeaturesOfASetCard.swift
//  Assignment 3
//
//  Created by Mert Arıcan on 5.07.2020.
//  Copyright © 2020 Mert Arıcan. All rights reserved.
//

import Foundation
    
    enum NumberOfShapes: Int, CaseIterable, CustomStringConvertible {
        case one=1
        case two
        case three
        
        var description: String {
            switch self {
            case .one: return "one"
            case .two: return "two"
            case .three: return "three"
            }
        }
    }
    
    enum CardShape: Int, CaseIterable, CustomStringConvertible {
        case diamond
        case squiggle
        case oval
        
        var description: String {
            switch self {
            case .diamond: return "diamond"
            case .squiggle: return "squiggle"
            case .oval: return "oval"
            }
        }
    }
    
    enum Shading: Int, CaseIterable, CustomStringConvertible {
        case solid
        case straped
        case open
        
        var description: String {
            switch self {
            case .open: return "open"
            case .solid: return "solid"
            case .straped: return "straped"
            }
        }
    }
    
    enum CardColor: Int, CaseIterable, CustomStringConvertible {
        case red
        case green
        case purple
        
        var description: String {
            switch self {
            case .red: return "red"
            case .green: return "green"
            case .purple: return "purple"
            }
        }
    }
    
