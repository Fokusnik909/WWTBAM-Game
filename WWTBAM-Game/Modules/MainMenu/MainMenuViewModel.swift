//
//  MainMenuViewModel.swift
//  WWTBAM-Game
//
//  Created by Николай Игнатов on 21.07.2025.
//
import Foundation
import SwiftUI

final class MainMenuViewModel: ObservableObject {
    @Published var bestScore: Int?
    @Published var isGameRunning: Bool = false
    @AppStorage("hightScore") var hightScore: Int = 0

    init() {
        loadData()
    }

    func loadData() {
        bestScore = hightScore
    }

    func startNewGame() {
        
    }

    func continueGame() {
        
    }
}
