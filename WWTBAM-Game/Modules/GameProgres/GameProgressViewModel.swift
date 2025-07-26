//
//  GameProgressViewModel.swift
//  WWTBAM-Game
//
//  Created by Sergey on 21.07.2025.
//

import Foundation
import SwiftUI

enum GameState {
    case gameOverWin
    case gameOverLose
    case nextLevel
}

enum DestinationScreen {
    
    case gameOver
    case nextLevel

}

struct GameProgress {
    var state: GameState
    var numberOfQuestion: Int
    var amount: [String] = ["$ 500", "$ 1,000", "$ 2,000", "$ 3,000", "$ 5,000", "$ 7,500", "$ 10,000", "$ 12,500", "$ 15,000", "$ 25,000", "$ 50,000", "$ 100,000", "$ 250,000", "$ 500,000", "$ 1,000,000" ]
    var amountInt: [Int] = [500, 1000, 2000, 3000, 5000, 7500, 10000, 12500, 15000, 25000, 50000, 100000, 250000, 500000, 1000000]
}
