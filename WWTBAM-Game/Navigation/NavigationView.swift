//
//  NavigationView.swift
//  WWTBAM-Game
//
//  Created by Артур  Арсланов on 24.07.2025.
//

import SwiftUI

struct AppView: View {
    @StateObject private var router = Router()
    private let gameService = GameService.shared

    var body: some View {
        NavigationStack(path: $router.path) {
            SplashView()
                .navigationDestination(for: Route.self) { route in
                    switch route {
                    case .newGame(_):
                        MockGameView(router: router)
                            .toolbar(.hidden, for: .navigationBar)
    
                    case .mainMenu(let model):
                        MainMenuView(viewModel: model)
                            .toolbar(.hidden, for: .navigationBar)

                    case .resultView(let state):
                        GameProgresView(progress: state)
                            .toolbar(.hidden, for: .navigationBar)

                    case .finishGameView(let state):
                        FinishScreenView(state: state)
                            .toolbar(.hidden, for: .navigationBar)

                    }
                }
                
        }
        .environmentObject(router)
    }
}


