//
//  HintButtonView.swift
//  WWTBAM-Game
//
//  Created by Николай Игнатов on 22.07.2025.
//

import SwiftUI

// FIXME: - Переделать
struct HintButtonView: View {
    let hint: GameModel.Hint
    
    private var imageName: String {
        switch hint.type {
        case .call: return "phone"
        case .people: return "person.3"
        case .fiftyFifty: return "50.circle"
        }
    }
    
    var body: some View {
        Button(action: {}) {
            Image(systemName: imageName)
                .foregroundColor(.white)
                .padding()
                .background(hint.isEnabled ? Color.blue : Color.gray)
                .clipShape(Circle())
        }
        .disabled(!hint.isEnabled)
    }
}
