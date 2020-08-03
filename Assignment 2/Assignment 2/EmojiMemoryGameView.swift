//
//  EmojiMemoryGameView.swift
//  Lecture 2
//
//  Created by Mert Arıcan on 25.06.2020.
//  Copyright © 2020 Mert Arıcan. All rights reserved.
//

import SwiftUI

struct EmojiMemoryGameView: View {
    @ObservedObject var viewModel: EmojiMemoryGame
    
    var body: some View {
        VStack {
            HStack {
                Grid(viewModel.cards) { card in
                    CardView(card: card, theme: self.viewModel.theme).onTapGesture() {
                        self.viewModel.choose(card: card)
                    }
                    .padding(5)
                }
            }
            
            HStack() {
                Button(action: {
                    self.viewModel.newGame()
                    }) { Text("New Game") }.padding()
                    .background(Color.black)
                    .border(Color.purple, width: 3.0)
                
                Text("\(viewModel.theme.name) Theme").padding()
                     .background(Color.black)
                     .border(Color.purple, width: 3.0)

                Text("Score \(viewModel.score)").padding()
                    .background(Color.black)
                    .border(Color.purple, width: 3.0)
            }
            
        }
        .padding()
        .foregroundColor(Color.orange)
    }
}

struct CardView: View {
    var card: MemoryGame<String>.Card
    
    let theme: Theme
    
    var body: some View {
        GeometryReader { geometry in
            self.body(for: geometry.size)
        }
    }
    
    func body(for size: CGSize) -> some View {
        ZStack {
            if self.card.isFaceUp {
                RoundedRectangle(cornerRadius: cornerRadius).fill(Color.white)
                RoundedRectangle(cornerRadius: cornerRadius).stroke(lineWidth: edgeLineWidth)
                Text(self.card.content)
            } else {
                if !card.isMatched {
                    fill(shape: RoundedRectangle(cornerRadius: cornerRadius), accordingTo: theme)
                }
            }
        }
        .font(Font.system(size: fontSize(for: size)))
    }
    
    
    // MARK: - Extra Credit
    
    func fill<S>(shape: S, accordingTo theme: Theme) -> AnyView where S: Shape {
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
    
    // MARK: - Drawing Constants
    
    let cornerRadius: CGFloat = 10.0
    let edgeLineWidth: CGFloat = 3
    
    func fontSize(for size: CGSize) -> CGFloat {
        min(size.width, size.height) * 0.7
    }
}



























struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        EmojiMemoryGameView(viewModel: EmojiMemoryGame())
    }
}
