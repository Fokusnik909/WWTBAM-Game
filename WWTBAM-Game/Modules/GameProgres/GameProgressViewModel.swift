//
//  GameProgressViewModel.swift
//  WWTBAM-Game
//
//  Created by Sergey on 21.07.2025.
//

import Foundation

enum GameState {
    case gameOverWin
    case gameOverLose
    case nextLevel
}

struct GameProgress {
    var state: GameState
    var numberOfQuestion: Int
    var amount: [String] = ["$ 500", "$ 1,000", "$ 2,000", "$ 3,000", "$ 5,000", "$ 7,500", "$ 10,000", "$ 12,500", "$ 15,000", "$ 25,000", "$ 50,000", "$ 100,000", "$ 250,000", "$ 500,000", "$ 1,000,000" ]
    
    func saveGameScore(numberOfQuestion: Int) {
        
        
        
    }
}
