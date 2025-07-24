//
//  GameViewModel.swift
//  WWTBAM-Game
//
//  Created by Николай Игнатов on 21.07.2025.
//

import Foundation

final class GameViewModel {
    private let networkService: NetworkService
    private var allQuestions: [Response.Question] = []
    
    init(networkService: NetworkService) {
        self.networkService = networkService
        loadQuestions()
    }
}

private extension GameViewModel {
    func loadQuestions() {
        Task {
            do {
                let questions = try await networkService.fetchQuestions()
                allQuestions = questions
            } catch {
                print("Failed to load questions: \(error.localizedDescription)")
            }
        }
    }
}
