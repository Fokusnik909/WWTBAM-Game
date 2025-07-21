//
//  GameProgresView.swift
//  WWTBAM-Game
//
//  Created by Sergey on 21.07.2025.
//

import SwiftUI

struct GameProgresView: View {
    @State private var gameLogo = "logo1"
    @State private var dollarLogo = "withdrawal"
    @State private var amount: [String] = ["$ 500", "$ 1,000", "$ 2,000", "$ 3,000", "$ 5,000", "$ 7,500", "$ 10,000", "$ 12,500", "$ 15,000", "$ 25,000", "$ 50,000", "$ 100,000", "$ 250,000", "$ 500,000", "$ 1,000,000" ]
    var body: some View {
        ZStack(alignment: .center) {
            
            Image("background")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
            VStack {
                Spacer(minLength: 85)
                ZStack{
                    VStack(alignment: .center, spacing: 1) {
                        
                        ForEach(-15..<0) { index in
                            
                            switch index {
                            case -5, -10:
                                GameStateLabel(title: String(0-index), prize: amount[0-index-1], style: .skyBlue) {
                                    
                                }
                                .padding(11)
                            case -15:
                                
                                GameStateLabel(title: String(0-index), prize: amount[0-index-1], style: .gold) {
                                    
                                }
                                .padding(11)
                            default:
                                
                                GameStateLabel(title: String(0-index), prize: amount[0-index-1], style: .blueDark) {
                                    
                                }
                                .padding(11)
                            }
                            
                        }
                    }
                    Image(dollarLogo)
                        .resizable()
                        .frame(width: 45, height: 45)
                        .offset(x:-165, y: -420)
                    Image(gameLogo)
                        .resizable()
                        .frame(width: 250, height: 250)
                        .offset(x:0, y: -360)
                        
                }
                Spacer()
            }
            
        }
    }
    
}

#Preview {
    GameProgresView()
}
