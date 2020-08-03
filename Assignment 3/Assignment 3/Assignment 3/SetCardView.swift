//
//  SetCardView.swift
//  Assignment 3
//
//  Created by Mert Arıcan on 5.07.2020.
//  Copyright © 2020 Mert Arıcan. All rights reserved.
//

import SwiftUI

struct SetCardView: View {
    
    let card: SetCard
    
    var body: some View {
        GeometryReader { geometry in
            self.shade(of: CardContent(card: self.card), with: self.color)
                .aspectRatio(3/2, contentMode: .fit)
                .background(Color.white)
                .padding(3.0)
                .border(self.strokeColor, width: 3.0)
                .animation(.easeInOut(duration: 0.2))
                .cornerRadius(8.0)
                .padding(2.5)
        }
    }
    
    // Indicates selection and match states of a card.
    private var strokeColor: Color {
        if card.matchState == .normal {
            return card.isSelected ? .blue : .orange
        } else {
            return (card.matchState == .match) ? .green : .red
        }
    }
    
    // Returns the color of the card content.
    private var color: Color {
        switch CardColor(rawValue: card.allFeaturesAsRawValues[3])! {
        case .green: return .green
        case .purple: return .purple
        case .red: return .red
        }
    }
    
    // MARK: - Extra Credit For Stripes
    
    private func shade(of cardContent: CardContent, with color: Color) -> AnyView {
        switch Shading(rawValue: card.allFeaturesAsRawValues[2])! {
        case .open:
            return AnyView(cardContent.stroke(color))
        case .solid:
            return AnyView(cardContent.fill(color))
        case .straped:
            return AnyView(cardContent.stroke(color).clipShape(cardContent))
        }
    }
    
}

