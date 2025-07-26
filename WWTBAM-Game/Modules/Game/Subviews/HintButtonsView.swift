//
//  HintButtonsView.swift
//  WWTBAM-Game
//
//  Created by Николай Игнатов on 22.07.2025.
//

import SwiftUI

struct HintButtonsView: View {
    @Binding var hints: [GameModel.Hint]
    var onCallTapped: (() -> Void)? = nil
    var onAudienceTapped: (() -> Void)? = nil
    //let onFiftyFiftyTapped: () -> Void
    
    var body: some View {
        HStack(spacing: 20) {
            ForEach(Array(hints.enumerated()), id: \.element.type) { index, hint in
                HintButtonView(hint: hint) {
                    switch hint.type {
                    case .call:
                        onCallTapped?()
                    case .people:
                        onAudienceTapped?()
                    case .fiftyFifty:
                        // TODO: Add 50:50 logic
                        break
                    }
                    hints[index] = GameModel.Hint(isEnabled: false, type: hint.type)
                }
            }
        }
    }
}
