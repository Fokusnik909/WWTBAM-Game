//
//  StatisticsService.swift
//  WWTBAM-Game
//
//  Created by Артур  Арсланов on 21.07.2025.
//
import Foundation

final class StatisticsService {
    private enum Keys: String {
        case BestGame
    }
    
    var bestGame: Int {
        get {
            UserDefaults.standard.integer(forKey: Keys.BestGame.rawValue)
        }
        set {
            let currentBest = UserDefaults.standard.integer(forKey: Keys.BestGame.rawValue)
            if newValue > currentBest {
                UserDefaults.standard.set(newValue, forKey: Keys.BestGame.rawValue)
            }
        }
    }
}
