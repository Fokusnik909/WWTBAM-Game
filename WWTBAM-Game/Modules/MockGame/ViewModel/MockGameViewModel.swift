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
                .assign(to: &$currentQuestion)

            service.$score
                .receive(on: DispatchQueue.main)
                .assign(to: &$score)

            service.$isGameOver
                .receive(on: DispatchQueue.main)
                .assign(to: &$isGameOver)
    }
    
    func choose(_ option: String) {
        let isRight = service.checkAnswer(option)
        
        if isRight {
            router.push(to: .resultView(state: GameProgress(state: .nextLevel, numberOfQuestion: questionNumber + 1)))
        } else {
            router.push(to: .resultView(state: GameProgress(state: .gameOverLose, numberOfQuestion: questionNumber + 1)))
        }
        hiddenOptions = []
    }
    
    func startGame() {
        hiddenOptions = []
        usedFiftyFifty.toggle()
        service.startGame()
    }
    
    func highlightFiftyFifty() {
        guard let question = currentQuestion else { return }
        print("50-50")
        //let incorrectOptions = question.options.filter { $0 != question.answer }.shuffled()
        //hiddenOptions = Set(incorrectOptions.prefix(2))
        usedFiftyFifty.toggle()
    }


}
