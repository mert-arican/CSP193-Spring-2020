//
//  GameOfSetMainView.swift
//  Assignment 3
//
//  Created by Mert Arıcan on 2.07.2020.
//  Copyright © 2020 Mert Arıcan. All rights reserved.
//

import SwiftUI

struct GameOfSetMainView: View {
    
    @ObservedObject var viewModel = SetViewModel()
    @State private var isInitial = true
    
    var body: some View {
        Group {
            
            Grid(isInitial ? [SetCard]() : viewModel.cardsOnTheTable) { card in
                SetCardView(card: card).onTapGesture {
                    withAnimation(.easeInOut(duration: 1.5)) {
                        self.viewModel.select(card: card)
                    }
                }.transition(AnyTransition.offset(self.randomSize))
            }
            
            .onAppear() {
                withAnimation(.easeInOut(duration: 1.0)) {
                    self.isInitial.toggle()
                }
            }
            
            HStack(spacing: 20.0) {
                Button(action: {
                    withAnimation(.easeInOut(duration: 1.5)) {
                        self.viewModel.dealThreeMoreCards()
                    }
                }) { Text("3 More Cards") }
                    .padding(30)
                    .background(Color.gray)
                    .cornerRadius(10.0)
                    .disabled(viewModel.deckIsEmpty)
               
                Button(action: {
                    withAnimation(.easeInOut(duration: 1.0)) {
                        self.isInitial.toggle()
                    }
                    withAnimation(.easeInOut(duration: 2.0)) {
                        self.isInitial.toggle()
                        self.viewModel.newGame()
                    }
                }) { Text("New Game") }
                    .padding(30)
                    .background(Color.gray)
                    .cornerRadius(10.0)
            }
            .padding()
        }
    }
    
}

extension GameOfSetMainView {
    private var randomSize: CGSize {
        let isEven = Int.random(in: 0...1) % 2 == 0
        let randomSize = CGSize(width: isEven ? Int.random(in: 1000...2000) : -Int.random(in: 1000...2000), height: isEven ? Int.random(in: 1000...2000) : -Int.random(in: 1000...2000))
        return randomSize
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        GameOfSetMainView(viewModel: SetViewModel())
    }
}
