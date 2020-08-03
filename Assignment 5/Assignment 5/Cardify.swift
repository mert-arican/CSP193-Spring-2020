//
//  Cardify.swift
//  Lecture 5 ViewBuilder + Shape + ViewModifier
//
//  Created by Mert Arıcan on 28.06.2020.
//  Copyright © 2020 Mert Arıcan. All rights reserved.
//

import SwiftUI

struct Cardify: AnimatableModifier {
    var rotation: Double
    
    let theme: Theme
    
    init(isFaceUp: Bool, theme: Theme) {
        rotation = isFaceUp ? 0 : 180
        self.theme = theme
    }
    
    var isFaceUp: Bool {
        rotation < 90
    }
    
    var animatableData: Double {
        get { return rotation }
        set { rotation = newValue }
    }
    
    func body(content: Content) -> some View {
        
        ZStack {
            Group {
                RoundedRectangle(cornerRadius: cornerRadius).fill(Color.white)
                RoundedRectangle(cornerRadius: cornerRadius).stroke(lineWidth: edgeLineWidth)
                content
            }
                .opacity(isFaceUp ? 1 : 0)
            fill(shape: RoundedRectangle(cornerRadius: cornerRadius), accordingTo: theme)
                .opacity(isFaceUp ? 0 : 1)
        }
        .rotation3DEffect(Angle.degrees(rotation), axis: (x: 0, y: 1, z: 0))
    }
    
    private let cornerRadius: CGFloat = 10.0
    private let edgeLineWidth: CGFloat = 3
    
    // MARK: - Extra Credit From Previous Assignment (Assignment 2)
    
    func fill<T>(shape: T, accordingTo theme: Theme) -> AnyView where T: Shape {
        switch theme.color {
        case .blue:
            return AnyView(shape.fill(Color.blue))
        case .brown:
            return AnyView(shape.fill(LinearGradient(gradient: Gradient(colors: [.black, .blue, .green]), startPoint: .top, endPoint: .bottom)))
        case .green:
            return AnyView(shape.fill(Color.green))
        case .orange:
            return AnyView(shape.fill(Color.orange))
        case .red:
            return AnyView(shape.fill(Color.red))
        case .yellow:
            return AnyView(shape.fill(Color.yellow))
        }
    }
}

extension View {
    func cardify(isFaceUp: Bool, theme: Theme) -> some View {
        self.modifier(Cardify(isFaceUp: isFaceUp, theme: theme))
    }
}
