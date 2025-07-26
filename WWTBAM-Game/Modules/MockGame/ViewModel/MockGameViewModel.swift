//
//  MockGameViewModel.swift
//  WWTBAM-Game
//
//  Created by Dmitry Volkov on 21/07/2025.
//

import SwiftUI
import Combine


@MainActor
final class MockGameViewViewModel: ObservableObject {
    @Published var timerService = TimerService()

    @Published private(set) var questionText = ""
    @Published private(set) var options = [String]()
    @Published private(set) var currentQuestion: Question?
    @Published private(set) var score = 0
    @Published private(set) var questionNumber = 0
    @Published private(set) var isGameOver = false
    @Published var hiddenOptions: Set<String> = []
    @Published var usedFiftyFifty = false

    private let service = GameService.shared
    private let router: Router
    private var cancellables = Set<AnyCancellable>()

    init(router: Router) {
        self.router = router
        bind()
        service.startGame()
    }

    private func bind() {
        service.$questionNumber
            .receive(on: DispatchQueue.main)
            .assign(to: &$questionNumber)

        service.$currentQuestion
            .receive(on: DispatchQueue.main)
            .sink { [weak self] question in
                self?.currentQuestion = question
                // Перезапуск таймера
                if question != nil {
                    self?.timerService.start(duration: 30)
                }
            }
            .store(in: &cancellables)

        service.$score
            .receive(on: DispatchQueue.main)
            .assign(to: &$score)

        service.$isGameOver
            .receive(on: DispatchQueue.main)
            .sink { [weak self] isOver in
                self?.isGameOver = isOver
                if isOver {
                    self?.timerService.stop()
                }
            }
            .store(in: &cancellables)

        // Окончание времени
        timerService.$remainingTime
            .filter { $0 == 0 }
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                self?.handleTimeIsUp()
            }
            .store(in: &cancellables)
    }

    func choose(_ option: String) {
        timerService.stop()

        let isRight = service.checkAnswer(option)
        if isRight {
            router.push(to: .resultView(state: GameProgress(state: .nextLevel,
                                                            numberOfQuestion: questionNumber + 1)))
        } else {
            router.push(to: .resultView(state: GameProgress(state: .gameOverLose,
                                                            numberOfQuestion: questionNumber + 1)))
        }
        hiddenOptions = []
    }

    func startGame() {
        hiddenOptions = []
        usedFiftyFifty = false
        service.startGame()
    }

    func highlightFiftyFifty() {
        guard let _ = currentQuestion else { return }
        usedFiftyFifty.toggle()
    }

    private func handleTimeIsUp() {
        // Время вышло
        router.push(to: .resultView(state: GameProgress(state: .gameOverLose,
                                                        numberOfQuestion: questionNumber + 1)))
    }
    
    func generateAudienceHelpPercentages(correctAnswer: String, options: [String]) -> [(String, Int)] {
        guard !options.isEmpty else { return [] }
        let correctPercent = Int.random(in: 70...75)
        let remainingPercent = 100 - correctPercent

        let wrongOptions = options.filter { $0 != correctAnswer }
        let wrongCount = wrongOptions.count

        var percentages = [(String, Int)]()
        var allocatedPercent = 0

        for (index, option) in wrongOptions.enumerated() {
            let percent: Int
            if index == wrongCount - 1 {
                percent = remainingPercent - allocatedPercent
            } else {
                let maxPercent = remainingPercent - allocatedPercent - (wrongCount - index - 1)
                percent = Int.random(in: 1...maxPercent)
                allocatedPercent += percent
            }
            percentages.append((option, percent))
        }
        percentages.append((correctAnswer, correctPercent))
        percentages.shuffle()
        return percentages
    }
}
