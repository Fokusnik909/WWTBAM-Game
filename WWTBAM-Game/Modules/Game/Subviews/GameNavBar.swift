//
//  GameNavBar.swift
//  WWTBAM-Game
//
//  Created by Николай Игнатов on 22.07.2025.
//

import SwiftUI

struct GameNavBar: View {
    @EnvironmentObject private var router: Router
    let title: String
    let price: String
    
    var body: some View {
        HStack {
            Button(action: {
                router.popToRoot()
            }) {
                Image(systemName: "arrow.left")
                    .foregroundColor(.white)
                    .frame(width: 32, height: 32)
            }
            Spacer()
            VStack(spacing: 2) {
                Text(title)
                    .font(.caption)
                    .foregroundColor(.white.opacity(0.8))
                Text(price)
                    .font(.headline)
                    .foregroundColor(.white)
            }
            Spacer()
            Button(action: {}) {
                Image(.barChart)
                    .foregroundColor(.white)
                    .frame(width: 32, height: 32)
            }
        }
        .padding(.horizontal)
    }
}
