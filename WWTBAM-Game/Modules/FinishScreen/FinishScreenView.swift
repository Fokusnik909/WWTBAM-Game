//
//  FinishScreenView.swift
//  WWTBAM-Game
//
//  Created by Sergey on 24.07.2025.
//

import SwiftUI

struct FinishScreenView: View {
    
    @EnvironmentObject private var router: Router
    
    @State private var gameLogo = "logo1"
    @State private var dolLogo = "finishDol"
    
    
    @State var state: FinishScreenState
    
    var body: some View {
        ZStack {
            Image("background")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
            Image(gameLogo)
                .resizable()
                .frame(width: 500, height: 500)
                .offset(x:0, y: -170)
                
            VStack {
                Text("Game Over")
                    .foregroundColor(Color.white)
                    .font(.largeTitle.weight(.heavy))
                
                Text("Level \(state.level)")
                    .foregroundColor(Color.white)
                    .font(.title.weight(.bold))
                HStack{
                    Spacer()
                    Image(dolLogo)
                        .resizable()
                        .frame(width: 60,height: 60)
                        
                    Text(state.score)
                        .foregroundColor(Color.white)
                        .font(.title.weight(.black))
                    Spacer()
                    
                }
                
                ArrowFinishButton(title: "New game", style: .blueDark) {
                    
                    router.push(to: .newGame(model: MockData.correctAnswerState))
                    
                }
                
                .padding()
                
                ArrowFinishButton(title: "Main screen", style: .blueDark) {

                    router.popToRoot()
                    
                }
                
            }
            .offset(x: 0, y: 150)
        }
    }
}

#Preview {
    FinishScreenView(state: FinishScreenState(level: 10, score: "$ 15.000"))
        .environmentObject(Router())
}
