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

            
            CustomAnswerButton(
                text: "Answer 1",
                width: 240,
                height: 50,
                gradient: LinearGradient(
                    colors: [Color.yellow, Color.orange],
                                            startPoint: .top,
                                            endPoint: .bottom
                                        ),
                textColor: .white
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


