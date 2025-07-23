//
//  Points.swift
//  WWTBAM-Game
//
//  Created by Dmitry Volkov on 22/07/2025.
//

import Foundation

enum Points: Int, CaseIterable {
    case one = 500
    case two = 1000
    case three = 2000
    case four = 3000
    case five = 5000
    case six = 7500
    case seven = 10000
    case eight = 12500
    case nine = 15000
    case ten = 25000
    case eleven = 50000
    case twelve = 100000
    case thirteen = 250000
    case fourteen = 500000
    case fifteen = 1000000

    var displayValue: String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        let formatted = formatter.string(from: NSNumber(value: self.rawValue)) ?? "\(self.rawValue)"
        return "$ \(formatted)"
    }

    static func prize(forQuestionNumber index: Int) -> String {
        guard index >= 0 && index < Points.allCases.count else { return "$ 0" }
        return Points.allCases[index].displayValue
    }
}
