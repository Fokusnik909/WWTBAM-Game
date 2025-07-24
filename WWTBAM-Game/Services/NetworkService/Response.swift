//
//  Response.swift
//  WWTBAM-Game
//
//  Created by Николай Игнатов on 24.07.2025.
//

import Foundation

struct Response: Decodable {
    let results: [Question]
    
    struct Question: Decodable {
        let difficulty: String
        let question: String
        let correctAnswer: String
        let incorrectAnswers: [String]

        enum CodingKeys: String, CodingKey {
            case difficulty, question
            case correctAnswer = "correct_answer"
            case incorrectAnswers = "incorrect_answers"
        }
    }
}


