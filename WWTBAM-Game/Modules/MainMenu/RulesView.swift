//
//  RulesView.swift
//  WWTBAM-Game
//
//  Created by Артур  Арсланов on 24.07.2025.
//
import SwiftUI

struct RulesView: View {
    @Environment(\.dismiss) private var dismiss

    init() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor(Color(hex: "#1C1C2D"))
        appearance.titleTextAttributes = [.foregroundColor: UIColor.white]

        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
    }

    var body: some View {
        NavigationView {
            List {
                Section() {
                    ForEach(rules, id: \.self) { rule in
                        Text(rule)
                            .font(.sfCompact(.regular, size: 18))
                            .foregroundColor(.white)
                            .padding(.vertical, 6)
                            .listRowBackground(Color(hex: "#1C1C2D"))
                    }
                }
            }
            .background(Color(hex: "#1C1C2D"))
            .scrollContentBackground(.hidden)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("Rules")
                        .font(.headline)
                        .foregroundColor(.white)
                }
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Close") {
                        dismiss()
                    }
                    .foregroundColor(.blue)
                }
            }
        }
        .background(Color(hex: "#1C1C2D"))
        .ignoresSafeArea()
    }
}

private let rules: [String] = [
        "В игре вам предстоит ответить на 15 вопросов.",
        "Каждый вопрос имеет 4 варианта ответа, только один из которых правильный.",
        "За каждый правильный ответ вы поднимаетесь на ступень выше.",
        "Некоторые уровни являются несгораемыми (например, 5 и 10).",
        "Вы можете воспользоваться тремя подсказками:",
        "   1. 50/50 — убирает два неправильных варианта.",
        "   2. Помощь зала — показывает, как бы проголосовали зрители.",
        "   3. Звонок другу — имитирует совет условного друга.",
        "Игра заканчивается, если вы:",
        "   – ошиблись,",
        "   – отказались от ответа,",
        "   – достигли последнего вопроса.",
        "Максимальный выигрыш — 1 миллион!",
        "Удачи!"
    ]


#Preview {
    RulesView()
}
