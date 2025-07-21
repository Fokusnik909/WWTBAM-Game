//
//  ContentView.swift
//  WWTBAM-Game
//
//  Created by Артур  Арсланов on 21.07.2025.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack(spacing: 20) {

            
            ArrowButton(
                title: "Button",
                style: .green,
                textColor: .white,
                font: .sfCompact(.semibold, size: 24),
                size: CGSize(width: 240, height: 60)
            ) {
                print("tapped")
            }
        }
        .padding()

    }
}

#Preview {
    ContentView()
}


