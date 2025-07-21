//
//  CustomButton.swift
//  WWTBAM-Game
//
//  Created by Артур  Арсланов on 21.07.2025.
//
import SwiftUI

struct CustomAnswerButton: View {
    var text: String
    var width: CGFloat
    var height: CGFloat
    var gradient: LinearGradient
    var textColor: Color
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
                AnswerShape()
                    .fill(gradient)
                    .frame(width: width, height: height)
                    .shadow(color: .black.opacity(0.25), radius: 4, x: 0, y: 2)

                HStack(spacing: 4) {
                    Text("A:")
                        .bold()
                    Text(text)
                }
                .foregroundColor(textColor)
            }
            .scaleEffect(isPressed ? 0.96 : 1.0) // эффект нажатия
            .animation(.spring(response: 0.2, dampingFraction: 0.6), value: isPressed)
        }
        .buttonStyle(PlainButtonStyle())
    }
}


struct AnswerShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()

        let arrowDepth: CGFloat = 20

        path.move(to: CGPoint(x: rect.minX + arrowDepth, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.maxX - arrowDepth, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.midY))
        path.addLine(to: CGPoint(x: rect.maxX - arrowDepth, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.minX + arrowDepth, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.midY))
        path.closeSubpath()

        return path
    }
}

//Example

//CustomAnswerButton(
//    text: "New Game",
//    width: 240,
//    height: 50,
//    gradient: LinearGradient(
//        colors: [Color.yellow, Color.orange],
//                                startPoint: .top,
//                                endPoint: .bottom
//                            ),
//    textColor: .white
//) {
//    print("tapped")
//}


