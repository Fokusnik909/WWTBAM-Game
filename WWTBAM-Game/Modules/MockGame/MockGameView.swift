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
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(Color.white.opacity(0.2))
                                .cornerRadius(8)
                        }
                    }
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
