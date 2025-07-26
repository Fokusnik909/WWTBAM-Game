//
//  TimerView.swift
//  WWTBAM-Game
//
//  Created by Николай Игнатов on 22.07.2025.
//

import SwiftUI

struct TimerView: View {
    @ObservedObject var timer: TimerService

    private var color: Color {
        switch timer.remainingTime {
        case 0..<10: return .red
        case 10..<20: return Color(hex: "#FFB340")
        default: return .white
        }
    }

    var body: some View {
        HStack {
            Image(.clock)
                .renderingMode(.template)
                .foregroundColor(color.opacity(0.8))
            Text("\(timer.remainingTime)")
                .foregroundColor(color.opacity(0.8))
                .bold()
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 8)
        .background(color.opacity(0.3))
        .clipShape(Capsule())
    }
}

