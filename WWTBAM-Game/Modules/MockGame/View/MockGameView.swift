//
//  MockGameView.swift
//  WWTBAM-Game
//
//  Created by Dmitry Volkov on 21/07/2025.
//

import SwiftUI

struct MockGameView: View {
    @EnvironmentObject var router: Router
    @StateObject private var viewModel: MockGameViewViewModel
    @State private var showCallFriend = false
    @State private var showAudienceHelp = false
    
    @State private var hints: [GameModel.Hint] = [
        .init(isEnabled: true, type: .fiftyFifty),
        .init(isEnabled: true, type: .people),
        .init(isEnabled: true, type: .call)
    ]

    
    init(router: Router) {
        _viewModel = StateObject(wrappedValue: MockGameViewViewModel(router: router))
    }
    
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
                
                TimerView(timer: viewModel.timerService)
                
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
                                state: answer.state,
                                isHidden: viewModel.hiddenOptions.contains(answer.answerText)
                            ) {
                                viewModel.choose(answer.answerText)
                            }
                        }
                    }
                }
                .padding(.horizontal)

                HintButtonsView(
                    hints: $hints,
                    onCallTapped: {
                        showCallFriend = true
                    },
                    onAudienceTapped: {
                        showAudienceHelp = true
                    },
                    onFiftyFiftyTapped: {
                        viewModel.highlightFiftyFifty()
                    }
                )
                .padding(.top, 16)

            }
            .padding(.vertical)
            .padding(.horizontal)

            if showCallFriend {
                Color.black.opacity(0.4)
                    .ignoresSafeArea()
                    .onTapGesture {
                        withAnimation(.linear(duration: 0.1)) {
                            showCallFriend = false
                        }
                    }

                CallFriendView(answer: viewModel.currentQuestion?.answer ?? "none")
                    .onTapGesture {
                        withAnimation(.linear(duration: 0.1)) {
                            showCallFriend = false
                        }
                    }
                    .transition(.scale)
                    .zIndex(1)
            }
            if showAudienceHelp {
                Color.black.opacity(0.4)
                    .ignoresSafeArea()
                    .onTapGesture {
                        withAnimation(.linear(duration: 0.1)) {
                            showAudienceHelp = false
                        }
                    }
                let options = viewModel.currentQuestion?.options.map { $0.answerText } ?? []
                let correctAnswer = viewModel.currentQuestion?.answer ?? ""
                let correctIndex = options.firstIndex(of: correctAnswer) ?? 0
                let audienceData = viewModel.generateAudienceHelpPercentages(correctAnswerIndex: correctIndex)

                AudienceHelpView(answers: audienceData)
                    .onTapGesture {
                        withAnimation(.linear(duration: 0.1)) {
                            showAudienceHelp = false
                        }
                    }
                    .transition(.scale)
                    .zIndex(1)
            }
        }
    }
}
