//
//  FinishCustomButton.swift
//  WWTBAM-Game
//
//  Created by Sergey on 24.07.2025.
//

import SwiftUI

struct ArrowFinishButton: View {
    var title: String
    var style: AnswerColorStyle
    var textColor: Color = .white
    var font: Font = .headline
    var size: CGSize = CGSize(width: 350, height: 60)
    var action: () -> Void

    @State private var isPressed = false

    var body: some View {
        Button(action: {
            withAnimation(.easeInOut(duration: 0.1)) {
                isPressed = true
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                isPressed = false
                action()
            }
        }) {
            ZStack {
                ArrowShape()
                    .fill(style.gradient)
                    .frame(width: size.width, height: size.height)
                    .overlay(
                        ArrowShape()
                            .stroke(Color.white, lineWidth: 3)
                    )
                    .shadow(color: .black.opacity(0.25), radius: 4, x: 0, y: 2)

                HStack(spacing: 4) {
                    Text(title)
                }
                .foregroundColor(textColor)
                .font(font)
            }
            .scaleEffect(isPressed ? 0.96 : 1.0)
            .animation(.spring(response: 0.2, dampingFraction: 0.6), value: isPressed)
        }
        .buttonStyle(PlainButtonStyle())
    }
}




