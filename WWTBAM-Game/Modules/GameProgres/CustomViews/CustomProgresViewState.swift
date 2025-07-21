//
//  CustomProgresViewState.swift
//  WWTBAM-Game
//
//  Created by Sergey on 21.07.2025.
//

import SwiftUI

struct GameStateLabel: View {
    var title: String
    var prize: String
    var style: LabelColorStyle
    var textColor: Color = .white
    var font: Font = .headline
    var size: CGSize = CGSize(width: 350, height: 40)
    var action: () -> Void
    
    
    var body: some View {
        
        Text(title+":")
            .overlay {
                ZStack {
                    ArrowLabelShape()
                        .fill(style.gradient)
                        .frame(width: size.width, height: size.height)
                        .overlay(
                            ArrowLabelShape()
                                .stroke(Color.white, lineWidth: 3)
                        )
                        .shadow(color: .black.opacity(0.25), radius: 4, x: 0, y: 2)
                    
                    HStack() {
                        Text(title+":")
                            .padding(.leading, 25)
                    Spacer()
                        Text(prize)
                            .padding(.trailing, 25)
                    }
                    .foregroundColor(textColor)
                    .font(font)
                }
            }
    }
}


struct ArrowLabelShape: Shape {
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

enum LabelColorStyle {
    case gold
    case blueDark
    case skyBlue
    case green
    
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
        }
    }
    
    var borderColor: Color {
        switch self {
        case .gold: return Color(hex: "#C7A91C")
        case .blueDark: return Color(hex: "#011E3D")
        case .skyBlue: return Color(hex: "#1179B2")
        case .green: return Color(hex: "#266608")
        }
    }
}
