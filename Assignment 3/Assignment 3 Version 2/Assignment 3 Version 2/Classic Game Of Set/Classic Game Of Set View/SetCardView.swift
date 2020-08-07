//
//  SetCardView.swift
//  Assignment 3 Version 2
//
//  Created by Mert Arıcan on 5.07.2020.
//  Copyright © 2020 Mert Arıcan. All rights reserved.
//

import SwiftUI

struct SetCardView: View {
    
    let card: Card
    
    var body: some View {
        GeometryReader { geometry in
            self.shade(of: CardContent(card: self.card), with: self.color)
                .aspectRatio(3/2, contentMode: .fit)
                .background(Color.white)
                .padding(3.0)
                .overlay(RoundedRectangle(cornerRadius: 8.0)
                    .stroke(self.strokeColor, lineWidth: 4.0)
                )
                .cornerRadius(8.0)
                .padding(5.0)
        }
    }
    
    private var strokeColor: Color {
        // Indicates selection and match states.
        if card.isMatch == .normal {
            return card.isSelected ? .blue : .orange
        } else {
            return (card.isMatch == .match) ? .green : .red
        }
    }
    
    private var color: Color {
        // Returns the color of the content of the card.
        switch card.getFeatureOfACard(with: FeatureLabels.color) as! CardColor {
        case .green: return .green
        case .purple: return .purple
        case .red: return .red
        }
    }
    
    private func shade(of cardContent: CardContent, with color: Color) -> AnyView {
        // Draws the shading of the card.
        switch card.getFeatureOfACard(with: FeatureLabels.shading) as! CardShading {
        case .open:
            return AnyView(cardContent.stroke(color))
        case .solid:
            return AnyView(cardContent.fill(color))
        case .straped:
            return AnyView(cardContent.stroke(color).clipShape(cardContent))
        }
    }
    
}

