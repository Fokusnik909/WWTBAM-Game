//
//  SplashView.swift
//  WWTBAM-Game
//
//  Created by Артур  Арсланов on 24.07.2025.
//

import SwiftUI

struct SplashView: View {
    
@EnvironmentObject private var router: Router
//    var onFinish: () -> Void

    var body: some View {
        ZStack {
            Image(.background)
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()

            Image(.logo)
                .frame(width: 195, height: 195)
                .padding(24)
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                router.push(to: .mainMenu(model: MainMenuViewModel()))
            }
        }
    }
}


#Preview {
//    SplashView(onFinish: {  })
    
    SplashView()
        .environmentObject(Router())
}
