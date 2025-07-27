//
//  GameView.swift
//  WWTBAM-Game
//
//  Created by Николай Игнатов on 21.07.2025.
//

import SwiftUI

struct GameView: View {
    
    @EnvironmentObject private var router: Router
    
    let model: GameModel
    
    var body: some View {
        ZStack {
            Image(.background)
                .resizable()
                .ignoresSafeArea()

            VStack() {
                GameNavBar(title: model.question.title, price: model.question.price)
                
                Spacer()
                    .frame(height: 32)
                
                //TimerView(time: model.remainingTime)
                
                Spacer()
                    .frame(height: 24)
                
                Text(model.question.questionText)
                    .multilineTextAlignment(.center)
                    .font(.title3.bold())
                    .foregroundColor(.white)
                    .padding(.horizontal)
                
                Spacer()
                
                VStack(spacing: 12) {
                    ForEach(Array(model.question.answers.enumerated()), id: \.offset) { index, answer in
                        AnswerButton(
                            index: index,
                            text: answer.answerText,
                            state: answer.state) {
                                
                                router.push(to: .resultView(state: GameProgress(state: .nextLevel, numberOfQuestion: 3)))
                            
                            }
                    }
                }
                .padding(.horizontal)
                /*
                HintButtonsView(hints: model.hints)
                    .padding(.top, 16)
                 */
            }
            .padding(.vertical)
            .padding(.horizontal)
        }
    }
}

#Preview {
    GameView(model: MockData.correctAnswerState)
        .environmentObject(Router())
}

// FIXME: - Выпилить
struct MockData {
    static var normalState: GameModel {
        GameModel(
            question: GameModel.Question(
                title: "QUESTION #1",
                price: "$500",
                questionText: "What year was the year, when first deodorant was invented in our life?",
                answers: [
                    .init(answerText: "First answer option", state: .normal),
                    .init(answerText: "Second answer option", state: .normal),
                    .init(answerText: "Third answer option", state: .normal),
                    .init(answerText: "Fourth answer option", state: .normal)
                ]
            ),
            remainingTime: 24,
            hints: [
                .init(isEnabled: true, type: .fiftyFifty),
                .init(isEnabled: true, type: .people),
                .init(isEnabled: true, type: .call)
            ]
        )
    }
    
    static var correctAnswerState: GameModel {
        GameModel(
            question: GameModel.Question(
                title: "QUESTION #1",
                price: "$500",
                questionText: "What year was the year, when first deodorant was invented in our life?",
                answers: [
                    .init(answerText: "First answer option", state: .normal),
                    .init(answerText: "Second answer option", state: .normal),
                    .init(answerText: "Third answer option", state: .correct),
                    .init(answerText: "Fourth answer option", state: .normal)
                ]
            ),
            remainingTime: 12,
            hints: [
                .init(isEnabled: false, type: .fiftyFifty),
                .init(isEnabled: true, type: .people),
                .init(isEnabled: true, type: .call)
            ]
        )
    }
    
    static var incorrectAnswerState: GameModel {
        GameModel(
            question: GameModel.Question(
                title: "QUESTION #1",
                price: "$500",
                questionText: "What year was the year, when first deodorant was invented in our life?",
                answers: [
                    .init(answerText: "First answer option", state: .disabled),
                    .init(answerText: "Second answer option", state: .incorrect),
                    .init(answerText: "Third answer option", state: .correct),
                    .init(answerText: "Fourth answer option", state: .disabled)
                ]
            ),
            remainingTime: 3,
            hints: [
                .init(isEnabled: true, type: .fiftyFifty),
                .init(isEnabled: false, type: .people),
                .init(isEnabled: true, type: .call)
            ]
        )
    }
}
