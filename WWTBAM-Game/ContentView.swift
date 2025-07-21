//
//  ContentView.swift
//  WWTBAM-Game
//
//  Created by Артур  Арсланов on 21.07.2025.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Text("Hello, world!")
                .font(.sfCompact(.regular, size: 24))
                
        }
        .padding()
        .onAppear() {
            for family in UIFont.familyNames.sorted() {
                let names = UIFont.fontNames(forFamilyName: family)
                print("Family: \(family), Names: \(names)") }
        }
    }
}

#Preview {
    ContentView()
}
// Family: SF Compact, Names: ["SFCompact-Regular", "SFCompact-Ultralight", "SFCompact-Thin", "SFCompact-Light", "SFCompact-Medium", "SFCompact-Semibold", "SFCompact-Bold", "SFCompact-Heavy", "SFCompact-Black"]

