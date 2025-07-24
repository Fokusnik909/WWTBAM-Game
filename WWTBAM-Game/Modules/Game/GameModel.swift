//
//  GameModel.swift
//  WWTBAM-Game
//
//  Created by Николай Игнатов on 21.07.2025.
//

struct GameModel {
    let question: Question
    let remainingTime: Int
    let hints: [Hint]
    
    struct Hint {
        let isEnabled: Bool
        let type: HintType
        
        enum HintType {
            case call, people, fiftyFifty
        }
    }
    
    struct Question {
        let title: String
        let price: String
        let questionText: String
        let answers: [Answer]
        
        struct Answer {
            let answerText: String
            let state: AnswerState
        }
        
        enum AnswerState {
            case normal, correct, incorrect, disabled
        }
    }
}

