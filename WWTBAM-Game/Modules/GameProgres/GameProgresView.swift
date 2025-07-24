//
//  GameProgresView.swift
//  WWTBAM-Game
//
//  Created by Sergey on 21.07.2025.
//

import SwiftUI

struct GameProgresView: View {
    
    @EnvironmentObject private var router: Router
    
    @State private var gameLogo = "logo1"
    @State private var dollarLogo = "withdrawal"
    @State var progress: GameProgress
    
    @State private var curTime = 0
    var countDown = 4
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    @State private var isTimeUp = false
    
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
                            
                            if 0-index == progress.numberOfQuestion {
                                GameStateLabel(title: String(0-index), prize: progress.amount[0-index-1], style: .green) {
                                    
                                }
                                .blinking(duration: 0.5)
                                .padding(11)
                                
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
                        
                        if progress.state != .nextLevel {
                            routeToFinish()
                            
                            //                                NavigationLink(destination: FinishScreenView(state: FinishScreenState(level: progress.numberOfQuestion, score: progress.amount[progress.numberOfQuestion-1])), isActive: $isTimeUp, label: {
                            //                                    Text("")
                            //                                })
                            //                                .onReceive(timer) { _ in
                            //                                    print("2")
                            //                                    if curTime == countDown {
                            //                                        self.timer.upstream.connect().cancel()
                            //                                        isTimeUp = true
                            //                                    } else {
                            //                                        self.curTime += 1
                            //                                    }
                            //                                }
                            
                            
                        } else {
                            
                            routeBack()
                            
                            //                    NavigationLink(destination: GameView(model: MockData.correctAnswerState), isActive: $isTimeUp, label: {
                            //                        Text("")
                            //                    })
                            //                    .onReceive(timer) { _ in
                            //                        print("2")
                            //                        if curTime == countDown {
                            //                            self.timer.upstream.connect().cancel()
                            //                            isTimeUp = true
                            //                        } else {
                            //                            self.curTime += 1
                            //                        }
                            //                    }
                            
                        }
                    }
            }
            
            
            
            
            
        }
    }
    
    func routeBack() {
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
            router.navigateBack()
        }
        
    }
    
    func routeToFinish() {
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
            router.push(to: .finishGameView(state: FinishScreenState(level: 10, score: "$ 15.000")))
        }
        
    }
    
}

#Preview {
    GameProgresView(progress: GameProgress(state: .nextLevel, numberOfQuestion: 3))
//        .environmentObject(Router())
}
