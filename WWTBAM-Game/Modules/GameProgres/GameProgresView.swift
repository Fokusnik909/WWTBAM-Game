//
//  GameProgresView.swift
//  WWTBAM-Game
//
//  Created by Sergey on 21.07.2025.
//

import SwiftUI

struct GameProgresView: View {
    
    @EnvironmentObject private var router: Router
    
    var player = AudioPlayerService.shared
    
    @State private var gameLogo = "logo1"
    @State private var dollarLogo = "withdrawal"
    @State var progress: GameProgress
    @State private var indexOfPrize: Int?
    
    var body: some View {
        
        
        ZStack(alignment: .center) {
            
            Image("background")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
            VStack {
                Spacer(minLength: 94)
                ZStack{
                    VStack(alignment: .center, spacing: 7) {
                        
                        ForEach(-15..<0) { index in
                            
                            if progress.state == .gameOverLose && indexOfPrize != nil {
                                
                                if 0-index == indexOfPrize {
                                    
                                    GameStateLabel(title: String(0-index), prize: progress.amount[0-index-1], style: .skyBlue) {
                                        
                                    }
                                    .blinking(duration: 0.5)
                                    .padding(11)
                                    
                                }
                                
                            }
                            
                            if 0-index == progress.numberOfQuestion {
                                
                                switch self.progress.state {
                                case .gameOverLose:
                                    
                                    GameStateLabel(title: String(0-index), prize: progress.amount[0-index-1], style: .red) {
                                        
                                    }
                                    .blinking(duration: 0.5)
                                    .padding(11)
                                    
                                case .gameOverWin:
                                    
                                    GameStateLabel(title: String(0-index), prize: progress.amount[0-index-1], style: .gold) {
                                        
                                    }
                                    .blinking(duration: 0.5)
                                    .padding(11)
                                    
                                case .nextLevel:
                                    
                                    GameStateLabel(title: String(0-index), prize: progress.amount[0-index-1], style: .green) {
                                        
                                    }
                                    .blinking(duration: 0.5)
                                    .padding(11)
                                    
                                }
                                
                                
                            } else {
                                
                                switch index {
                                case -5, -10:
                                    GameStateLabel(title: String(0-index), prize: progress.amount[0-index-1], style: .skyBlue) {
                                        
                                    }
                                    .padding(11)
                                case -15:
                                    
                                    GameStateLabel(title: String(0-index), prize: progress.amount[0-index-1], style: .gold) {
                                        
                                    }
                                    .padding(11)
                                default:
                                    
                                    GameStateLabel(title: String(0-index), prize: progress.amount[0-index-1], style: .blueDark) {
                                        
                                    }
                                    .padding(11)
                                }
                            }
                        }
                    }
                    Image(dollarLogo)
                        .resizable()
                        .frame(width: 45, height: 45)
                        .offset(x:-165, y: -420)
                    Image(gameLogo)
                        .resizable()
                        .frame(width: 250, height: 250)
                        .offset(x:0, y: -360)
                    
                }
                Spacer()
                    .onAppear(){
                        
                        player.play(audioFile: .winner)
                        
                        if progress.state != .nextLevel {
                            routeToFinish()

                        } else {
                            
                            routeBack()

                        }
                    }
            }
            
            
            
            
            
        }
        
    }
    
    func getPrizeIndex(numberOfQuestion: Int) -> Int? {
        
        switch numberOfQuestion {
        case 15:
            return 15
        case 10..<15:
            return 10
        case 5...10:
            return 5
        default:
            return nil
        }
        
    }
    
    func routeBack() {
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
            router.navigateBack()
        }
        
    }
    
    func routeToFinish() {
        let finishState: FinishScreenState
        switch progress.state {
        case .gameOverWin:
            finishState = FinishScreenState(level: progress.numberOfQuestion,
                                            score: progress.amount[progress.numberOfQuestion-1],
                                            scoreInt: progress.amountInt[progress.numberOfQuestion-1])
            print("1", finishState)
        case .gameOverLose:
                
            indexOfPrize = getPrizeIndex(numberOfQuestion: progress.numberOfQuestion)
                
            if indexOfPrize != nil {
                finishState = FinishScreenState(level: progress.numberOfQuestion,
                                                score: progress.amount[indexOfPrize!-1],
                                                scoreInt: progress.amountInt[indexOfPrize!-1])
                print("2", finishState)
            } else {
                finishState = FinishScreenState(level: progress.numberOfQuestion,
                                                score: "$ 0",
                                                scoreInt: 0)
                print("3", finishState)
            }
            
        case .nextLevel:
            return
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
            router.push(to: .finishGameView(state: finishState))
        }
        
    }
    
}

#Preview {
    GameProgresView(progress: GameProgress(state: .nextLevel, numberOfQuestion: 3))
//        .environmentObject(Router())
}
