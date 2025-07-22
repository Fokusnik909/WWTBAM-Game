//
//  MockGameView.swift
//  WWTBAM-Game
//
//  Created by Dmitry Volkov on 21/07/2025.
//

import SwiftUI

struct MockGameView: View {
    @StateObject private var viewModel = MockGameViewViewModel()
    
    
    var body: some View {
        ZStack {
            Image("background")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
            
            
            VStack(spacing: 20) {
                
                if !viewModel.isGameOver {
                    
                    Text(viewModel.currentQuestion?.question ?? "")
                        .font(.title)
                        .padding()

                    ForEach(viewModel.currentQuestion?.options ?? [], id: \.self) { option in
                        Button(action: {
                            viewModel.choose(option)
                        }) {
                            Text(option)
                                .foregroundColor(.white)
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(
                                        viewModel.hiddenOptions.contains(option)
                                        ? Color.red
                                        : Color.blue
                                )
                                .cornerRadius(8)
                        }
                        .disabled(viewModel.hiddenOptions.contains(option))
                    }
                    
                    Button {
                        viewModel.highlightFiftyFifty()
                    } label: {
                        Text("50-50")
                            .foregroundStyle(.white)
                    }
                    .disabled(viewModel.usedFiftyFifty)
                }
                
                if viewModel.isGameOver {
                    Text("Game Over. Score: \(viewModel.score)")
                        .font(.headline)
                        .padding()
                    
                    Button {
                        viewModel.startGame()
                    } label: {
                        Text("Start a new game")
                    }
                }
            }
            .padding()
        }
        
    }
}

#Preview {
    MockGameView()
}
