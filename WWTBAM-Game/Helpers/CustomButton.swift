//
//  CustomButton.swift
//  WWTBAM-Game
//
//  Created by Артур  Арсланов on 21.07.2025.
//
import SwiftUI

struct ArrowButton: View {
    var title: String
    var style: AnswerColorStyle
    var textColor: Color = .white
    var font: Font = .headline
    var size: CGSize = CGSize(width: 200, height: 60)
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
                            .stroke(style.borderColor, lineWidth: 2)
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


struct ArrowShape: Shape {
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

enum AnswerColorStyle {
    case gold
    case blueDark
    case skyBlue
    case green
    case red

    var gradient: LinearGradient {
        switch self {
        case .gold:
            return GradientStyle.gold
        case .blueDark:
            return GradientStyle.blueDark
        case .skyBlue:
            return GradientStyle.skyBlue
        case .green:
            return GradientStyle.green
        case .red:
            return GradientStyle.red
        }
    }

    var borderColor: Color {
        switch self {
        case .gold: return Color(hex: "#C7A91C")
        case .blueDark: return Color(hex: "#011E3D")
        case .skyBlue: return Color(hex: "#1179B2")
        case .green: return Color(hex: "#266608")
        case .red: return Color(hex: "#B43E19")
        }
    }
}

//Example

//ArrowButton(
//    title: "Button",
//    style: .green,
//    textColor: .white,
//    font: .sfCompact(.semibold, size: 24),
//    size: CGSize(width: 240, height: 60)
//) {
//    print("tapped")
//}


