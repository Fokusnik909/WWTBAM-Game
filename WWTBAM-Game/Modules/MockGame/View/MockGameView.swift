//
//  MockGameView.swift
//  WWTBAM-Game
//
//  Created by Dmitry Volkov on 21/07/2025.
//

import SwiftUI

struct MockGameView: View {
    @StateObject private var viewModel = MockGameViewViewModel()
    
    var body: some View {
        let prize = Points.prize(forQuestionNumber: viewModel.questionNumber)
        
        ZStack {
            Image(.background)
                .resizable()
                .ignoresSafeArea()

            VStack() {
                GameNavBar(title: "Question №\(viewModel.questionNumber + 1)", price: prize)
                
                Spacer()
                    .frame(height: 32)
                
                TimerView(time: 25)
                
                Spacer()
                    .frame(height: 24)
                
                Text(viewModel.currentQuestion?.question ?? "")
                    .multilineTextAlignment(.center)
                    .font(.title3.bold())
                    .foregroundColor(.white)
                    .padding(.horizontal)
                
                Spacer()
                
                VStack(spacing: 12) {
                    if let options = viewModel.currentQuestion?.options {
                        ForEach(Array(options.enumerated()), id: \.offset) { index, answer in
                            AnswerButtonMock(
                                index: index,
                                text: answer.answerText,
                                state: answer.state
                            ) {
                                viewModel.choose(answer.answerText)
                            }
                        }
                    }
                }
                .padding(.horizontal)

                HintButtonsView(hints: [
                    .init(isEnabled: true, type: .fiftyFifty),
                    .init(isEnabled: true, type: .people),
                    .init(isEnabled: true, type: .call)
                ])
                .padding(.top, 16)

            }
            .padding(.vertical)
            .padding(.horizontal)
        }
        
    }
}
