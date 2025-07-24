//
//  MainMenuView.swift
//  WWTBAM-Game
//
//  Created by Артур  Арсланов on 21.07.2025.
//

import SwiftUI

struct MainMenuView: View {
    @StateObject private var viewModel: MainMenuViewModel
    @State private var isShowingRulesSheet = false
    
    var navigate: (Route) -> Void
    
    init(viewModel: MainMenuViewModel, navigate: @escaping (Route) -> Void) {
        _viewModel = StateObject(wrappedValue: viewModel)
        self.navigate = navigate
    }
    
    var body: some View {
        ZStack {
            Image(.background)
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
            
            VStack(spacing: 16) {
                Spacer()
                
                Image(.logo)
                    .frame(width: 195, height: 195)
                    .padding(24)
                
                Text("Who Wants\nto Be a Millionaire")
                    .font(.sfCompact(.semibold, size: 32))
                    .multilineTextAlignment(.center)
                    .foregroundColor(.white)
                
                if let score = viewModel.bestScore {
                    VStack {
                        Text("All-time Best Score")
                            .foregroundColor(.white.opacity(0.5))
                        
                        HStack {
                            Image(systemName: "dollarsign.circle.fill")
                                .foregroundColor(.yellow)
                                .font(.system(size: 24))
                            Text("$\(score)")
                                .font(.sfCompact(.semibold, size: 24))
                                .padding(1)
                                .foregroundColor(.white)
                        }
                    }
                }
                
                Spacer()
                
                ArrowButton(title: "Continue game",
                            style: .gold, font: .sfCompact(.semibold, size: 24),
                            size: CGSize(width: 311, height: 60)) {
                    print("Continue game")
                }
                .opacity(viewModel.isGameRunning ? 1 : 0)
                .disabled(!viewModel.isGameRunning)
                
                ArrowButton(title: "New Game",
                            style: viewModel.isGameRunning ? .blueDark : .gold,
                            font: .sfCompact(.semibold, size: 24),
                            size: CGSize(width: 311, height: 60)) {
                    navigate(.newGame)
                }
                
                Spacer()
            }

            .overlay(alignment: .topTrailing) {
                Button(action: {
                    isShowingRulesSheet = true
                }) {
                    Image(systemName: "questionmark.circle.fill")
                        .foregroundColor(.white)
                        .font(.system(size: 32))
                        .padding()
                }
                .padding(.top, -16)
                .padding(.trailing, -32)
            }
        }
        .sheet(isPresented: $isShowingRulesSheet) {
            RulesView()
        }
    }
}

#Preview {
    MainMenuView(viewModel: MainMenuViewModel(), navigate: {_ in })
}
