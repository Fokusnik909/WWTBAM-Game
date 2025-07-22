//
//  MainMenuViewModel.swift
//  WWTBAM-Game
//
//  Created by Николай Игнатов on 21.07.2025.
//
import Foundation

final class MainMenuViewModel: ObservableObject {
    @Published var bestScore: Int?
    @Published var isGameRunning: Bool = false

    init() {
        loadData()
    }

    func loadData() {
        bestScore = 15000
    }

    func startNewGame() {
        
    }

    func continueGame() {
        
    }
}
