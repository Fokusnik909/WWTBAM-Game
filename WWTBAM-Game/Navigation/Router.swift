//
//  Router.swift
//  WWTBAM-Game
//
//  Created by Sergey on 24.07.2025.
//

import Foundation
import SwiftUI

enum Route: Hashable {
    static func == (lhs: Route, rhs: Route) -> Bool {
        lhs.hashValue == rhs.hashValue
    }
    
    case mainMenu(model: MainMenuViewModel)
    case newGame(model: GameModel)
    case resultView(state: GameProgress)
    case finishGameView(state: FinishScreenState)
    
    func hash(into hasher: inout Hasher) {
        switch self {
            
        case .mainMenu(model: let model):
            hasher.combine(1)
        case .newGame(model: let model):
            hasher.combine(1)
        case .resultView(state: let state):
            hasher.combine(1)
        case .finishGameView(state: let state):
            hasher.combine(1)
        }
    }
    
}

@MainActor
final class Router: ObservableObject {
    
    @Published var path: [Route] = []
    func push(to route: Route) {
            path.append(route)
        }

        func navigateBack() {
            path.removeLast()
        }
    
        func popToRoot() {
            path.removeLast(path.count - 1)
        }

        func reset() {
            path = []
        }

}
