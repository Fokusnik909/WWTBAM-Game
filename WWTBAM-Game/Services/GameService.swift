//
//  GameService.swift
//  WWTBAM-Game
//
//  Created by Dmitry Volkov on 21/07/2025.
//

import Foundation

struct Question {
    var question: String
    var answer: String
    var options: [String]
    var difficulty: String
}

struct MockQuestions {
    static let questions = [
        Question(question: "Легкий вопрос? 1", answer: "BA", options: ["BA", "Moscow", "Rostov", "Tigre"], difficulty: "Easy"),
        Question(question: "Легкий вопрос? 2", answer: "BA", options: ["BA", "Moscow", "Rostov", "Tigre"], difficulty: "Easy"),
        Question(question: "Легкий вопрос? 3", answer: "BA", options: ["BA", "Moscow", "Rostov", "Tigre"], difficulty: "Easy"),
        Question(question: "Легкий вопрос? 4", answer: "BA", options: ["BA", "Moscow", "Rostov", "Tigre"], difficulty: "Easy"),
        Question(question: "Легкий вопрос? 5", answer: "BA", options: ["BA", "Moscow", "Rostov", "Tigre"], difficulty: "Easy"),
        Question(question: "Легкий вопрос? 6", answer: "BA", options: ["BA", "Moscow", "Rostov", "Tigre"], difficulty: "Easy"),
        Question(question: "Легкий вопрос? 7", answer: "BA", options: ["BA", "Moscow", "Rostov", "Tigre"], difficulty: "Easy"),
        Question(question: "Средний вопрос? 1", answer: "BA", options: ["BA", "Moscow", "Rostov", "Tigre"], difficulty: "Medium"),
        Question(question: "Средний вопрос? 2", answer: "BA", options: ["BA", "Moscow", "Rostov", "Tigre"], difficulty: "Medium"),
        Question(question: "Средний вопрос? 3", answer: "BA", options: ["BA", "Moscow", "Rostov", "Tigre"], difficulty: "Medium"),
        Question(question: "Средний вопрос? 4", answer: "BA", options: ["BA", "Moscow", "Rostov", "Tigre"], difficulty: "Medium"),
        Question(question: "Средний вопрос? 5", answer: "BA", options: ["BA", "Moscow", "Rostov", "Tigre"], difficulty: "Medium"),
        Question(question: "Средний вопрос? 6", answer: "BA", options: ["BA", "Moscow", "Rostov", "Tigre"], difficulty: "Medium"),
        Question(question: "Средний вопрос? 7", answer: "BA", options: ["BA", "Moscow", "Rostov", "Tigre"], difficulty: "Medium"),
        Question(question: "Сложный вопрос? 1", answer: "BA", options: ["BA", "Moscow", "Rostov", "Tigre"], difficulty: "Hard"),
        Question(question: "Сложный вопрос? 2", answer: "BA", options: ["BA", "Moscow", "Rostov", "Tigre"], difficulty: "Hard"),
        Question(question: "Сложный вопрос? 3", answer: "BA", options: ["BA", "Moscow", "Rostov", "Tigre"], difficulty: "Hard"),
        Question(question: "Сложный вопрос? 4", answer: "BA", options: ["BA", "Moscow", "Rostov", "Tigre"], difficulty: "Hard"),
        Question(question: "Сложный вопрос? 5", answer: "BA", options: ["BA", "Moscow", "Rostov", "Tigre"], difficulty: "Hard"),
        Question(question: "Сложный вопрос? 6", answer: "BA", options: ["BA", "Moscow", "Rostov", "Tigre"], difficulty: "Hard"),
        Question(question: "Сложный вопрос? 7", answer: "BA", options: ["BA", "Moscow", "Rostov", "Tigre"], difficulty: "Hard")
    ]
}

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
            score += 1
        } else {
            isGameOver.toggle()
            return isCorrect
        }

        questionNumber += 1
        loadNextQuestion()
        
        return isCorrect
    }
}
