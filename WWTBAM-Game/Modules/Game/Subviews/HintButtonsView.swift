//
//  HintButtonsView.swift
//  WWTBAM-Game
//
//  Created by Николай Игнатов on 22.07.2025.
//

import SwiftUI

struct HintButtonsView: View {
    let hints: [GameModel.Hint]
    
    var body: some View {
        HStack(spacing: 20) {
            ForEach(hints, id: \.type) { hint in
                HintButtonView(hint: hint)
            }
        }
    }
}
