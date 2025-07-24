//
//  Question.swift
//  WWTBAM-Game
//
//  Created by Dmitry Volkov on 22/07/2025.
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
