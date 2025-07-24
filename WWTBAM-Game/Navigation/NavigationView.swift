//
//  NavigationView.swift
//  WWTBAM-Game
//
//  Created by Артур  Арсланов on 24.07.2025.
//

import SwiftUI

struct RootNavigationView: View {
    @State private var path: [Route] = []

    var body: some View {
        NavigationStack(path: $path) {
            SplashView {
                path.append(.mainMenu)
            }
            .navigationDestination(for: Route.self) { route in
                switch route {
                case .mainMenu:
                    MainMenuView { next in
                        path.append(next)
                    }
                    .toolbar(.hidden, for: .navigationBar)

                case .newGame:
                    GameView(model: MockData.correctAnswerState)
                        .toolbar(.hidden, for: .navigationBar)
                }
            }
        }
    }
}
