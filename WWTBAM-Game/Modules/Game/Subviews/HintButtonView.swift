//
//  HintButtonView.swift
//  WWTBAM-Game
//
//  Created by Николай Игнатов on 22.07.2025.
//

import SwiftUI

struct HintButtonView: View {
    let hint: GameModel.Hint
    
    private var imageName: String? {
        switch hint.type {
        case .call: return "call"
        case .people: return "audience"
        case .fiftyFifty: return nil
        }
    }
    
    var body: some View {
        Button(action: {}) {
            ZStack {
                if let imageName = imageName {
                    Image(imageName)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 32, height: 32)
                } else {
                    Text("50:50")
                        .foregroundStyle(.white)
                        .font(.sfCompact(.semibold, size: 18))
                }
            }
            .frame(width: 84, height: 64)
            .background(GradientStyle.blueDark)
            .clipShape(Ellipse())
            .overlay(
                Ellipse().strokeBorder(Color.white, lineWidth: 3)
            )
            .overlay(
                Group {
                    if !hint.isEnabled {
                        Ellipse().fill(Color.black.opacity(0.6))
                    }
                }
            )
        }
        .disabled(!hint.isEnabled)
    }
}
