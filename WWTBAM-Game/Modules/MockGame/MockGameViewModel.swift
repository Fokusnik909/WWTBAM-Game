//
//  MockGameViewModel.swift
//  WWTBAM-Game
//
//  Created by Dmitry Volkov on 21/07/2025.
//

import SwiftUI
import Combine


@MainActor
class MockGameViewViewModel: ObservableObject {
    @Published private(set) var questionText = ""
    @Published private(set) var options = [String]()
    @Published private(set) var currentQuestion: Question?
    @Published private(set) var score = 0
    @Published private(set) var questionNumber = 0
    @Published private(set) var isGameOver = false

    private let service = GameService.shared
    private var cancellables = Set<AnyCancellable>()

    init() {
        service.$questionNumber
            .sink { [weak self] in self?.questionNumber = $0 }
            .store(in: &cancellables)
        
        service.$currentQuestion
            .sink { [weak self] in self?.currentQuestion = $0 }
            .store(in: &cancellables)
        
        service.$score
            .assign(to: &$score)
        
        service.$isGameOver
            .assign(to: &$isGameOver)
        
        service.startGame()
    }
    
    func choose(_ option: String) {
        let correct = service.checkAnswer(option)
        print("DEBUG: answer")
        print(correct)
    }
    
    func startGame() {
        service.startGame()
    }


}
