//
//  AnswerButtonMock.swift
//  WWTBAM-Game
//
//  Created by Dmitry Volkov on 22/07/2025.
//

import SwiftUI

struct AnswerButtonMock: View {
    let index: Int
    let text: String
    let state: Question.AnswerState
    let isHidden: Bool
    let action: () -> Void
    
    @State private var isPressed = false
    
    private var label: String {
        ["A", "B", "C", "D"][index]
    }
    
    private var style: AnswerColorStyle {
        switch state {
        case .normal: return .blueDark
        case .correct: return .green
        case .incorrect: return .red
        case .disabled: return .blueDark
        }
    }
    
    var body: some View {
        Button(action: {
            guard state != .disabled else { return }
            withAnimation(.easeInOut(duration: 0.1)) {
                isPressed = true
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                isPressed = false
                action()
            }
        }) {
            ZStack(alignment: .leading) {
                ArrowShape()
                    .fill(style.gradient)
                    .frame(maxWidth: .infinity, maxHeight: 60)
                    .overlay(
                        ArrowShape().stroke(style.borderColor, lineWidth: 2)
                    )
                    .overlay(
                        ArrowShape().stroke(Color.white, lineWidth: 2)
                    )
                    .shadow(color: .black.opacity(0.25), radius: 4, x: 0, y: 2)
                
                HStack(spacing: 8) {
                    Text("\(label):")
                        .bold()
                        .foregroundColor(Color(hex: "#E19B30"))
                    
                    if state != .disabled {
                        if isHidden {
                            Text(" ")
                                .foregroundColor(.white.opacity(0.5))
                        } else {
                            Text(text)
                                .foregroundColor(.white)
                                .lineLimit(2)
                                .multilineTextAlignment(.leading)
                        }
                    }
                }
                .padding(.horizontal, 24)
                .font(.headline)
            }
            .scaleEffect(isPressed ? 0.96 : 1.0)
            .animation(.spring(response: 0.2, dampingFraction: 0.6), value: isPressed)
        }
        .buttonStyle(PlainButtonStyle())
        .disabled(state == .disabled || isHidden)
    }
}

