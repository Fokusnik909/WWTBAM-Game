//
//  GameService.swift
//  WWTBAM-Game
//
//  Created by Dmitry Volkov on 21/07/2025.
//

import Foundation

final class GameService: ObservableObject {
    static let shared = GameService()
    private let networkService = NetworkService()
    
    // MARK: — Публичные состояние для UI
    @Published private(set) var questionNumber = 0
    @Published private(set) var currentQuestion: Question?
    @Published private(set) var score = 0
    @Published private(set) var isGameOver = false
    
    // MARK: — Вопросы
    private(set) var questions = [Question]()
    
    private init() {
        loadQuestions()
    }
    
    // MARK: — Запуск новой игры
    func startGame() {
        score = 0
        questionNumber = 0
        isGameOver = false
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
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 3.5) {
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

private extension GameService {
    func loadQuestions() {
        Task {
            do {
                let apiQuestions = try await networkService.fetchQuestions()
                questions = map(apiQuestions)
                makeQuestions()
                loadNextQuestion()
            } catch {
                print("Failed to load questions: \(error.localizedDescription)")
            }
        }
    }
    
    func map(_ questions: [Response.Question]) -> [Question] {
        questions.map {
            let decodedQuestion = $0.question.htmlDecoded
            let decodedCorrect = $0.correctAnswer.htmlDecoded
            let decodedIncorrect = $0.incorrectAnswers.map { $0.htmlDecoded }
            
            var options = decodedIncorrect.map { Question.Answer(answerText: $0, state: .normal) }
            options.append(Question.Answer(answerText: decodedCorrect, state: .normal))
            options.shuffle()
            
            return Question(
                question: decodedQuestion,
                answer: decodedCorrect,
                options: options,
                difficulty: $0.difficulty
            )
        }
    }
    
    /// Генерация вопросов
    func makeQuestions() {
        // Разбиваем вопросы по сложности
        let easy = questions.filter { $0.difficulty == "easy" }.shuffled()
        let medium = questions.filter { $0.difficulty == "medium" }.shuffled()
        let hard = questions.filter { $0.difficulty == "hard" }.shuffled()
        
        // Берём до 5 из каждой
        var selected = Array(easy.prefix(5))
        selected += medium.prefix(5)
        selected += hard.prefix(5)
        
        // Если меньше 15, добираем оставшимися, в порядке сложности
        if selected.count < 15 {
            let remainingEasy = easy.dropFirst(min(5, easy.count))
            let remainingMedium = medium.dropFirst(min(5, medium.count))
            let remainingHard = hard.dropFirst(min(5, hard.count))
            
            let remaining = Array(remainingEasy) + Array(remainingMedium) + Array(remainingHard)
            let needed = 15 - selected.count
            
            selected += remaining.prefix(needed)
        }
        
        questions = selected
    }
}
