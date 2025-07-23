//
//  GameService.swift
//  WWTBAM-Game
//
//  Created by Dmitry Volkov on 21/07/2025.
//

import Foundation


class GameService: ObservableObject {
    static let shared = GameService()
    
    // MARK: — Публичные состояние для UI
    @Published private(set) var questionNumber = 0
    @Published private(set) var currentQuestion: Question?
    @Published private(set) var score = 0
    @Published private(set) var isGameOver = false
    
    // MARK: — Вопросы
    private(set) var questions = [Question]()
    
    
    // MARK: — Запуск новой игры
    func startGame() {
        score = 0
        questionNumber = 0
        isGameOver = false
        
        makeQuestions()
        loadNextQuestion()
        
    }
    
    // MARK: — Генерация вопросов
    func makeQuestions() {
        let easyQuestions = Array(
            MockQuestions.questions
                .filter { $0.difficulty == "Easy" }
                .shuffled()
                .prefix(5)
        )
        
        let mediumQuestions = Array(
            MockQuestions.questions
                .filter { $0.difficulty == "Medium" }
                .shuffled()
                .prefix(5)
        )
        
        let hardQuestions = Array(
            MockQuestions.questions
                .filter { $0.difficulty == "Hard" }
                .shuffled()
                .prefix(5)
        )
        
        questions.append(contentsOf: easyQuestions)
        questions.append(contentsOf: mediumQuestions)
        questions.append(contentsOf: hardQuestions)
    }
    
    
    // MARK: — Переход к следующему вопросу
    func loadNextQuestion() {
        guard questionNumber < 15 else {
            isGameOver = true
            currentQuestion = nil
            return
        }
        
        currentQuestion = questions[questionNumber]
        currentQuestion?.options = questions[questionNumber].options.shuffled()
    }

    
    // MARK: — Проверка ответа
    func checkAnswer(_ answer: String) -> Bool {
        guard !isGameOver else { return false }
        guard let correct = currentQuestion?.answer else { return false }

        let isCorrect = (answer == correct)

        if isCorrect {
            if let index = currentQuestion?.options.firstIndex(where: { $0.answerText == correct }) {
                currentQuestion?.options[index].state = .correct
            }

            score += 1
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                self.questionNumber += 1
                self.loadNextQuestion()
            }

        } else {
            isGameOver = true
            
            if let index = currentQuestion?.options.firstIndex(where: { $0.answerText == answer }) {
                currentQuestion?.options[index].state = .incorrect
            }
            
            if let index = currentQuestion?.options.firstIndex(where: { $0.answerText == correct }) {
                currentQuestion?.options[index].state = .correct
            }
        }

        return isCorrect
    }
}
