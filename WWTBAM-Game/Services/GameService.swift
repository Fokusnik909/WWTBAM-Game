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
    var options: [Answer]
    var difficulty: String
    
    struct Answer {
        let answerText: String
        var state: AnswerState
    }
    
    enum AnswerState {
        case normal, correct, incorrect, disabled
    }
}

struct MockQuestions {
    static let questions = [
        // MARK: - Easy
        Question(
            question: "What is the capital of France?",
            answer: "Paris",
            options: [
                .init(answerText: "Paris", state: .normal),
                .init(answerText: "London", state: .normal),
                .init(answerText: "Berlin", state: .normal),
                .init(answerText: "Rome", state: .normal)
            ],
            difficulty: "Easy"
        ),
        Question(
            question: "Which planet is known as the Red Planet?",
            answer: "Mars",
            options: [
                .init(answerText: "Earth", state: .normal),
                .init(answerText: "Venus", state: .normal),
                .init(answerText: "Mars", state: .normal),
                .init(answerText: "Jupiter", state: .normal)
            ],
            difficulty: "Easy"
        ),
        Question(
            question: "Which animal is known as man's best friend?",
            answer: "Dog",
            options: [
                .init(answerText: "Cat", state: .normal),
                .init(answerText: "Dog", state: .normal),
                .init(answerText: "Horse", state: .normal),
                .init(answerText: "Rabbit", state: .normal)
            ],
            difficulty: "Easy"
        ),
        Question(
            question: "How many legs does a spider have?",
            answer: "8",
            options: [
                .init(answerText: "6", state: .normal),
                .init(answerText: "8", state: .normal),
                .init(answerText: "10", state: .normal),
                .init(answerText: "12", state: .normal)
            ],
            difficulty: "Easy"
        ),
        Question(
            question: "Which ocean is the largest?",
            answer: "Pacific Ocean",
            options: [
                .init(answerText: "Atlantic Ocean", state: .normal),
                .init(answerText: "Indian Ocean", state: .normal),
                .init(answerText: "Pacific Ocean", state: .normal),
                .init(answerText: "Arctic Ocean", state: .normal)
            ],
            difficulty: "Easy"
        ),
        
        // MARK: - Medium
        Question(
            question: "What is the chemical symbol for gold?",
            answer: "Au",
            options: [
                .init(answerText: "Ag", state: .normal),
                .init(answerText: "Au", state: .normal),
                .init(answerText: "Gd", state: .normal),
                .init(answerText: "Go", state: .normal)
            ],
            difficulty: "Medium"
        ),
        Question(
            question: "Which country hosted the 2016 Summer Olympics?",
            answer: "Brazil",
            options: [
                .init(answerText: "China", state: .normal),
                .init(answerText: "Russia", state: .normal),
                .init(answerText: "Brazil", state: .normal),
                .init(answerText: "UK", state: .normal)
            ],
            difficulty: "Medium"
        ),
        Question(
            question: "Who wrote 'Romeo and Juliet'?",
            answer: "William Shakespeare",
            options: [
                .init(answerText: "Jane Austen", state: .normal),
                .init(answerText: "William Shakespeare", state: .normal),
                .init(answerText: "Charles Dickens", state: .normal),
                .init(answerText: "Mark Twain", state: .normal)
            ],
            difficulty: "Medium"
        ),
        Question(
            question: "How many elements are in the periodic table?",
            answer: "118",
            options: [
                .init(answerText: "104", state: .normal),
                .init(answerText: "110", state: .normal),
                .init(answerText: "118", state: .normal),
                .init(answerText: "120", state: .normal)
            ],
            difficulty: "Medium"
        ),
        Question(
            question: "What year did World War II end?",
            answer: "1945",
            options: [
                .init(answerText: "1942", state: .normal),
                .init(answerText: "1944", state: .normal),
                .init(answerText: "1945", state: .normal),
                .init(answerText: "1950", state: .normal)
            ],
            difficulty: "Medium"
        ),
        
        // MARK: - Hard
        Question(
            question: "Who developed the general theory of relativity?",
            answer: "Albert Einstein",
            options: [
                .init(answerText: "Isaac Newton", state: .normal),
                .init(answerText: "Niels Bohr", state: .normal),
                .init(answerText: "Albert Einstein", state: .normal),
                .init(answerText: "Stephen Hawking", state: .normal)
            ],
            difficulty: "Hard"
        ),
        Question(
            question: "What is the capital of New Zealand?",
            answer: "Wellington",
            options: [
                .init(answerText: "Auckland", state: .normal),
                .init(answerText: "Christchurch", state: .normal),
                .init(answerText: "Wellington", state: .normal),
                .init(answerText: "Hamilton", state: .normal)
            ],
            difficulty: "Hard"
        ),
        Question(
            question: "Which painter is known for cutting off his own ear?",
            answer: "Vincent van Gogh",
            options: [
                .init(answerText: "Claude Monet", state: .normal),
                .init(answerText: "Pablo Picasso", state: .normal),
                .init(answerText: "Vincent van Gogh", state: .normal),
                .init(answerText: "Leonardo da Vinci", state: .normal)
            ],
            difficulty: "Hard"
        ),
        Question(
            question: "What is the square root of 256?",
            answer: "16",
            options: [
                .init(answerText: "14", state: .normal),
                .init(answerText: "15", state: .normal),
                .init(answerText: "16", state: .normal),
                .init(answerText: "18", state: .normal)
            ],
            difficulty: "Hard"
        ),
        Question(
            question: "Which language has the most native speakers?",
            answer: "Mandarin Chinese",
            options: [
                .init(answerText: "English", state: .normal),
                .init(answerText: "Mandarin Chinese", state: .normal),
                .init(answerText: "Hindi", state: .normal),
                .init(answerText: "Spanish", state: .normal)
            ],
            difficulty: "Hard"
        )
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
